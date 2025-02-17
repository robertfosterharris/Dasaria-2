// ga_dismount
// wired 01/29/2012
#include "std_inc_mounts"

void main()
{
	object oPC = GetPCSpeaker();
	ExecuteScript("gui_d2_dismount",oPC);
}