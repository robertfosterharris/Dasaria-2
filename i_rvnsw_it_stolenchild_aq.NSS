//i_rvnsw_it_stolenchild_aq
// advance journal, prevent quest item hording
#include "nw_i0_plot"
#include "ginc_partymath"
void main()
{
	object oPC = GetModuleItemAcquiredBy();
	object oAcquired = GetModuleItemAcquired();
	string sTag = GetTag(oAcquired);
	
	if ( GetHighJournalEntry("ravenswatch_changeling",oPC) == 2)
	{
		AddJournalQuestEntry("ravenswatch_changeling",3,oPC,TRUE);
	}
	
	if (GetNumItems(oPC,sTag) > 1)
	{
		DestroyObject(oAcquired,0.0,FALSE);
	}
	
}