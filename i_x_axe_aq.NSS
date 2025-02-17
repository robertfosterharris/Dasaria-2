//i_x_axe_aq
// advance journal
#include "nw_i0_plot"
void main()
{
	object oPC = GetModuleItemAcquiredBy();
	object oAcquired = GetModuleItemAcquired();
	string sTag = GetTag(oAcquired);
	
	if ( GetJournalEntry("frst_dris_beholder",oPC) == 5)
	{
		AddJournalQuestEntry("frst_dris_beholder",6,oPC,TRUE);
	}

}