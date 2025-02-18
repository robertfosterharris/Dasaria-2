/*
	
	gc_    ( conversation conditional/check )
	
	Set the state of a persistant quest.  
	No requirements.  The PC (and optionally his whole party) will advance
	to the new state.

	2006/11/19		jhr4n		
		initial revision
		
	2007/1/12	jhr4n
		Fixed double give for the speaker		
		
	2007/1/19	jhr4n
		Party action loop was using the leader (oPC) instead 
		of the individual members (oMember)		
		
*/

#include "std_quest_i0"


void	for_each( object oPC, string sQuestTag, int advance )
	{
	//get journal
	object oJournal = std_journal_get(oPC);
	
	// QuestRoot -> SpecificQuest->nState
	string kQuestRoot = persist_find_root(oJournal);
	string kQuestNode = tree_child_use( oJournal, kQuestRoot, sQuestTag);	
	
	int nState = tree_leaf_getint( oJournal, kQuestNode, "nState" );


	// Do the advancement
	//SpeakString( "Advancing: " + GetName( oPC ) );
	tree_leaf_setint( oJournal, kQuestNode, "nState", advance);
	AddJournalQuestEntry( sQuestTag, advance, oPC, FALSE, FALSE, TRUE );
	
	}


void	main( string quest, int advance, int bParty )
	{
	
	// Locate the PC involved in this mess
	object oPC = GetPCSpeaker();
	if ( !GetIsObjectValid( oPC ) )
		oPC = OBJECT_SELF;	

		
	// Only do the player
 	if ( bParty == 0 )
		{
		for_each( oPC, quest, advance);
		return;
		}
		
	// Give to whole party	
	object oMember = GetFirstFactionMember( oPC, TRUE );
	while ( GetIsObjectValid( oMember ) )
		{
		for_each( oMember, quest, advance);
		oMember = GetNextFactionMember( oPC, TRUE );
		}
	
	}


/*
*/