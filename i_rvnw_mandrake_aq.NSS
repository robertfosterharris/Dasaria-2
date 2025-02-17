//i_rvnw_mandrake_aq
// advance journal
#include "nw_i0_plot"
void main()
{
	object oPC = GetModuleItemAcquiredBy();
	object oAcquired = GetModuleItemAcquired();
	string sTag = GetTag(oAcquired);
	
	// the first time they get 2, advance the journal 
	// don't count on this for the hand-in though
	if ( GetJournalEntry("ravenswatch_mandrake",oPC) == 1)
	{
		if (GetNumItems(oPC,sTag) > 1)
		{
			AddJournalQuestEntry("ravenswatch_mandrake",2,oPC,TRUE);
		}		
	}
	// will think about this
	/*
	if (GetNumItems(oPC,sTag) > 1)
	{
		DestroyObject(oAcquired,0.0,FALSE);
	}
*/
}