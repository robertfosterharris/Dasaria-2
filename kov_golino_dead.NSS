// do this when kov_golino dies
void main()
{
	object oKiller = GetLastKiller();
	AddJournalQuestEntry("akmill_writhehearts",51,oKiller);
}