// custom onDeath for Melinda
void main()
{
	object oPlayer = GetLocalObject(OBJECT_SELF,"oPlayer");
	AddJournalQuestEntry("2bridges_melinda",4,oPlayer,TRUE,FALSE,TRUE);	
}