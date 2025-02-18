/*

	!!!
	This script is obsolete and should not be used for new projects
	!!!

	Advance a quest with no persistance.  
	
	
*/

string kJournal = "std_quest_journaltag";
string kRequire = "std_quest_requirestate";
string kAdvance = "std_quest_advancestate";

void main()
	{
	object oPC = GetEnteringObject();
	object oTrigger = OBJECT_SELF;
	
		if (!GetIsPC(oPC)) return;
	
	string journal_tag = GetLocalString( oTrigger, kJournal );
	int require = GetLocalInt( oTrigger, kRequire );
	int advance = GetLocalInt( oTrigger, kAdvance );
	
	if ( journal_tag == "")
		{
		// panic
		return;
		}
	
	if ( GetJournalEntry(journal_tag, oPC) == require  )
		{
		AddJournalQuestEntry(journal_tag, advance, oPC, FALSE, FALSE, TRUE );
		}
	
	}
	
/*
*/