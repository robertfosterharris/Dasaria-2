// do this when kov_sentinal dies
void main()
{
	object oKiller = GetLastKiller();
	AddJournalQuestEntry("akmill_writhehearts",81,oKiller);
}