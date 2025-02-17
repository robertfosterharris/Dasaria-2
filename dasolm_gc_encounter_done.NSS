//dasolm_gc_encounter_done
//Returns TRUE if the encounter is all dead. Returns FALSE if any creatures are still alive in the encounter.
//
//wired 2010/07/12 modified from SOZ version >> each encounter will have one group
//of enemies and that groupname will be the area tag plus "_enemies"
//get rid of getfirstpc() type stuff and make this go for multiplayer

#include "ginc_overland"

#include "dasolm_inc"
#include "ginc_partymath"

int StartingConditional()
{
	object oPC = GetPCSpeaker();
	string sGroupName = GetTag(GetArea(OBJECT_SELF))+"_N";
	string sAreaTag = GetTag(GetArea(oPC));
	
	// mission was forced failed (check party)
	if (GetHighJournalEntry(sAreaTag,oPC) == 3)
		return FALSE;
	
	// mission was force success (check PC)
	if (GetJournalEntry(sAreaTag,oPC) == 2)
		return TRUE;	
		
	if (bDEBUG) SendMessageToPC(oPC,"Group: "+sGroupName);

	// mission is rolling ... are bad guys still around?
	if (GetIsGroupValid(sGroupName, TRUE) && IsGroupHostile(sGroupName, oPC))
	{
		if (bDEBUG) SendMessageToPC(oPC,"is alive and hostile.");
		
		// encounter not complete
		return FALSE;
	}
	else
	{
		// yep, PCs have killed everyone
		return TRUE;
	}
}