#include "nw_i0_plot"
void main()
{
	object oPC = GetModuleItemAcquiredBy();
	object oMember;
	string sItemTag = "rvn_demons_item3";
	int nItems;
	int nEntry = GetJournalEntry("ravenswatch_demons",oPC);
	
	if (nEntry > 6 &&
		nEntry < 9)
	{
		oMember = GetFirstFactionMember(oPC, FALSE);
		while (GetIsObjectValid(oMember))
		{
			nItems = nItems + GetNumItems(oMember, sItemTag);
			oMember = GetNextFactionMember(oPC, FALSE);
		}	
    if (nItems > 1)
		{	
			AddJournalQuestEntry("ravenswatch_demons",9,oPC,TRUE);
		}
	}		
}