//	ON USED - JUMPS THE PC TO THE FIXED PORTAL
//
//	06/26/2008	ROBERT HARRIS	ROBERTHARRIS@ROBERTHARRIS.COM

#include "totd_portal_inc"

void main()
{
	object oPC;
	object oPortal;
	location lPortal;

	oPC = GetLastUsedBy();
	oPortal = GetObjectByTag("totd_portal_fixed");
	
	SetLocalLocation(oPC, "totd_portal_mobile", GetLocation(OBJECT_SELF));
	JumpToPortal(oPC, oPortal);
}