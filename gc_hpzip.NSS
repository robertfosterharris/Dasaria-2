// gc_hpzip
//
// because gc_dead don't work
// Wired 10/13/2007

int StartingConditional()
{
	object oPC = GetPCSpeaker();
	int nHP = GetCurrentHitPoints(oPC);
	if (nHP < 1) 
	{	
		// i'm dead
		return TRUE;
	}
	else
	{
		// i ain't
		return FALSE;
	}	
}