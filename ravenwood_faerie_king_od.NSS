#include "ginc_journal"
void main()
{
    object oKiller = GetLastKiller();
    if (GetIsObjectValid(oKiller))
    {
        if (GetIsObjectValid(GetMaster(oKiller)) == TRUE)
        {
            oKiller = GetMaster(oKiller);
        }
	}
	// only if we chose to fight the king
	if (GetJournalEntry("ravenwood_faerie",oKiller) == 5)
	{
		// advance our journal and grant quest xp, keep the crown
		AddJournalQuestEntry("ravenwood_faerie",7,oKiller,TRUE);
		RewardPartyQuestXP(oKiller, "ravenwood_faerie");
	}
}