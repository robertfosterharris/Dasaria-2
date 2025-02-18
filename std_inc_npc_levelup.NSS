// wired 1/2/08
// std_inc_npc_levelup
// this made no sense, works now

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
void LevelMeUpTo(object oCreature, int nLevelUpTo, int nClass =CLASS_TYPE_INVALID, int bReadySpells = TRUE)
{
	int nCurrLevel;

	nCurrLevel = GetHitDice(oCreature);
	if (nCurrLevel >= nLevelUpTo)
	{
		return;    // creature already has that level
	}
	  
	while (nCurrLevel < (nLevelUpTo) )
	{
		LevelUpHenchman(oCreature,nClass,bReadySpells);
		nCurrLevel = GetHitDice(oCreature);
	}
	
	FeatRemove(oCreature,FEAT_DISARM);
	FeatRemove(oCreature,FEAT_IMPROVED_DISARM);
}

// wrapper for LevelMeUpTo to be able to use it in DelayCommand
void DoLevelMeUpTo(object oCreature, int nLevel )
{
	LevelMeUpTo(oCreature, nLevel);
}