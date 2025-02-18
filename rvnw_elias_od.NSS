// rvnw_elias_od
void main()
{

    object oKiller = GetLastKiller();
    if (GetIsObjectValid(oKiller) == TRUE)
    {
        // * If I have a master then use him to determine the treasure
        if (GetIsObjectValid(GetMaster(oKiller)) == TRUE)
        {
            oKiller = GetMaster(oKiller);
        }
	}

	AddJournalQuestEntry("ravenswood_embers", 41, oKiller, 1,0,1);
}