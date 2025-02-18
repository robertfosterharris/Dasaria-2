/*
	
	!!!
	This script is obsolete and should not be used for new projects
	!!!

	gc_    ( conversation conditional/check )
	
	Advance the state of a persistant quest	
	
	2006/11/19		jhr4n
		This script is obsolete
		
*/

#include "std_persist_i0"
#include "std_quest_i0"

string kJournal = "std_quest_journaltag";
string kRequire = "std_quest_requirestate";
string kAdvance = "std_quest_advancestate";


void	main( )
	{
	
	object oPC = GetEnteringObject();
	object oTrigger = OBJECT_SELF;
	
		if (!GetIsPC(oPC)) return;
	
	string quest = GetLocalString( oTrigger, kJournal );
	int require = GetLocalInt( oTrigger, kRequire );
	int advance = GetLocalInt( oTrigger, kAdvance );
	
	if ( quest == "")
		{
		// Panic
		return;
		}
		
		
	// Get the player's journal
	object oJournal = std_journal_get(oPC);
	
	// QuestRoot -> SpecificQuest->nState
	string kQuestRoot = persist_find_root(oJournal);
	string kQuestNode = tree_child_use( oJournal, kQuestRoot, quest);	
	
	int nState = tree_leaf_getint( oJournal, kQuestNode, "nState" );

	// Compare and assign	
	if ( nState == require )
		{
		//SpeakString( "Advancing: " + GetName( oPC ) );
		tree_leaf_setint( oJournal, kQuestNode, "nState", advance);
		AddJournalQuestEntry( quest, advance, oPC, FALSE, FALSE, TRUE );
		}	


	
		
	}


/*

*/