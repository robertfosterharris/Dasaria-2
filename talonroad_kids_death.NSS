void main()
{
	object oPC = GetLocalObject(OBJECT_SELF,"FREED_BY");
	int nEntry = GetJournalEntry("talonroad_fliers",oPC);

	if ( (nEntry == 8))
	{			
		AddJournalQuestEntry("talonroad_fliers",10,oPC,TRUE,FALSE,TRUE);
	}
}