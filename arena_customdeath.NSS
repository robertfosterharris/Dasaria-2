#include "death_i0_bleed"

//////////////////////////////////////
// AdjustPlayerStats()////////////////
// Developed by: Wouter Dhondt////////
// Slightly modified by: bushido//////
//////////////////////////////////////
// Adjust Player Stats function///////
// Edited For Database By Knowj///////
//////////////////////////////////////
// Minor Das2 Edits: Wired 9/27/07
void AdjustPlayerStats(object oDied, object oKiller)
{
 if (!GetIsDM(oKiller) || !GetIsDM(oDied) )
 {
    // Increment or set the death variable
    int iDied = GetCampaignInt("SCORE", "iDied", oDied);
    ++iDied;
    SetCampaignInt("SCORE", "iDied", iDied, oDied);
    // Is this object a PC?
    if (GetIsPC(oKiller) == TRUE)
    {
        // Increment or set the killer var
        int iKilled = GetCampaignInt("SCORE", "iKilled", oKiller);
        ++iKilled;
        SetCampaignInt("SCORE", "iKilled", iKilled, oKiller);
    }
  }
}

// Raise OnDeath function
void Raise(object oPlayer)
{
        effect eBad = GetFirstEffect(oPlayer);
        ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectResurrection(),oPlayer);
        ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectHeal(GetMaxHitPoints(oPlayer)), oPlayer);

        //Search for negative effects
        while(GetIsEffectValid(eBad))
        {
            if (GetEffectType(eBad) == EFFECT_TYPE_ABILITY_DECREASE ||
                GetEffectType(eBad) == EFFECT_TYPE_AC_DECREASE ||
                GetEffectType(eBad) == EFFECT_TYPE_ATTACK_DECREASE ||
                GetEffectType(eBad) == EFFECT_TYPE_DAMAGE_DECREASE ||
                GetEffectType(eBad) == EFFECT_TYPE_DAMAGE_IMMUNITY_DECREASE ||
                GetEffectType(eBad) == EFFECT_TYPE_SAVING_THROW_DECREASE ||
                GetEffectType(eBad) == EFFECT_TYPE_SPELL_RESISTANCE_DECREASE ||
                GetEffectType(eBad) == EFFECT_TYPE_SKILL_DECREASE ||
                GetEffectType(eBad) == EFFECT_TYPE_BLINDNESS ||
                GetEffectType(eBad) == EFFECT_TYPE_DEAF ||
                GetEffectType(eBad) == EFFECT_TYPE_PARALYZE ||
                GetEffectType(eBad) == EFFECT_TYPE_NEGATIVELEVEL)
                {
                    //Remove effect if it is negative.
                    RemoveEffect(oPlayer, eBad);
                }
            eBad = GetNextEffect(oPlayer);
        }
        //Fire cast spell at event for the specified target
        SignalEvent(oPlayer, EventSpellCastAt(OBJECT_SELF, SPELL_RESTORATION, FALSE));
}

// Respawn/Teleporter OnDeath function
// Optionally you can create the waypoints described to send the dead player
// to their respective locations.
void Respawn(object oPlayer)
{
    string waiting = "Tharon shows me favor, I am restored.";
    if (GetIsDead(oPlayer))

        {
            Raise(oPlayer);
            AssignCommand(oPlayer, ClearAllActions());
            AssignCommand(oPlayer, ActionSpeakString(waiting, TALKVOLUME_TALK));
            DelayCommand(0.5, AssignCommand(oPlayer, JumpToObject(GetWaypointByTag("wp_arenarespawn"))));
        }

}

///////////////////////////////////////
// GladiatorDeath()
// Wired 9/27/07
// Ends the Gladiator Quest or Barbus Quest if Player Dies
//////////////////////////////////////
void GladiatorDeath(object oDied)
{
	int nClone;
	int nCreature;
	int nEntry1;
	int nEntry2;
	object oBookie;
	object oGate;
	object oDoor;
	object oBlueFighter;
	object oHelm;
	
	int debug = FALSE;

	if (debug) SendMessageToPC(oDied,"DEBUG: Entered GladiatorDeath()");
	oBookie = GetObjectByTag("arena_marius");
	oGate = GetObjectByTag("arena_gate");
	oDoor = GetObjectByTag("arena_upper");
	
	// don't take oKiller as an argument (just in case), just get rid of BlueFighter
	oBlueFighter = GetNearestObjectByTag("BlueFighter");
	nClone = GetLocalInt(oBlueFighter,"clone");
	nCreature = GetLocalInt(oBlueFighter,"creature");
	
	// Killer Bows and Exits
	DelayCommand(2.0,AssignCommand(oBlueFighter, ActionPlayAnimation(ANIMATION_FIREFORGET_BOW)));
	DelayCommand(3.0,ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(566),oBlueFighter));
	DestroyObject(oBlueFighter, 2.0);	
	
	AssignCommand(oDied, PlaySound("as_pl_soldierboo1"));

	if  (nClone == 1)
	{
		// can only get barabus quest if you've completed gladiator quest first
		nEntry2 = GetJournalEntry("barabus",oDied);
		if (nEntry2 == 11) 
		{
			AddJournalQuestEntry("barabus",23,oDied,FALSE); 
			// destroy the helmet
			oHelm = GetObjectByTag("arena_barabus_helmet");
			ActionUnequipItem(oHelm);
			DestroyObject(oHelm);
		}
	}
	if  (nCreature == 1)
	{
		// Advance quest state on PC
		AddJournalQuestEntry("gladiator_creatures",4,oDied,FALSE);
	}	
	else
	{				
		// Advance quest state on PC
		AddJournalQuestEntry("gladiator",4,oDied,FALSE);
	}
	
	// Make blue un-hate the PC
	AdjustReputation(oDied,oBlueFighter,50);
	AdjustReputation(oBlueFighter,oDied,50);
	
	// Allow Marius to start new fights
	DeleteLocalInt(oBookie,"activefight");
		
	// Open ze door
	AssignCommand(oGate, SetLocked(oGate, FALSE));
	AssignCommand(oDoor, SetLocked(oDoor, FALSE));
		
}

///////////////////////////////////////
// Wired 9/27/07
// Special things to do if a player dies on the Arena floor
//////////////////////////////////////
void main()
{	
	object oDied = OBJECT_SELF;
	object oArea = GetArea(OBJECT_SELF);
	object oKiller = GetLastHostileActor(oDied);
	SendMessageToPC(oDied,"There can be only one!");

	if (GetIsPC(oKiller))
	{
		// Run the PvP stats script
		AdjustPlayerStats(oDied,oKiller);
			
		///Begin kill/death messages			
		object oPC = GetFirstPC();
		int count = 0;
		int nVictims = GetCampaignInt("SCORE","iKilled", oKiller);
		string sKilled = GetName(oDied);
			
		//Send Message to all PC's
		sKilled += " was slain by ";
		sKilled += GetName(oKiller);
		sKilled += "\n";
		sKilled += GetName(oKiller);
		sKilled += " has ";
		sKilled += IntToString(nVictims);
		sKilled += " kills.";
			
		// do in oArea Only, shouldn't be server-wide
		while (GetIsPC(oPC) == TRUE)
		{
			if  (GetArea(oPC) == oArea) 
			{
		    	SendMessageToPC(oPC, sKilled);
		    	oPC = GetNextPC();
			}
		}
		
		//Respawn if nobody rez'd The Player
    	DelayCommand(5.0, Respawn(oDied));
	}
	// if it wasn't PvP, is oDied on a gladiator quest?
	else 
	{
		if (GetJournalEntry("gladiator",oDied) > 1 || GetJournalEntry("barabus",oDied) > 1 || GetJournalEntry("gladiator_creatures",oDied) > 1 )
		{
			// mark the quest failed, clean up opponent, etc.
			GladiatorDeath(oDied);
		}
		// Notify bleeding / death
		death_event_OnDeath( oDied );	
	}
}	