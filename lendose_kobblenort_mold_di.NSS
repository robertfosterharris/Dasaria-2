#include "ginc_partymath"

void main()
{
	object oPC = GetLastDisturbed();
	object oItem = GetInventoryDisturbItem();
	string sQuestName = "lendose_toystore";
	string sItemTag = "wiredevent_heart";
	int nJournalEntry = GetHighJournalEntry(sQuestName,oPC);
	
	if (GetTag(oItem) == sItemTag && nJournalEntry == 4)
	{
		AddJournalQuestEntry(sQuestName,5,oPC,TRUE);
		FloatingTextStringOnCreature("With a hard thud, the iron heart drops inside a chamber hidden deep inside the mold.",oPC,TRUE);
		DestroyObject(oItem);
	}
}