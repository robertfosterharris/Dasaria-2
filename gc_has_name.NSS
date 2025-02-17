int StartingConditional(string sFirstName, string sLastName)
{
	int bHasName;
	object oPC = GetPCSpeaker();
	
	bHasName = FALSE;
	if (	GetFirstName(oPC) == sFirstName
		&&	GetLastName(oPC) == sLastName
	)
	{
		bHasName = TRUE;
	}
	return bHasName;
}