// i_decor_ac
// wired 04/31/10

#include "ginc_playerhousing"

void main()
{

	object oItem = GetItemActivated();
	object oPC = GetItemActivator();
	object oTarget = GetItemActivatedTarget();

	location lLoc = GetItemActivatedTargetLocation();	
	PlaceDecor(oItem, oPC, lLoc, oTarget);

}