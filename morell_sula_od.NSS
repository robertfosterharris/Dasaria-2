//morell_sula_od
// wired 08/23/09
#include "ginc_partymath"
void main()
{
	object oMaster = GetLocalObject(OBJECT_SELF,"oPlayer");	
	AddJournalQuestEntry("morell_sula",3,oMaster,TRUE,FALSE,TRUE);
}