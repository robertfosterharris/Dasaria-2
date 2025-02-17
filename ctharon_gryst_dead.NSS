// do this when arena_gryst dies
void main()
{
	object oKiller = GetLastKiller();
	AddJournalQuestEntry("cathedral",20,oKiller);
}