// arena_gladiator_DeathScript
//#include "X0_I0_PARTYWIDE"
#include "ginc_item"
#include "ginc_group"
void main()
{
	int nClone;
	int nCreature;
	int nEntry1;
	int nEntry2;
	object oBookie;
	object oGate;
	object oDoor;
	object oLastKiller;
	object oPig;
	object oHelm;
	
	oBookie 	= GetObjectByTag("arena_marius");
	oGate 		= GetObjectByTag("arena_gate");
	oDoor 		= GetObjectByTag("arena_upper");
	oLastKiller = GetLastHostileActor();
	oPig		= GetObjectByTag("blue_pig");
	nClone 		= GetLocalInt(OBJECT_SELF,"clone");	
	nCreature	= GetLocalInt(OBJECT_SELF,"creature");	
	
	SetIsDestroyable(TRUE,FALSE,FALSE);
	
	// allow pets to do the killing
	if (GetIsObjectValid(GetMaster(oLastKiller)) == TRUE)
    {
            oLastKiller = GetMaster(oLastKiller);
    }

	// Set up our commoner's group so we can send them a joint command
	if (!GetIsGroupValid("crowd"))
	{		
		GroupAddTag("crowd","arena_stupid_commoner1");
	}	
	
	// Debug Message
	FloatingTextStringOnCreature("You Win!",oLastKiller);
	
	// Make blue un-hate the PC
	AdjustReputation(oLastKiller,OBJECT_SELF,50);
	AdjustReputation(OBJECT_SELF,oLastKiller,50);
	
	if  (nClone == 1)
	{	
		nEntry2 = GetJournalEntry("barabus",oLastKiller);
		if (nEntry2 == 11) 
		{
			AddJournalQuestEntry("barabus",22,oLastKiller,FALSE); 
			RemoveItem (oLastKiller, "arena_barabus_helmet");
			GiveXPToCreature(oLastKiller,500);
		}
	}
	else if (nCreature == 1)
	{
		// Advance quest state on PC
		AddJournalQuestEntry("gladiator_creatures",3,oLastKiller,FALSE);
		if ( GetLocalInt(oLastKiller,"glad_creatures") == 5 ) AddJournalQuestEntry("gladiator_creatures",5,oLastKiller,FALSE);	
	}		
	else
	{ 			
		// Advance quest state on PC
		AddJournalQuestEntry("gladiator",3,oLastKiller,FALSE);
		if ( GetLocalInt(oLastKiller,"glad_fights") == 5 ) AddJournalQuestEntry("gladiator",5,oLastKiller,FALSE);
	}

	// Preen
	AssignCommand(oLastKiller, PlaySound("al_pl_crwdroar1"));
	AssignCommand(oLastKiller, ActionPlayAnimation(ANIMATION_FIREFORGET_BOW));
	ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(566),oLastKiller);
	FloatingTextStringOnCreature("There can be only one!",oLastKiller);
	GroupPlayAnimation("crowd",ANIMATION_FIREFORGET_VICTORY1);
		
	// grant a flat 10xp
	GiveXPToCreature(oLastKiller,10);
	
	MusicBattleStop(GetArea(OBJECT_SELF));
	
	// Allow Marius to start new fights
	SetLocalInt(oBookie,"activefight",0);
		
	// Open ze door
	AssignCommand(oGate, SetLocked(oGate, FALSE));
	AssignCommand(oDoor, SetLocked(oDoor, FALSE));
	
	DestroyObject(OBJECT_SELF);
}