// ginc_lycan

// wired 03/13/2010	only apply lycantropy to PCs that are not already changed
// wired 06/08/2010 extend support for were-rat alternative
//					clean up for readability, maintainability
// wired 08/04/2010 aqdd support for vampires nLycan = 3
// wired 12/17/2010 move to a five-level system for better granularity
/*
171        POLYMORPH_TYPE_WEREWOLF_01           p_werewolf_male     23         316        ****          p_werewolf_claw_1    p_werewolf_claw_1    p_werewolf_bite1 lycan_hide1          ****             16   16   16   5              5       100      ****   ****   ****   ****   ****   ****   
172        POLYMORPH_TYPE_WEREWOLF_02           p_werewolf_male     23         316        ****          p_werewolf_claw_2    p_werewolf_claw_2    p_werewolf_bite2 lycan_hide2          ****             17   16   16   6              10      100      ****   ****   ****   ****   ****   ****   
173        POLYMORPH_TYPE_WEREWOLF_03           p_werewolf_male     23         316        ****          p_werewolf_claw_3    p_werewolf_claw_3    p_werewolf_bite3 lycan_hide3          ****             18   17   16   7              15      100      ****   ****   ****   ****   ****   ****   
174        POLYMORPH_TYPE_WEREWOLF_04           p_werewolf_male     23         316        ****          p_werewolf_claw_4    p_werewolf_claw_4    p_werewolf_bite4 lycan_hide4          ****             18   17   17   8              20      100      ****   ****   ****   ****   ****   ****   
175        POLYMORPH_TYPE_WEREWOLF_05           p_werewolf_male     23         316        ****          p_werewolf_claw_5    p_werewolf_claw_5    p_werewolf_bite5 lycan_hide5          ****             18   18   18   9              25      100      ****   ****   ****   ****   ****   ****   
176        POLYMORPH_TYPE_FEMWOLF_01            p_werewolf_female   23         316        ****          p_werewolf_claw_1    p_werewolf_claw_1    p_werewolf_bite1 lycan_hide1          ****             16   16   16   5              5       100      ****   ****   ****   ****   ****   ****   
177        POLYMORPH_TYPE_FEMWOLF_02            p_werewolf_female   23         316        ****          p_werewolf_claw_2    p_werewolf_claw_2    p_werewolf_bite2 lycan_hide2          ****             17   16   16   6              10      100      ****   ****   ****   ****   ****   ****   
178        POLYMORPH_TYPE_FEMWOLF_03            p_werewolf_female   23         316        ****          p_werewolf_claw_3    p_werewolf_claw_3    p_werewolf_bite3 lycan_hide3          ****             18   17   16   7              15      100      ****   ****   ****   ****   ****   ****   
179        POLYMORPH_TYPE_FEMWOLF_04            p_werewolf_female   23         316        ****          p_werewolf_claw_4    p_werewolf_claw_4    p_werewolf_bite4 lycan_hide4          ****             18   17   17   8              20      100      ****   ****   ****   ****   ****   ****   
180        POLYMORPH_TYPE_FEMWOLF_05            p_werewolf_female   23         316        ****          p_werewolf_claw_5    p_werewolf_claw_5    p_werewolf_bite5 lycan_hide5          ****             18   18   18   9              25      100      ****   ****   ****   ****   ****   ****   
181        POLYMORPH_TYPE_WERERAT_01            p_wererat           23         316        ****          p_wererat_claw_1     p_wererat_claw_1     p_wererat_bite1  lycan_hide1          ****             16   16   16   5              5       100      ****   ****   ****   ****   ****   ****   
182        POLYMORPH_TYPE_WERERAT_02            p_wererat           23         316        ****          p_wererat_claw_2     p_wererat_claw_2     p_wererat_bite2  lycan_hide2          ****             17   16   16   6              10      100      ****   ****   ****   ****   ****   ****   
183        POLYMORPH_TYPE_WERERAT_03            p_wererat           23         316        ****          p_wererat_claw_3     p_wererat_claw_3     p_wererat_bite3  lycan_hide3          ****             18   17   16   7              15      100      ****   ****   ****   ****   ****   ****   
184        POLYMORPH_TYPE_WERERAT_04            p_wererat           23         316        ****          p_wererat_claw_4     p_wererat_claw_4     p_wererat_bite4  lycan_hide4          ****             18   17   17   8              20      100      ****   ****   ****   ****   ****   ****   
185        POLYMORPH_TYPE_WERERAT_05            p_wererat           23         316        ****          p_wererat_claw_5     p_wererat_claw_5     p_wererat_bite5  lycan_hide5          ****             18   18   18   9              25      100      ****   ****   ****   ****   ****   ****   
*/


#include "std_quest_i0"
#include "d2_sql_log"


// Figure out which polymorph # to use from above 2da
int getShapeFromTypeAndHD(object oPC, int nLycan);

// Check if PC should un/shift by type and time of day
void CheckLycanChange(object oPC);

// Restore PC to normal
void LycanUnShift(object oPC);

// Shift PC into wereform
void LycanShift(object oPC, int nPoly = 171);

// Infect PC with lycantrophy 1=wolf 2=rat
void MakeLycan(object oPC, int nType = 1);

// Remove Disease
void CureLycan(object oPC);

// Apply Vampire Nighttime Effects
void DoLivingUndeath(object oPC);

// Apply Vampire Daylight Effects
void VampPenalty(object oPC, object oArea);

/*
		Implementation
*/

int getShapeFromTypeAndHD(object oPC, int nLycan)
{
	int nHD 	= GetHitDice(oPC);
	int nOffset = 0;
	int nBase;

	if (nLycan == 0) return 0;
	
	if (nHD < 5)  nOffset = 0;  // 1-4
	if (nHD > 4)  nOffset = 1;  // 5-9
	if (nHD > 9)  nOffset = 2;  // 10-14
	if (nHD > 14) nOffset = 3;  // 15-18
	if (nHD > 18) nOffset = 4;  // 19-20
	
	if (nLycan == 1 && GetGender(oPC) == GENDER_MALE)   nBase = 171;
	if (nLycan == 1 && GetGender(oPC) == GENDER_FEMALE) nBase = 176;
	if (nLycan == 2) nBase = 181;
	
	return nBase+nOffset;
}

void LycanShift(object oPC, int nPoly)
{
	object oJournal = std_journal_get( oPC );
	object oPlayer;
	effect ePoly;
	effect eVisual;	
		
	SendMessageToPC(oPC,"True night has fallen!");
	
	// get vampires out of the way
	if (nPoly == 0) 
	{
		DoLivingUndeath(oPC);
		return;
	}
	
	// advance the journal state
	// (more of a catch-up in case oPC is missing the journal entry for some reason
	persist_advance_single( oPC, "lycan", 0, 1, 0, "" );	
	
	oPlayer = GetFirstPC();
	
	while (GetIsObjectValid(oPlayer))
	{
		if ( !GetIsDM(oPlayer) && GetIsPC(oPlayer) && oPlayer != oPC )
		{
			SetPCDislike(oPC,oPlayer);				
		}
		oPlayer = GetNextPC();	
	}
	
	AdjustReputation(oPC,GetObjectByTag("d2_faction_cearguard"),-80);
	AdjustReputation(oPC,GetObjectByTag("d2_faction_commoner"),-80);
	AdjustReputation(oPC,GetObjectByTag("d2_faction_merchant"),-80);
	AdjustReputation(oPC,GetObjectByTag("d2_faction_defender"),-80);

	eVisual	= EffectVisualEffect(VFX_DUR_SPELL_FOX_CUNNING);
	ePoly 	= EffectPolymorph(nPoly,TRUE,FALSE);
	
	// wired 12/21/2010 set a weird spell ID so we can find this effect fast later
	ApplyEffectToObject(DURATION_TYPE_INSTANT, eVisual, oPC);
	ApplyEffectToObject(DURATION_TYPE_PERMANENT,SupernaturalEffect(SetEffectSpellId(ePoly,6667)),oPC);

	//SetLocalInt(oJournal,"wereform",1);
}

void LycanUnShift(object oPC)
{
	if (!GetIsObjectValid(oPC) || !GetIsPC(oPC) ) return;

	object oPlayer;
	effect eEff;
	object oJournal = std_journal_get( oPC );

	//DeleteLocalInt(oJournal,"wereform");
	
	SendMessageToPC(oPC,"Dawn has broken!");

    eEff = GetFirstEffect(oPC);
    while (GetIsEffectValid(eEff))
    {
    	if(GetEffectSpellId(eEff) == 6667 || GetEffectSpellId(eEff) == 6666)
        {
        	RemoveEffect(oPC, eEff);
			
			if ( GetEffectSpellId(eEff) == 6666 ) 
			{
				VampPenalty(oPC, GetArea(oPC));
				return;
			}
        }
        eEff=GetNextEffect(oPC);
	}	

	//ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectKnockdown(),oPC);
	
	// reset rep with NPCs
	AdjustReputation(oPC,GetObjectByTag("d2_faction_cearguard"),80);
	AdjustReputation(oPC,GetObjectByTag("d2_faction_commoner"),80);
	AdjustReputation(oPC,GetObjectByTag("d2_faction_merchant"),80);
	AdjustReputation(oPC,GetObjectByTag("d2_faction_defender"),80);

	// reset rep with PCs
	oPlayer = GetFirstPC();
	while (GetIsObjectValid(oPlayer))
	{
		if ( !GetIsDM(oPlayer) && GetIsPC(oPlayer) )
		{
			SetPCLike(oPC,oPlayer);				
		}
		oPlayer = GetNextPC();	
	}
}

void CheckLycanChange(object oPC)
{
	if (!GetIsObjectValid(oPC) || !GetIsPC(oPC)) return;

	int nPoly;
	int nCurrentHour = GetTimeHour();
	object oJournal = std_journal_get( oPC );
	int nLycan = GetLocalInt(oJournal,"nLycan");
	
	// this should never happen
	if (nLycan < 1) return;
	
	// get vampires out of the way
	if (nLycan == 3)  
	{
		// it's "night" and pc does not yet have effect 6666
		if (	(nCurrentHour < 6 || nCurrentHour >= 18) && !GetHasSpellEffect(6666,oPC) 	)
		{			
			LycanShift(oPC, 0);
		}
			
		// it's "day" (between 6am and 10pm) and pc has effect 6666 needing removal
		if (	(nCurrentHour >=6 && nCurrentHour < 18) ) // && GetHasSpellEffect(6666,oPC) 	)
		{	
			LycanUnShift(oPC);
		}	
		return;	
	}	
	
	// adjust for a deprecated variable that might be on any old werewolves
	if (GetLocalInt(oJournal,"werewolf") == 1)
	{
		SetLocalInt(oJournal,"nLycan",1);
		DeleteLocalInt(oJournal,"werewolf");
		nLycan = 1; 
	}
	
	// it's between 10pm & 6am and pc does not yet have effect 6667
	if (	(nCurrentHour < 6 || nCurrentHour >= 22) &&  !GetHasSpellEffect(6667,oPC)	)
	{
		LycanShift(oPC,getShapeFromTypeAndHD(oPC,nLycan));		
	}

	// it's between 6am and 10pm and has effect 6667 requiring removal
	if (	(nCurrentHour >=6 && nCurrentHour < 22) ) // &&  GetHasSpellEffect(6667,oPC)	)
	{	
		LycanUnShift(oPC);
	}
}

void MakeLycan(object oPC, int nType = 1)
{
	if (!GetIsObjectValid(oPC) || !GetIsPC(oPC)) return;
	
	object oJournal = std_journal_get( oPC );
	
	// paladins are immune to disease
	if (!GetLevelByClass(CLASS_TYPE_PALADIN,oPC) > 0)
	{
		SetLocalInt(oJournal,"nLycan",nType);
		CheckLycanChange(oPC);	
		persist_advance_single( oPC, "lycan", 0, 1, 0, "" );
	}
	
	WriteTimestampedLogEntry("LYCAN CREATED: "+GetName(oPC)+" ["+IntToString(GetHitDice(oPC))+"] "+GetLocalString(oPC, "PlayerName")+" ("+GetLocalString(oPC, "PlayerPublicCDKey")+") infected.");
	trackEvent(oPC,"LYCAN_CREATED",oPC,nType);
}

void CureLycan(object oPC)
{
	object oJournal = std_journal_get( oPC );
	int nLycan = GetLocalInt(oJournal,"nLycan");
	
	if (nLycan == 0)
	{
		SendMessageToPC(oPC,"This potion smells like wet dog and tastes worse, but appears to have no effect on you."); 
		return;		
	}
	
	if (nLycan == 3)
	{
		SendMessageToPC(oPC,"You are undead.  Vampirism cannot be cured."); 
		return;
	}	
	
	effect eff = GetFirstEffect(oPC);
    while (GetIsEffectValid(eff))
    {
    	if(GetEffectType(eff)==EFFECT_TYPE_POLYMORPH)
        {
        	RemoveEffect(oPC, eff);
 		}
         eff=GetNextEffect(oPC);
	}		
	//DeleteLocalInt(oJournal,"wereform");
	DeleteLocalInt(oJournal,"nLycan");
	ForceRest(oPC);	
	delete_quest( oPC, "lycan" );				// get rid of the peristent quest
	AddJournalQuestEntry("lycan",2,oPC,FALSE);	// add a nonpersistent "you're cured!"
	WriteTimestampedLogEntry("LYCAN CURE: "+GetName(oPC)+" ["+IntToString(GetHitDice(oPC))+"] "+GetLocalString(oPC, "PlayerName")+" ("+GetLocalString(oPC, "PlayerPublicCDKey")+") cured"); 
	trackEvent(oPC,"LYCAN_CURE");
}

void DoLivingUndeath(object oTarget)
{
	int nDecrease 			= 4;
	int nTemp 				= GetAbilityScore(oTarget, ABILITY_CHARISMA) - nDecrease;
	if (nTemp < 1)
		//nDecrease = abs(nTemp) + 1;
		nDecrease = nTemp + 3;
	if(GetAbilityScore(oTarget, ABILITY_CHARISMA) == 1)
		nDecrease = 0;
	effect eImmuneSA 		= EffectImmunity(IMMUNITY_TYPE_SNEAK_ATTACK);
	effect eImmuneCH		= EffectImmunity(IMMUNITY_TYPE_CRITICAL_HIT);
	effect eDecreaseChar	= EffectAbilityDecrease(ABILITY_CHARISMA, nDecrease);
	effect eVisual			= EffectVisualEffect(VFX_HIT_SPELL_LIVING_UNDEATH);
	effect eFrame			= EffectVisualEffect(VFX_DUR_SPELL_LIVING_UNDEATH);
	effect eLink 			= EffectLinkEffects(eImmuneSA, eImmuneCH);
	eLink 					= EffectLinkEffects(eLink, eDecreaseChar);
	eLink 					= EffectLinkEffects(eLink, eFrame);		
	ApplyEffectToObject(DURATION_TYPE_PERMANENT, SupernaturalEffect(SetEffectSpellId(eLink,6666)), oTarget);
	ApplyEffectToObject(DURATION_TYPE_INSTANT, eVisual, oTarget);
}

void VampPenalty(object oPC, object oArea)
{
	effect eEff;
	int nCurrentHour = GetTimeHour();

	// it's day, we're outside
	if ((nCurrentHour >= 6 && nCurrentHour < 18) && !GetIsAreaInterior(oArea))
	{
		// and we don't current have the penalty applied
		if (!GetHasSpellEffect(6667,oPC))
		{
			// apply it
			//effect eWhither = EffectRegenerate(-1,12.0);
			effect eWhither = EffectDamageOverTime(1, 6.0, DAMAGE_TYPE_ALL,TRUE);
			effect eCON = EffectAbilityDecrease(ABILITY_CONSTITUTION,4);
			effect eLink = EffectLinkEffects(eWhither, eCON);
			ApplyEffectToObject(DURATION_TYPE_PERMANENT, SupernaturalEffect(SetEffectSpellId(eLink,6667)), oPC);
			ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_HIT_SPELL_INFLICT_1), oPC);
		}
	}
	// otherwise remove the effect if we do have it
	// either it's nighttime or we've moved indoors
	else
	{
		if (GetHasSpellEffect(6667,oPC))
		{
		    eEff = GetFirstEffect(oPC);
		    while (GetIsEffectValid(eEff))
		    {
		    	if(GetEffectSpellId(eEff) == 6667)
		        {
		        	RemoveEffect(oPC, eEff);
		        }
		        eEff=GetNextEffect(oPC);
			}
		}
	}
}
//void main() {}