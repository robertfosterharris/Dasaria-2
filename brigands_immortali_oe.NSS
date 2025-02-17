// wired 1/2/08
// brigands_immportali_oe
// onenter event to fire assassins vs. brigands for event
#include "x0_i0_position"

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
	object oPC = GetEnteringObject();	
	if (GetIsPC(oPC))
	{
		string sPCName = GetStringLowerCase(GetName(oPC));
		if (FindSubString("isabella quickrhode wraighzephismergohannah coldkillerrobert blackwilliam dearbornsythe",sPCName) != -1)
		{ 
			if (GetLocalInt(oPC,"warned") != 1)
			{
				// send the warning
				string sMessage = "You feel the eyes of the Immortali upon you.  Tread lightly, <i>Brigand</i>, they could be anywhere!";
				DisplayMessageBox( oPC, 0, sMessage);
				// mark them warned
				SetLocalInt(oPC,"warned",1);
			}
			else
			{			
				// attack version
				object oBrig1 = CreateObject(OBJECT_TYPE_CREATURE,"brigands_immortal",GetOppositeLocation(oPC,DISTANCE_SHORT),TRUE);
				object oBrig2 = CreateObject(OBJECT_TYPE_CREATURE,"brigands_immortal",GetFlankingRightLocation(oPC,DISTANCE_SHORT),TRUE);
				object oBrig3 = CreateObject(OBJECT_TYPE_CREATURE,"brigands_immortal",GetFlankingLeftLocation(oPC,DISTANCE_SHORT),TRUE);
				
				int nLevel = GetHitDice(oPC);
				
				// level the opponents
				DelayCommand(1.0f,DoLevelMeUpTo(oBrig1,nLevel));
				DelayCommand(1.0f,DoLevelMeUpTo(oBrig2,nLevel));
				DelayCommand(1.0f,DoLevelMeUpTo(oBrig3,nLevel));
				
				// set hostile to oPC
				AdjustReputation(oPC,oBrig1,-50);
				AdjustReputation(oPC,oBrig2,-50);
				AdjustReputation(oPC,oBrig3,-50);				
				
				// Attack
				DelayCommand(1.0f,AssignCommand(oBrig1,ActionAttack(oPC)));
				DelayCommand(1.0f,AssignCommand(oBrig2,ActionAttack(oPC)));
				DelayCommand(1.0f,AssignCommand(oBrig2,ActionAttack(oPC)));
				
				//destroy and don't respawn
				DestroyObject(OBJECT_SELF);
			}									
		}
	}
	// else do nada
}