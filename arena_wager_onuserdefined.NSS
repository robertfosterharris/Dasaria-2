//  Wager Gladiator's OnUserDefined
#include "ginc_debug"
#include  "ginc_vars"
#include "NW_I0_GENERIC"
#include "nw_i0_plot"

void WhoAttackedMe(object oLastAttacker);	// prevents PCs from interfering
void GladiatorEndRound();					// check who's dead
void DeclareVictory(object oVictor);		// do a little dance

void main()
{
    int nUser = GetUserDefinedEventNumber();
	
    if(nUser == EVENT_HEARTBEAT ) //HEARTBEAT
    {

    }
    else if(nUser == EVENT_PERCEIVE) // PERCEIVE
    {

    }
    else if(nUser == EVENT_END_COMBAT_ROUND) // END OF COMBAT
    {
		GladiatorEndRound();
	}
    else if(nUser == EVENT_DIALOGUE) // ON DIALOGUE
    {

    }
    else if(nUser == EVENT_ATTACKED) // ATTACKED
    {
		object oLastAttacker = GetLastAttacker();
		WhoAttackedMe(oLastAttacker);
    }
    else if(nUser == EVENT_DAMAGED) // DAMAGED
    {

    }
    else if(nUser == EVENT_DISTURBED) // DISTURBED
    {

    }
	else if (nUser == EVENT_SPELL_CAST_AT) 	// 1011
    {
		object oLastAttacker = GetLastSpellCaster();
		WhoAttackedMe(oLastAttacker);
	}	
}

void WhoAttackedMe(object oLastAttacker)
{
	// Who attacked me?  If it's a PC, they need to be punished
	if ( GetIsPC(oLastAttacker))
	{			
		AssignCommand(oLastAttacker, PlaySound("as_wt_thundercl1"));
		//SendMessageToPC(oLastAttacker,"IT IS FORBIDDEN TO INTERFERE WITH A CONTEST");
		FloatingTextStringOnCreature("IT IS FORBIDDEN TO INTERFERE WITH A CONTEST",oLastAttacker);
		// What the heck, let's be kind and give them one warning
		//if (GetLocalInt(oLastAttacker,"warned") == TRUE )
		//{ 
	   		// Create the effect to apply
	    	effect eDamage = EffectDamage(150, DAMAGE_TYPE_DIVINE);	
	    	// Create the visual portion of the effect.
	    	effect eVis = EffectVisualEffect(VFX_IMP_FLAME_M);	
	    	// Apply the visual effect to the target
	    	ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oLastAttacker);
	    	// Apply the effect to the object   
	    	ApplyEffectToObject(DURATION_TYPE_INSTANT, eDamage, oLastAttacker);	
		//}
		//SetLocalInt(oLastAttacker,"warned",TRUE);		
	}
}

void GladiatorEndRound()
{
	object oPC = GetLocalObject(OBJECT_SELF,"oBettor");  
	object oRedFighter = GetObjectByTag("RedFighter");
	object oBlueFighter = GetObjectByTag("BlueFighter");
	object oBookie = GetObjectByTag("arena_marius");
	string sSelfTag = GetTag(OBJECT_SELF);
	int bHP = GetCurrentHitPoints(oBlueFighter);
	int rHP = GetCurrentHitPoints(oRedFighter);
		
	//SendMessageToPC(oPC,"Blue has" + IntToString(bHP) + "HP.");
	//SendMessageToPC(oPC,"Red has" + IntToString(rHP) + "HP.");
	if ( bHP < 1 && rHP < 1)
	{
		if ( IsMarkedAsDone() == TRUE ) return;
		AssignCommand(OBJECT_SELF, ClearAllActions());
		SendMessageToPC(oPC,"Both fighters have been slain.");
		DestroyObject(oBlueFighter, 1.0);
		DestroyObject(oRedFighter, 1.0);
			
		//free up marius for another bidder
		SetLocalInt(oBookie,"activefight",0);
		
		MusicBattleStop(GetArea(oPC));			
		//Unlock the door
		object oGate = GetObjectByTag("arena_gate");
		AssignCommand(oGate, SetLocked(oGate, FALSE));
		object oDoor = GetObjectByTag("arena_upper");
		AssignCommand(oDoor, SetLocked(oDoor, FALSE));
			
	}
	else
	{
		if ( bHP < 1 && sSelfTag == "RedFighter" )
		{
			if ( IsMarkedAsDone() == TRUE ) return;
			
			//set marius up for the payout
			AddJournalQuestEntry("wager",12,oPC,FALSE);
			int nGold = GetLocalInt(oBookie,"risk");
			int nWin = (nGold*2);
			GiveGoldToCreature(oPC,nWin,TRUE);
			AssignCommand(OBJECT_SELF, ClearAllActions());	
			SendMessageToPC(oPC,"Blue dies and Red Wins.");			
			DeclareVictory(oRedFighter);
		}	
		if ( rHP < 1 && sSelfTag == "BlueFighter" )
		{
			if ( IsMarkedAsDone() == TRUE ) return;	
			SendMessageToPC(oPC,"Red dies and Blue Wins.");			
			DeclareVictory(oBlueFighter);
			AddJournalQuestEntry("wager",13,oPC,FALSE);
		}
	}
}

void DeclareVictory(object oVictor)
{
	MarkAsDone();
	AssignCommand(oVictor,ClearAllActions(TRUE));
	
	// Take a bow
	ActionSpeakString("There can be only one!",TALKVOLUME_TALK);
	AssignCommand(oVictor, ActionPlayAnimation(ANIMATION_FIREFORGET_BOW));
	ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(566),oVictor);	
	MusicBattleStop(GetArea(oVictor));
	
	// Destroy Victor
	ActionMoveToObject(GetObjectByTag("arena_upper"));
	DestroyObject(oVictor, 3.0);	
	
	//free up marius for another bettor
	object oBookie = GetObjectByTag("arena_marius");
	SetLocalInt(oBookie,"activefight",0);
	DeleteLocalInt(oBookie,"risk");
				
	//Unlock the door
	object oGate = GetObjectByTag("arena_gate");
	AssignCommand(oGate, SetLocked(oGate, FALSE));
	object oDoor = GetObjectByTag("arena_upper");
	AssignCommand(oDoor, SetLocked(oDoor, FALSE));
}