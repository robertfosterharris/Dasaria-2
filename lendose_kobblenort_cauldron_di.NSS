#include "ginc_partymath"

void main()
{
	object oPC = GetLastDisturbed();
	string sQuestName = "lendose_toystore";
	int nItems = GetNumItems(OBJECT_SELF,"lendose_kobblenort_metal_itm") + GetNumItems(OBJECT_SELF,"n2_crft_ingiron");
	int nJournalEntry = GetHighJournalEntry(sQuestName,oPC);
	
	if (nItems > 24 && nJournalEntry == 1)
	{
		AddJournalQuestEntry(sQuestName,4,oPC,TRUE);
		FloatingTextStringOnCreature("A sufficient mass of iron has been placed inside the cauldron.",oPC,TRUE);
	}
}