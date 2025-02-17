// advance journal, prevent quest item hording
// #include "nw_i0_plot"
void main()
{
	object oPC = GetModuleItemAcquiredBy();
	object oAcquired = GetModuleItemAcquired();
	string sTag = GetTag(oAcquired);
	
	if (GetJournalEntry("ravenwood_faerie",oPC) == 3)
	{
		AddJournalQuestEntry("ravenwood_faerie",4,oPC,TRUE);
	}
/*	if (GetNumItems(oPC,sTag) > 1)
	{
		DestroyObject(oAcquired,0.0,FALSE);
	}
*/
}