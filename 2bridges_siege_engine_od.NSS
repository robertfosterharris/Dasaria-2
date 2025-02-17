// siege_engine_plc_respawn
#include "ginc_journal"
void main()
{
	object oLastHostileActor = GetLastHostileActor();
	int nEntry = GetJournalEntry("2bridges_siege",oLastHostileActor);
	if (nEntry == 1)
	{
		AddJournalQuestEntry("2bridges_siege",2,oLastHostileActor,TRUE,FALSE,FALSE);
	}
	if (nEntry == 2)
	{
		AddJournalQuestEntry("2bridges_siege",3,oLastHostileActor,TRUE,FALSE,FALSE);
		RewardPartyQuestXP(oLastHostileActor,"2bridges_siege");
	}
}