// ga_journal_increment
// wired 02/27/2010

#include "ginc_partymath"

void main(string sCategoryTag, int nAdvanceBy, int nMaxState, int bAllPartyMembers, int bAllPlayers, int bAllowOverrideHigher)
{
	object oPC = (GetPCSpeaker()==OBJECT_INVALID?OBJECT_SELF:GetPCSpeaker());
	
	int nEntryID	=	GetHighJournalEntry(sCategoryTag,oPC)+nAdvanceBy;
	
	if (nEntryID <= nMaxState)
	{	
		AddJournalQuestEntry(sCategoryTag, nEntryID, oPC, bAllPartyMembers, bAllPlayers, bAllowOverrideHigher);
	}
}