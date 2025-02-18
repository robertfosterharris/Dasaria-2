// lendol_grove_prisoner_de
// wired 2010-08-23
//
void main()
{
	object oArea = GetArea(OBJECT_SELF);
	object oLeader = GetLocalObject(oArea,"oPartyLeader");
	
	AddJournalQuestEntry("lendose_ol_grove",3,oLeader,TRUE,FALSE);

}