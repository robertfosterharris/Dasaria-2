//	INCLUDE FILE - FUNCTIONS USED BY THE TEMPLE OF BAHRAM PORTAL SYSTEM
//
//	06/26/2008	ROBERT HARRIS	ROBERTHARRIS@ROBERTHARRIS.COM

//
//	CREATES A PORTAL	
//
object CreatePortal(location lPortal)
{
	object oPortal;
	object oPortalSound;
	
	oPortal = CreateObject(OBJECT_TYPE_PLACEABLE, "totd_portal_mobile", lPortal);
	oPortalSound = CreateObject(OBJECT_TYPE_PLACEABLE, "totd_portal_sound", lPortal);

	DestroyObject(oPortal, 60.0);
	DestroyObject(oPortalSound, 60.0);
	
	return oPortal;
}
//
//	JUMPS THE PC TO THE PORTAL SPECIFIED
//
void JumpToPortal(object oPC, object oPortal)
{
	if (GetIsObjectValid(oPortal))
	{
		AssignCommand(oPC, ActionJumpToObject(oPortal));
	}
	else
	{
		SendMessageToPC(oPC, "The portal failed to open on the other end.");
	}
}