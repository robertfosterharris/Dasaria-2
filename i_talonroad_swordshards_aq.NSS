#include "nw_i0_plot"
void main()
{
	int nEntry;
	object oPC;
	object oAcquired;
	string sTag;

	oPC = GetModuleItemAcquiredBy();
	nEntry = GetJournalEntry("talonroad_relics",oPC);
	oAcquired = GetModuleItemAcquired();
	sTag = GetTag(oAcquired);
	
	// were on the quest and we haven't picked up the item yet
	if ( (nEntry > 0) &&
		 (nEntry < 5) &&
		 ( GetJournalEntry("talonroad_relics_sword",oPC) == 0)
		  )
	{	
		// advance the journal entry by one
		AddJournalQuestEntry("talonroad_relics",nEntry+1,oPC,TRUE);
		// mark us as having picked up the item	
		AddJournalQuestEntry("talonroad_relics_sword",1,oPC,TRUE);
	}
	
	// no duplicates!
	if (GetNumItems(oPC,sTag) > 1)
	{
		DestroyObject(oAcquired,0.0,FALSE);
	}
}