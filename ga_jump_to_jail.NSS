// ga_jump_to_jail, do not pass go
#include "ginc_das_jail"

void main()
{
	object oPC = GetPCSpeaker();
	location lCell = GetOpenCell(oPC);
	AssignCommand( oPC, ActionJumpToLocation(lCell) );
}