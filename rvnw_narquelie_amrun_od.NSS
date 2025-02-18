//rvnw_narquelie_amrun_od
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

	AddJournalQuestEntry("rvnwd_embers_reboot", 4, oKiller, 1,0,1);
}