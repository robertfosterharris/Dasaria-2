//i_rvnw_nightshade_aq
// advance journal
#include "nw_i0_plot"
void main()
{
	object oPC = GetModuleItemAcquiredBy();
	object oAcquired = GetModuleItemAcquired();
	string sTag = GetTag(oAcquired);
	
	// the first time they get 10, advance the journal 
	// don't count on this for the hand-in though
	if ( GetJournalEntry("ravenswatch_nightshade",oPC) == 1)
	{
		if (GetNumItems(oPC,sTag) > 9)
		{
			AddJournalQuestEntry("ravenswatch_nightshade",2,oPC,TRUE);
		}		
	}

}