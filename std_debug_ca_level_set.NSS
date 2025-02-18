/*
	Set the PC to a specific level
*/

#include "std_i0_xp"

void main(int level)
{
	object oPC = GetPCSpeaker();
	int xp = xp_level_min(oPC, level);
	SetXP( oPC, xp );
}