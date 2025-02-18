// sp_gtr_teleport
// wired 06/17/2011
//

#include "x2_inc_spellhook"
#include "x0_i0_partywide"
#include "ginc_spawnsystem"

const int bDEBUG = FALSE;

int CheckPartyGathered(object oPC);
void  SetTeleportTokens(object oPC, int iDasaria_Spawn_Upperbound);


void main()
{

    if (!X2PreSpellCastCode())
    {
    // If code within the PreSpellCastHook (i.e. UMD) reports FALSE, do not run this spell
        return;
    }
	
	object oPC 			= OBJECT_SELF;
	int nCasterLevel 	= GetCasterLevel(oPC);
	int nLimit 			= nCasterLevel/3;
	int nMembers		= GetNumberPartyMembers(oPC)-2;
	object oTarget 		= GetSpellTargetObject();
	

	// can't teleport if encumbered
	if (GetEncumbranceState(oPC) != ENCUMBRANCE_STATE_NORMAL)
	{
		SetModuleOverrideSpellScriptFinished();
		SendMessageToPC(oPC, "Spell Failed! You are encumbered and cannot cast this spell.");
		return;
	}
	
	// need 100gp
	if (GetGold(oPC) < 100)
	{
		SetModuleOverrideSpellScriptFinished();
		SendMessageToPC(oPC, "Spell Failed! You lack the material components necessary for this spell.");
		return;	
	}
	
	// You may also bring one per three caster levels. 
	if ( nMembers > nLimit)
	{
		SetModuleOverrideSpellScriptFinished();
		SendMessageToPC(oPC, "Spell Failed! There are too many members in your party.  You can transport a maximum of " +IntToString(nLimit)+ " additional party members at your Caster Level.");
		return;
	}
	
	// party must be gathered
	if (!CheckPartyGathered(oPC))
	{
		SetModuleOverrideSpellScriptFinished();
		SendMessageToPC(oPC, "Spell Failed! You must gather your party members  All creatures to be transported must be within close proximity or in contact with one another.");
		return;
	}
	
	if(oTarget == oPC)
	{
		SetLocalInt(oPC,"tel_target",1);
	}
	else if(GetTag(oTarget) == "d2_portal_stone")
	{
		SetLocalInt(oPC,"tel_target",2);
	}	
	
	SetTeleportTokens(oPC, DASARIA_SPAWN_UPPERBOUND);	
	ActionStartConversation(oPC,"mod_conv_teleport",TRUE,FALSE);	
}


int CheckPartyGathered(object oPC)
{
	if (bDEBUG) SendMessageToPC(oPC,"There are "+IntToString(GetNumberPartyMembers(oPC)-1)+" in the party.");

	object oMember = GetFirstFactionMember(oPC,1);
	while (GetIsObjectValid(oMember))
	{
		float fDist = GetDistanceBetween(oPC,oMember);
		if  ( (fDist > 2.0 || fDist == 0.0) && oMember != oPC)
		{
			return FALSE;
		}
		oMember = GetNextFactionMember(oPC,1);
	}
		return TRUE;
}


void SetTeleportTokens(object oPC, int iDasaria_Spawn_Upperbound)
{
	object oJournal = std_journal_get( oPC );
	int iTokenLoop;
	int iCustomToken = 1800;	
	int iCustomTokenR;
	string WayPointTag;
	string WayPointTag_Test;
	string sTokenName;	
	
		for(iTokenLoop = 0; iTokenLoop <= iDasaria_Spawn_Upperbound; iTokenLoop++)
		{
			WayPointTag = sConstruct_WP_TAG_String(iTokenLoop);
			WayPointTag_Test = GetLocalString(oJournal, WayPointTag );

			if(WayPointTag == WayPointTag_Test)
			{
				iCustomTokenR =	iCustomToken + iTokenLoop;
				sTokenName = sGet_NameorWaypoint(WayPointTag);
				SetCustomToken(iCustomTokenR,sTokenName);							
			}
		}

}