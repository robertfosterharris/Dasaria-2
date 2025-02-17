//	ON ACTIVATE - CREATES A PORTAL WHEN THE AMULET OF BAHRAM IS ACTIVATED
//
//	06/26/2008	ROBERT HARRIS	ROBERTHARRIS@ROBERTHARRIS.COM

#include "totd_portal_inc"

void main()
{
	location lLocation;
	object oArea;
	object oItem;
	object oPC;	
	string sArea;
	
	lLocation = GetItemActivatedTargetLocation();
	oArea = GetAreaFromLocation(lLocation);
	oItem = GetItemActivated();
	oPC = GetItemActivator();
	sArea = GetTag(oArea);
	
	if (sArea == "ceardocks" || sArea == "ceardocks_vissen_1" || sArea == "ceardocks_vissen_2")
	{
		CreatePortal(lLocation);
		DestroyObject(oItem);
	}
	else
	{
		SendMessageToPC(oPC, "The amulet glows ever so faintly but nothing happens.  Maybe it needs to be used closer to where it was found.");
	}		
}