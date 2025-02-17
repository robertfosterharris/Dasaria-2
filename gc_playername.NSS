// gc_playername
int StartingConditional(string sPlayerName)
{
	object oPC = GetPCSpeaker();
	
	if ( GetPCPlayerName(oPC) == sPlayerName )
		return TRUE;
	
	return FALSE;
}