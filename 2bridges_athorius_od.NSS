// custom onDeath for Athorius
void main()
{
	object oPlayer = GetLocalObject(OBJECT_SELF,"oPlayer");
	AddJournalQuestEntry("2bridges_elias",4,oPlayer,TRUE,FALSE,TRUE);	
}