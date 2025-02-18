// trg_morell_corsair_crew
#include "ginc_partymath"

void main()
{
	object oPC = GetEnteringObject();
	if (!GetIsPC(oPC)) return;
	
	int nJE	= GetHighJournalEntry("morell_connection",oPC);
	
	if (nJE == 0)
	{
		AddJournalQuestEntry("morell_connection",1,oPC,TRUE);
	
	}
}