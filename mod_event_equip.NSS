// mod_event_equip
//
// wired 2009/12/19	move CON HP stacking anti-exploit code here 
// wired 2012/06/29 remove combat restriction on bullet casting exploit, add mysql print
//
#include "x2_inc_switches"
#include "x2_inc_itemprop"
#include "d2_sql_log"
//#include "ginc_item_spellresist"

void CauseFailure( object oTarget );
void cmi_conbonuscheck( object oItem, object oPC );

void main()
{
    object oItem = GetPCItemLastEquipped();
    object oPC   = GetPCItemLastEquippedBy();
	string PlayerName;
	string PlayerIPAddy;
	
	int nDmg;
	int nMaxHP;
	int nCurHP;
	effect eDmg;
	
	string sMsg;
	int iSpellId;
	string sName;
	object oTarget;
	int iSpellResistance;
		
	//	CON Item Swapping Anti-Exploit
	cmi_conbonuscheck( oItem, oPC );
	/*

	if ( IPGetItemHasProperty(oItem,ItemPropertyAbilityBonus (IP_CONST_ABILITY_CON, 1),-1)	)  // this traps +2 & +3 as well
	{	
		nCurHP		=	GetCurrentHitPoints(oPC);
		nMaxHP		=	GetMaxHitPoints(oPC);
		
		// Log the swap and alert any onlne DMs.  Exploiters 
		// would generate telltale repetitious entries
		//
		sMsg = GetName(oPC) + " swaps CON item " + GetName(oItem) +"; HP: "+IntToString(nCurHP)+"/"+IntToString(nMaxHP);
		SendMessageToAllDMs(sMsg);
		WriteTimestampedLogEntry (sMsg);	

		
		// If player has exceeded natural maximum, adjust downwards
		//			
		if (nCurHP > nMaxHP)
		{
			nDmg = nCurHP - nMaxHP;
			eDmg   = EffectDamage(nDmg,DAMAGE_TYPE_DIVINE,DAMAGE_POWER_ENERGY,TRUE);
			ApplyEffectToObject(DURATION_TYPE_INSTANT,eDmg,oPC); 
			SendMessageToPC(oPC,"Hitpoints calibrated to correct value.");		
		}
	}
	*/
	
	/*
	/	Item Swapping / Spellcasting Anti-Exploit	
	*/	
	if (GetCurrentAction(oPC)==ACTION_CASTSPELL)
	{
	
		PlayerIPAddy = GetPCIPAddress(oPC);
		PlayerName = GetPCPlayerName(oPC);
	
		// SKIP THIS IN THE PC-LOAD PHASE & WHEN POLYMORPHING
		if (GetLocalInt(oPC, "LOADING")) return; 
		
		//if (GetIsInCombat(oPC))
		//{
			sMsg = GetStringLowerCase(GetName(oItem));
			iSpellId = GetLocalInt(oPC, "LASTSPELL");
			sName = Get2DAString("spells", "Label", iSpellId) + "(" + IntToString(iSpellId) + ")";
			sMsg = GetName(oPC) + " swaps " + GetName(oItem) + " while casting " + sName;
			SendMessageToAllDMs(sMsg);
			CauseFailure( oPC );
			
			oTarget = GetAttemptedSpellTarget();
			
			if (GetIsPC(oTarget) && oTarget!=oPC && GetIsReactionTypeHostile(oTarget, oPC))
			{
				SendMessageToPC(oTarget, "You see " + GetName(oPC) + " equip " + GetName(oItem));
			}
			if (oTarget!=OBJECT_INVALID)
			{
				sMsg += " on " + GetName(oTarget);
			}
			
			// put this in the mysql EXPLOIT event logging later
			WriteTimestampedLogEntry (sMsg);
			trackEvent(oPC, "EXPLOIT_BULLETCAST", OBJECT_INVALID,0,0,GetLocalString(oPC, "PlayerName"),GetLocalString(oPC, "PlayerIPAddy"));
			
      	//}
   }

	
    // -------------------------------------------------------------------------
 

     // -------------------------------------------------------------------------
     // Generic Item Script Execution Code
     // If MODULE_SWITCH_EXECUTE_TAGBASED_SCRIPTS is set to TRUE on the module,
     // it will execute a script that has the same name as the item's tag
     // inside this script you can manage scripts for all events by checking against
     // GetUserDefinedItemEventNumber(). See x2_it_example.nss
     // -------------------------------------------------------------------------
     if (GetModuleSwitchValue(MODULE_SWITCH_ENABLE_TAGBASED_SCRIPTS) == TRUE)
     {
        SetUserDefinedItemEventNumber(X2_ITEM_EVENT_EQUIP);
        int nRet =   ExecuteScriptAndReturnInt(GetUserDefinedItemEventScriptName(oItem),OBJECT_SELF);
        if (nRet == X2_EXECUTE_SCRIPT_END)
        {
           return;
        }
     }

}

void CauseFailure( object oTarget )
{
   		//effect eSwapFailure = EffectSpellFailure(100);
		//eSwapFailure = EffectLinkEffects(eSwapFailure, EffectMissChance(100, MISS_CHANCE_TYPE_NORMAL ) );
		//ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eSwapFailure, oTarget, RoundsToSeconds( 1 ) );
		ClearAllActions(TRUE);
		AssignCommand(oTarget, ClearAllActions(TRUE));		
		//ActionWait( RoundsToSeconds( 2 ) );
}

void cmi_conbonuscheck( object oItem, object oPC )
{
	// make this a real preference
	int nDisableConFix = GetLocalInt(oPC, "DisableConFix");
	if (!nDisableConFix)
	{
		int nCurrentHitPoints;
		int nMaxHitPoints;	
		effect eHeal = EffectHeal(1);
		effect eDamage;
		int nConValue;
		int nHD = GetHitDice(oPC);
		int nTableValue;
		int nBase1 = (GetAbilityScore(OBJECT_SELF, ABILITY_CONSTITUTION, FALSE) + 1) / 2;
		int nBase2 = GetAbilityScore(OBJECT_SELF, ABILITY_CONSTITUTION, FALSE) / 2;
		int nConBonusCount;
		itemproperty iProp = GetFirstItemProperty(oItem);
		while (GetIsItemPropertyValid(iProp))
		{
			if (GetItemPropertyType(iProp) == ITEM_PROPERTY_ABILITY_BONUS)
			{	
				if (GetItemPropertySubType(iProp) == ABILITY_CONSTITUTION)
				{
					nCurrentHitPoints = GetCurrentHitPoints(oPC);
					nMaxHitPoints = GetMaxHitPoints(oPC);
					nConBonusCount = GetLocalInt(OBJECT_SELF, "ConBonusCount");
					nConBonusCount++;
					if (nCurrentHitPoints > nMaxHitPoints)
					{	
						DelayCommand(0.1f,ApplyEffectToObject(DURATION_TYPE_INSTANT, eHeal, oPC));	
					}
					else
					{
						if ((nBase1 - nBase2) > 0)
						{
							if (nConBonusCount > 1)
							{
								nConValue = ((GetItemPropertyCostTableValue(iProp) + 1)/2) * nHD;
								eDamage = EffectDamage(nConValue, DAMAGE_TYPE_POSITIVE, DAMAGE_POWER_NORMAL, TRUE);
								DelayCommand(0.1f,ApplyEffectToObject(DURATION_TYPE_INSTANT, eDamage, oPC));
								DelayCommand(0.2f, ClearAllActions(TRUE));
							}
						}
						else
						{
							nTableValue = GetItemPropertyCostTableValue(iProp);
							int nCon = GetAbilityScore(OBJECT_SELF, ABILITY_CONSTITUTION, FALSE);
							int nBase = GetAbilityScore(OBJECT_SELF, ABILITY_CONSTITUTION, TRUE);
							int	nBonus = StringToInt(Get2DAString("racialsubtypes.2da", "ConAdjust", GetSubRace(OBJECT_SELF)));
							
							int nAdjusted = nCon - (nBase + nBonus);
							if ((nAdjusted >= nTableValue) || (nConBonusCount == 1))
							{
								nConValue = (GetItemPropertyCostTableValue(iProp)/2) * nHD;
								eDamage = EffectDamage(nConValue, DAMAGE_TYPE_POSITIVE, DAMAGE_POWER_NORMAL, TRUE);
								DelayCommand(0.1f,ApplyEffectToObject(DURATION_TYPE_INSTANT, eDamage, oPC));
								DelayCommand(0.2f, ClearAllActions(TRUE));
							}
						}
	
					}
					SetLocalInt(OBJECT_SELF, "ConBonusCount", nConBonusCount); 												
				}																
			}
			iProp = GetNextItemProperty(oItem);	
		}	
	}
}
