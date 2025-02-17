// gc_event_nex_go_time
int StartingConditional()
{
	object oPC = GetPCSpeaker();
	string sPCName = GetStringLowerCase(GetName(oPC));
	if (FindSubString("wiredisabella quickrhode wraighzephismergohannah coldkillerrobert blackwilliam dearbornsythe",sPCName) != -1)
	{ 		
		return TRUE;
	}		
	else
	{
		SpeakString("You are not the one who was called for.",TALKVOLUME_WHISPER);
		return FALSE;
	}
}