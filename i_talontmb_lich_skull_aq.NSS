#include "nw_i0_plot"
void main()
{
	int nEntry;
	object oPC;
	object oAcquired;
	string sTag;

	oPC = GetModuleItemAcquiredBy();
	nEntry = GetJournalEntry("talontmb_lich",oPC);
	oAcquired = GetModuleItemAcquired();
	sTag = GetTag(oAcquired);
	
	// were on the quest and we haven't picked up the item yet
	if ( (nEntry == 3))
	{	
		// advance the journal entry by one
		AddJournalQuestEntry("talontmb_lich",4,oPC,TRUE);
	}
	
	// no duplicates!
	if (GetNumItems(oPC,sTag) > 1)
	{
		DestroyObject(oAcquired,0.0,FALSE);
	}
}