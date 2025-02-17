//i_2bridges_setpimushead_aq
// advance journal, prevent quest item hording
#include "nw_i0_plot"
void main()
{
	object oPC = GetModuleItemAcquiredBy();
	object oAcquired = GetModuleItemAcquired();
	string sTag = GetTag(oAcquired);
	object oCorpse = GetNearestObjectByTag("2bridges_septimus");
	
	if ( GetJournalEntry("2bridges_verkethed",oPC) == 1)
	{
		AddJournalQuestEntry("2bridges_verkethed",2,oPC,TRUE);
	}
	
	if (GetNumItems(oPC,sTag) > 1)
	{
		DestroyObject(oAcquired,0.0,FALSE);
	}
	
	DestroyObject(oCorpse);
}