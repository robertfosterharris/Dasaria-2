// wired 11/09/2007
// assassin_savant_spawn
// spawn in 'the savant' directly behind the PC
#include "x0_i0_position"
void main()
{
	object oPC = GetPCSpeaker();
	location lLoc = GetBehindLocation(oPC);
	object oSavant = CreateObject(OBJECT_TYPE_CREATURE, "assassin_savant", lLoc, TRUE);
	AssignCommand(oSavant,DelayCommand(300.0,DestroyObject(oSavant)));
}