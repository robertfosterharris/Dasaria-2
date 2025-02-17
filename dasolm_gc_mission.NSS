// wired 08/04/2010
// crap out if you've completed a mission with
// the same tag as the thing you're talking to


#include "ginc_partymath"

int StartingConditional()
{
	object oPC = GetPCSpeaker();
	string sTag = GetTag(OBJECT_SELF);
	int nJE = GetHighJournalEntry(sTag, oPC);

	if (nJE >1)
	{	
		SendMessageToPC(oPC,"Your warparty has already completed its mission in this area.");
		return FALSE;		
	}
	return TRUE; 
}