//:://////////////////////////////////////////////////
//:: NW_C2_DEFAULT7
/*
  Default OnDeath event handler for NPCs.

  Adjusts killer's alignment if appropriate and
  alerts allies to our death. 
 */
//:://////////////////////////////////////////////////
//:: Copyright (c) 2002 Floodgate Entertainment
//:: Created By: Naomi Novik
//:: Created On: 12/22/2002
//:://////////////////////////////////////////////////
// chazm 5/6/05 added DeathScript
// ChazM 7/28/05 removed call to user defined event for onDeath
// ChazM - 1/26/07 - EvenFlw modifications
// ChazM -5/17/07 - Spirits don't drop crafting items, removed re-equip weapon code
// JSH-OEI 5/28/08 - NX2 campaign version.
//
//	RFH		05/07/09		ExecuteScript("pwfxp", OBJECT_SELF);
//	Wired	02/14/10		Log commoner, defender kills
//  Wired	06/24/11		Log to DB
//  wired	07/19/11		Skip a bunch of stuff if killer isn't a PC

#include "x2_inc_compon"
#include "x0_i0_spawncond"
#include "d2_sql_log"

void main()
{
	string sDeathScript = GetLocalString(OBJECT_SELF, "DeathScript");
	if (sDeathScript != "")
		ExecuteScript(sDeathScript, OBJECT_SELF);
	
    int nClass;
    int nAlign;
    object oKiller = GetLastKiller();
	
	if (GetIsObjectValid(GetMaster(oKiller) ))  oKiller = GetMaster(oKiller);

	if (GetIsPC(oKiller) )
	{
	    nClass = GetLevelByClass(CLASS_TYPE_COMMONER);
    	nAlign = GetAlignmentGoodEvil(OBJECT_SELF);
	
	    // If we're a good/neutral commoner,
	    // adjust the killer's alignment evil
	    if(nClass > 0 && (nAlign == ALIGNMENT_GOOD || nAlign == ALIGNMENT_NEUTRAL))
	    {
	        AdjustAlignment(oKiller, ALIGNMENT_EVIL, 5);
	    }
	
		// log kills of commoners, cear guards, defenders, and merchants by PCs
		if ( (nClass > 0) || GetFactionEqual(OBJECT_SELF,GetObjectByTag("d2_faction_cearguard")) || GetFactionEqual(OBJECT_SELF,GetObjectByTag("d2_faction_defender"))  || GetFactionEqual(OBJECT_SELF,GetObjectByTag("d2_faction_merchant"))    ) 
		{
			trackEvent(oKiller,"COMMONER_KILL",OBJECT_SELF,GetHitDice(OBJECT_SELF),GetHitDice(oKiller));
			WriteTimestampedLogEntry("NPC KILL: "+GetName(oKiller)+" ["+IntToString(GetHitDice(oKiller))+"] "+GetPCPlayerName(oKiller)+" ("+GetPCPublicCDKey(oKiller)+") kills "+GetName(OBJECT_SELF)+" ["+IntToString(GetHitDice(OBJECT_SELF))+"] in "+GetName(GetArea(OBJECT_SELF)));
		}
		
		ExecuteScript("pwfxp", OBJECT_SELF);	
	}
	
    // Call to allies to let them know we're dead
    SpeakString("NW_I_AM_DEAD", TALKVOLUME_SILENT_TALK);

    //Shout Attack my target, only works with the On Spawn In setup
    SpeakString("NW_ATTACK_MY_TARGET", TALKVOLUME_SILENT_TALK);
}