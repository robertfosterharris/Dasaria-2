int StartingConditional(string sPlayerName)
{
	int bIsPlayer;
	
	bIsPlayer = FALSE;
	if (GetPCPlayerName(OBJECT_SELF) == sPlayerName) bIsPlayer = TRUE;
	return bIsPlayer;
}