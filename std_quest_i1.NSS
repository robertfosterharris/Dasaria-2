/*

	Include file for quest controllers ( qst_* )

	2006/12/20		jhr4n
		Initial revision

*/

#include "std_quest_i0"


void	main()
	{
	object oPC = OBJECT_SELF;
	
	// Load them up
	string quest = GetLocalString( oPC, "std_quest_var_qst" );
	int require = GetLocalInt( 	oPC, "std_quest_var_req" );
	int advance = GetLocalInt( 	oPC, "std_quest_var_adv" );
	int edge = GetLocalInt( 	oPC, "std_quest_var_edg" );
	
	// Get Journal
	object oJournal = std_journal_get(oPC);
	
	// QuestRoot -> SpecificQuest->nState
	string kQuestRoot = persist_find_root(oJournal);
	string kQuestNode = tree_child_use( oJournal, kQuestRoot, quest);	
	
	// Load nState and kStatevars
	int nState = tree_leaf_getint( oJournal, kQuestNode, "nState" );
	string kStateVars = tree_child_use( oJournal, kQuestNode, std_quest_kStateVars);
	
	// OnExit(node)
	
	// Delete Statevars
	tree_node_delete( oJournal, kStateVars );
	
	// OnTransition (node, node, edge)
	
	// The only thing we absolutly must do, is advance the state
	tree_leaf_setint( oJournal, kQuestNode, "nState", advance);
	
	// OnEnter(node)
	}



	

/*
*/