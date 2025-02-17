//kharadur_mai_od
// wired 08/23/09

void main()
{
	object oMaster = GetLocalObject(OBJECT_SELF,"oPlayer");	
	AddJournalQuestEntry("kharadur_rescue",4,oMaster,TRUE,FALSE,TRUE);
}