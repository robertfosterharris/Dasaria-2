// ga_journal(string sCategoryTag, int nEntryID, int bAllPartyMembers, int bAllPlayers, int bAllowOverrideHigher)
/*
   Wrapper to add an entry to PCSpeaker's journal.
	
   Parameters:
     string sCategoryTag      = The tag of the Journal category (case sensitive).
     int nEntryID             = The ID of the Journal entry.
     int bAllPartyMembers     = If =1, the entry is added to the journal of all of oCreature's Party. (Default: =1) 
     int bAllPlayers          = If =1, the entry will show up in the journal of all PCs in the module. (Default: =0) 
     int bAllowOverrideHigher = If =1, override restriction that nState must be > current Journal Entry. (Default: =0) 
*/
// BMA-OEI 10/14/05
// BMA-OEI 1/11/06 removed default params

#include "d2_sql_log"

void main(string sCategoryTag, int nEntryID, int bAllPartyMembers, int bAllPlayers, int bAllowOverrideHigher)
{
	object oPC = (GetPCSpeaker()==OBJECT_INVALID?OBJECT_SELF:GetPCSpeaker());
	
	if (nEntryID == 1) 
	{
		trackEvent(oPC,"QUEST_INIT",OBJECT_INVALID,GetHitDice(oPC),1,sCategoryTag);
	}
	else
	{	
		trackEvent(oPC,"QUEST_ADVANCE",OBJECT_INVALID,GetHitDice(oPC),nEntryID,sCategoryTag);
	}	
	
	AddJournalQuestEntry(sCategoryTag, nEntryID, oPC, bAllPartyMembers, bAllPlayers, bAllowOverrideHigher);
}