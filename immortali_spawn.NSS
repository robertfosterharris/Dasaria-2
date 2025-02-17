// level me up to at least -2HD from nearest player

#include "std_inc_npc_levelup"

void main()
{
	int nPCHD;
	object oPC;

	oPC = GetNearestCreature(CREATURE_TYPE_PLAYER_CHAR, PLAYER_CHAR_IS_PC);
	nPCHD = GetHitDice(oPC);
	DelayCommand(1.0f,DoLevelMeUpTo(OBJECT_SELF,nPCHD-2));
}