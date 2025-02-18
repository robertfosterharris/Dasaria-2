//	ON USED - RETURNS THE CHARACTER TO THE LOCATION WHERE THE MOBILE PORTAL WAS OPENED
//
//	06/26/2008	ROBERT HARRIS	ROBERTHARRIS@ROBERTHARRIS.COM

#include "totd_portal_inc"

void main()
{
	int bFound;
	int nNth;
	object oPC;
	object oPortal;
	object oPortalSound;
	location lPortal;

	bFound = FALSE;
	nNth = 0;
	oPC = GetLastUsedBy();
	oPortal = GetObjectByTag("totd_portal_mobile", nNth);
	lPortal = GetLocalLocation(oPC, "totd_portal_mobile");
	
	while(GetIsObjectValid(oPortal) && !bFound)
	{
		if (GetLocation(oPortal) == lPortal)
		{
			bFound = TRUE;
		}
		else
		{
			nNth++;
			oPortal = GetObjectByTag("totd_portal_mobile", nNth);
		}
	}
	
	if (!bFound) oPortal = CreatePortal(lPortal);
	JumpToPortal(oPC, oPortal);
}