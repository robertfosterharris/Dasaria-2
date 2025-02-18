// morell_packox_od
#include "ginc_partymath"
	
void main()
{
	object oPlayer;	
	int nEntry;

	oPlayer 	=	GetLocalObject(OBJECT_SELF,"oPlayer");
	nEntry 		=	GetHighJournalEntry("morell_delivery",oPlayer);

	if (nEntry > 1)
	{
		AddJournalQuestEntry("morell_delivery",4,oPlayer,TRUE,FALSE,TRUE);
	}
}