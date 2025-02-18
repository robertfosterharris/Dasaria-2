/*

	Delete all quests, completly.
	NWN's Journal will not be affected, so you may want to restart

	
	2006/12/20		jhr4n
		Initial revision

*/



#include "std_quest_i0"



void	main( int bParty )
	{
	
	// Locate the PC involved in this mess
	object oPC = GetPCSpeaker();
	if ( !GetIsObjectValid( oPC ) )
		oPC = OBJECT_SELF;	


	// Only do the player
 	if ( bParty == 0 )
		{
		object oJournal = std_journal_get(oPC);
		string kQuestRoot = persist_find_root(oJournal);
		tree_node_delete    ( oJournal, kQuestRoot );

		return;
		}
		
		
	// Do the whole party
	object oMember = GetFirstFactionMember( oPC, TRUE );
	while ( GetIsObjectValid( oMember ) )
		{
		// Delete member's data
		object oJournal = std_journal_get(oMember);
		string kQuestRoot = persist_find_root(oJournal);
		tree_node_delete    ( oJournal, kQuestRoot );
	
		// Advance
		oMember = GetNextFactionMember( oPC, TRUE );
		}
	
	}

/*
*/