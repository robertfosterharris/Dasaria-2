// do this when wr_krurg dies
void main()
{
	object oKiller = GetLastKiller();
	AddJournalQuestEntry("tr_worgriders",5,oKiller);
}