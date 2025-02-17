int StartingConditional(string sFirstName)
{
	int bHasName;
	object oPC = GetPCSpeaker();
	
	bHasName = FALSE;
	if (	GetFirstName(oPC) == sFirstName		)
	{
		bHasName = TRUE;
	}
	return bHasName;
}