// 2bridges_athorius_checkmaster (reverse of 2bridges_athorius_saveplayer)
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