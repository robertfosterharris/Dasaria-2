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
	if (GetJournalEntry("ravenwood_faerie",oKiller) == 2)
	{
		AddJournalQuestEntry("ravenwood_faerie",3,oKiller,TRUE);
	}
}