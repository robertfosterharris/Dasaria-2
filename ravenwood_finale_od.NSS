// rvnw_finale_od
void main()
{

    object oKiller = GetLastKiller();
    if (GetIsObjectValid(oKiller) == TRUE)
    {
        if (GetIsObjectValid(GetMaster(oKiller)) == TRUE)
        {
            oKiller = GetMaster(oKiller);
        }
	}

		//Who am I?
		if (GetTag(OBJECT_SELF) == "rvnw_locksley")
		{		
			AddJournalQuestEntry("ravenswood_embers", 53, oKiller,TRUE);
		}
		
		if (GetTag(OBJECT_SELF) == "rvnw_praetor_pontius")
		{
			AddJournalQuestEntry("ravenswood_embers", 52, oKiller,TRUE);
		}
}