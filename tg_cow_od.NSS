// tg_cow_od
#include "ginc_henchman"
#include "x0_i0_partywide"
#include "ginc_partymath"
	
void main()
{
	object oPlayer;	
	int nEntry;
	int nDeadCows;

	oPlayer 	=	GetLocalObject(OBJECT_SELF,"oPlayer");
	nDeadCows	=	GetHighLocalInt(oPlayer,"dead_cows");
	nEntry 		=	GetHighJournalEntry("tg_find_stock",oPlayer);

	// if i'm the third cow to die, the quest is over
	if (nDeadCows > 2)
	{
		AddJournalQuestEntry("tg_find_stock",8,oPlayer,TRUE,FALSE,TRUE);
		// despawn the rest of the herd
		DestroyAllHenchmenInParty(oPlayer);
	}
	else if (nEntry < 7) // skip if quest is already, so we don't roll back a completed quest	
	{	// otherwise just roll the player's journal entry back one
		// if he had four, it now says he has three
		AddJournalQuestEntry("tg_find_stock",nEntry-1,oPlayer,TRUE,FALSE,TRUE);
		
		// oh yeah, record my death as an int on the player too
		SetLocalIntOnAll(oPlayer,"dead_cows",nDeadCows+1);
	}
}