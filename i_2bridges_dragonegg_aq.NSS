//2bridges_dragonegg
// advance journal, prevent quest item hording
#include "nw_i0_plot"
void main()
{
	object oPC = GetModuleItemAcquiredBy();
	object oAcquired = GetModuleItemAcquired();
	string sTag = GetTag(oAcquired);
	
	if ( GetJournalEntry("2bridges_dragon",oPC) == 1)
	{
		AddJournalQuestEntry("2bridges_dragon",2,oPC,TRUE);
	}
	
	if (GetNumItems(oPC,sTag) > 1)
	{
		DestroyObject(oAcquired,0.0,FALSE);
	}
}