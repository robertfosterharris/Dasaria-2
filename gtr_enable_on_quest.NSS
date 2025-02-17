// gtr_enable_on_quest
// wired 05/09/2009
// use a trigger to activate an encounter only
// if the enteringobject's party has the corect
// journal state
//
// trigger takes 3 variables
//	sJournalReq >0 <8 4
//  sQuestName
//  sEncTag

#include "ginc_partymath"
#include "ginc_var_ops"

void main()
{
	int nJournalEntry;
	
	string sJournalReq;
	string sQuestName;
	string sEncTag;
	
	object oPC;
	object oEnc;
	
	oPC 		= 	GetEnteringObject();
		if (!GetIsPC(oPC)) return;
	
	sJournalReq	=	GetLocalString(OBJECT_SELF,"sJournalReq");
	sQuestName	=	GetLocalString(OBJECT_SELF,"sQuestName");
	sEncTag		=	GetLocalString(OBJECT_SELF,"sEncTag");
	oEnc		=	GetObjectByTag(sEncTag);

	// get the highest journal state in the party
	nJournalEntry 	= 	GetHighJournalEntry(sQuestName,oPC);	
	
	if ( CompareInts(nJournalEntry, sJournalReq) )
	{			
		SetEncounterActive(TRUE, oEnc);
	}
}