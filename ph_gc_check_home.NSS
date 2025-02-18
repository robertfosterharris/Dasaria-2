//
// gc_check_home
//

#include "ginc_playerhousing"

int StartingConditional(string sDoorTag)
{
	object oPC = GetPCSpeaker();
	if (sDoorTag == "") sDoorTag = GetTag(OBJECT_SELF);
	
	return CheckHome(oPC,sDoorTag);	
}