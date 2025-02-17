//i_2bridges_2bridges_lizardtail_true_aq
// advance journal
#include "nw_i0_plot"
void main()
{
	object oPC = GetModuleItemAcquiredBy();
	object oAcquired = GetModuleItemAcquired();
	string sTag = GetTag(oAcquired);
	
	if ( GetJournalEntry("2bridges_trueblood",oPC) < 1)
	{
		AddJournalQuestEntry("2bridges_trueblood",1,oPC,TRUE);
	}
	// will think about this
	/*
	if (GetNumItems(oPC,sTag) > 1)
	{
		DestroyObject(oAcquired,0.0,FALSE);
	}
*/
}