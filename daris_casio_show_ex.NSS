//  TRIGGER ON EXIT SCRIPT
//
//  CLEAN UP DARIS_CASIO_SHOW_EN
//
//  ROBERT HARRIS   ROBERTHARRIS@ROBERTHARRIS.COM   01/06/2010
//

void main()
{
	object oPC;
	
	oPC = GetExitingObject();
	if (GetIsPC(oPC))
	{
		DeleteLocalInt(oPC, GetTag(OBJECT_SELF) + "_ACTIVE");
	}
}