//  TRIGGER ON ENTER SCRIPT
//
//  CHECKS IF CONDITIONS ARE RIGHT TO START CASIOS MIDNIGHT SHOW
//
//  ROBERT HARRIS   ROBERTHARRIS@ROBERTHARRIS.COM   01/06/2010
//

void recursiveCheck(object oPC);

void main()
{
	object oPC;
	object oCasio;
	object oTicket;
	
	oPC = GetEnteringObject();
	
	if (GetIsPC(oPC))
	{
		SetLocalInt(oPC, GetTag(OBJECT_SELF) + "_ACTIVE", TRUE);
		recursiveCheck(oPC);
	}
}

void recursiveCheck(object oPC)
{

	object oTicket;
	
	if (GetLocalInt(oPC, GetTag(OBJECT_SELF) + "_ACTIVE"))
	{
		oTicket = GetItemPossessedBy(oPC, "daris_casio_ticket");
		
		if (GetIsObjectValid(oTicket) && GetTimeHour() == 0)
		{
			ExecuteScript("daris_casio_show", oPC);
		}
		else
		{
			DelayCommand(30.0, recursiveCheck(oPC));
		}
	}
}