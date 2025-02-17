#include "x0_i0_position"
#include "ginc_group"

//::///////////////////////////////////////////////
//:: LevelMeUpTo
//:: Copyright (c) 2003 Bioware Corp.
//:://////////////////////////////////////////////
/*
   Levels up a creature to the specified level
   will return TRUE if successful, FALSE if failed
   See LevelUpHenchman for details()
*/
//:://////////////////////////////////////////////
//:: Created By: Georg Zoeller
//:: Created On: 2003-07-25
//:://////////////////////////////////////////////
int LevelMeUpTo(object oCreature, int nLevelUpTo, int nClass =CLASS_TYPE_INVALID, int bReadySpells = TRUE)
{
  int nCurrLevel = GetHitDice(oCreature);
  //SendMessageToPC(GetFirstPC(),GetName(oCreature) + " is level " + IntToString(nCurrLevel) + " and wants to become level " + IntToString(nLevelUpTo));
  if (nCurrLevel >= nLevelUpTo)
  {
    return TRUE;    // creature already has that level
  }
  int nLevel = LevelUpHenchman(oCreature,nClass,bReadySpells);
  // level me up until I reach the required level or an error happens
  while (nLevel < (nLevelUpTo) && nLevel != 0)
  {
     // level up to thenext level
     //SendMessageToPC(GetFirstPC(),GetName(oCreature) + " is now level "+ IntToString(nLevel));
	 // wired 1/2/08 changed OBJECT_SELF to oCreature
     nLevel = LevelUpHenchman(oCreature,nClass,bReadySpells);
  }
  //SendMessageToPC(GetFirstPC(),GetName(oCreature) + " LevelUp returned "+ IntToString(nLevel));
  // verify success
  if (nLevel < nLevelUpTo)
  {
    return FALSE;
  }
  return TRUE;
}
// wrapper for LevelMeUpTo to be able to use it in DelayCommand
void DoLevelMeUpTo(object oCreature, int nLevel )
{
    int nRet = LevelMeUpTo(oCreature, nLevel);
    if (nRet == FALSE)
    {
        //SendMessageToPC(GetFirstPC(),"AutoLevelUp failed for " + GetTag(oCreature) + "!");
    }
}

void main()
{
	object oPC = GetPCSpeaker();				
	object oBrig1 = CreateObject(OBJECT_TYPE_CREATURE,"brigands_immortal",GetOppositeLocation(oPC,DISTANCE_SHORT),TRUE);
	object oBrig2 = CreateObject(OBJECT_TYPE_CREATURE,"brigands_immortal",GetFlankingRightLocation(oPC,DISTANCE_SHORT),TRUE);
					
	int nLevel = GetHitDice(oPC);
				
	// level the opponents
	DelayCommand(1.0f,DoLevelMeUpTo(oBrig1,nLevel));
	DelayCommand(1.0f,DoLevelMeUpTo(oBrig2,nLevel));
					
	// set hostile to oPC
	AdjustReputation(oPC,oBrig1,-50);
	AdjustReputation(oPC,oBrig2,-50);
					
	// Attack
	DelayCommand(1.0f,AssignCommand(oBrig1,ActionAttack(oPC)));
	DelayCommand(1.0f,AssignCommand(oBrig2,ActionAttack(oPC)));
		
	GroupSpawnAtWaypoint("kalem","guild_archer_male","WP_event_brigands_ritual",5);
	GroupSpawnAtWaypoint("kalem","guild_rogue_female","WP_event_brigands_ritual",5);
	GroupSpawnAtWaypoint("kalem","guild_rogue_female","WP_event_brigands_ritual",5);	
	GroupSpawnAtWaypoint("kalem","wiredevent_floey","WP_event_brigands_ritual",1);

}