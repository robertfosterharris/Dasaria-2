// unseen_casterbattle_start

#include "std_inc_npc_levelup"

void main(string sTemplate)
{
	object oPC = GetPCSpeaker();
	location lPCLoc = GetLocation(GetObjectByTag("casterbattle_spawn1"));
	location lOppLoc = GetLocation(GetObjectByTag("casterbattle_spawn2"));
	int nPCHD = GetHitDice(oPC);
	int nDiff = GetLocalInt(OBJECT_SELF,"nDiff");
	
	// destroy the actors and disable their encounter
	DestroyObject(GetNearestObjectByTag("ravenswatch_caster1"));
	DestroyObject(GetNearestObjectByTag("ravenswatch_caster2"));
	SetEncounterActive(FALSE,GetNearestObjectByTag("ravenswatch_casterbattle"));
	// add the activefight variable
	SetLocalInt(OBJECT_SELF,"activefight",1);
		
	// Create the Blue Fighter (PC is Red)	
	ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(99),lOppLoc);
	object oBlueFighter = CreateObject(OBJECT_TYPE_CREATURE, sTemplate, lOppLoc, TRUE);
	// Level him up!
	DelayCommand(1.0f,DoLevelMeUpTo(oBlueFighter,nPCHD+nDiff));
	
	//ChangeFaction(oBlueFighter,GetObjectByTag("blue_pig"));
	SetFirstName(oBlueFighter, RandomName());
	
	// Tell the Blue Fighter who they are fighting
	SetLocalObject(oBlueFighter,"oPCFighting",oPC);  
	// journal will be updated by ondeath() on PC Death, bluefighter on NPC death
		
	// Make blue hate the PC
	AdjustReputation(oPC,oBlueFighter,-50);
		
	// Position the PC in the arena
	ForceRest(oPC);	
	DelayCommand(0.5f,AssignCommand(oPC, ActionJumpToLocation(lPCLoc)));
	DelayCommand(0.5f,ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(99), oPC));
	AssignCommand(oPC,ActionUnequipItem(GetItemInSlot(INVENTORY_SLOT_RIGHTHAND,oPC) ));
	AssignCommand(oPC,ActionUnequipItem(GetItemInSlot(INVENTORY_SLOT_LEFTHAND,oPC) ));
	MusicBattlePlay(GetArea(OBJECT_SELF));
	
	//Attack!
	DelayCommand(2.0f,AssignCommand(oBlueFighter, ActionAttack(oPC)));
	
	// Error Recovery: Delete oBlueFighter after 7 minutes
	DelayCommand(420.0,DestroyObject(oBlueFighter, 2.0));
}