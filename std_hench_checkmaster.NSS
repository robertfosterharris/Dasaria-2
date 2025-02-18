// wired 09/07
// std_hench_checkmaster 
// are you my daddy?  rejoin master after client crash
int StartingConditional()
{
	object oPlayer = GetPCSpeaker();
	if (GetLocalObject(OBJECT_SELF,"oPlayer") == oPlayer)
	{
		return TRUE;
	}
	else
	{
		return FALSE;
	}
}