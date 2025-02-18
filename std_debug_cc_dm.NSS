/*
*/

int StartingConditional()
	{
	object oPC = GetPCSpeaker();
	
	if ( GetIsDM(oPC) || GetIsDMPossessed(oPC) )
		return TRUE;
	
	return FALSE;
	
	
	}


/*
*/