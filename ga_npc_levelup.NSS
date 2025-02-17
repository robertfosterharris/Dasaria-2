// ga_npc_levelup
#include "std_inc_npc_levelup"
void main()
{
	object oPC = GetPCSpeaker();
	object oNPC = OBJECT_SELF;
	int nLevel = GetHitDice(oPC);	
	// level the npc
	DelayCommand(1.0f,DoLevelMeUpTo(oNPC,nLevel));
}									