// gc_journal_entry_party
// wired 02/18/08
// check the whole party for the highest quest state
// this should stop quest repetition when someone joins
// a party who has already completed the quest

// wired 09/18/10 special check for OLM encounter exit
// using area tag as quest tag

#include "ginc_var_ops"
#include "ginc_partymath"

int StartingConditional(string sQuestTag, string sCheck)
{
	object oPC			=	GetPCSpeaker();
	if (sCheck == "$AREATAG") sCheck = GetTag(GetArea(oPC));
	int	nJournalEntry	= 	GetHighJournalEntry(sQuestTag,oPC);
	
	if ( CompareInts(nJournalEntry, sCheck) )
	{	
		return TRUE;		
	}
	return FALSE;
}