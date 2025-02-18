/*



	2006/12/20		jhr4n
		Initial revision
		
	2006/12/20		jhr4n
		Now sends the state change event to the controllers
		
		
	2007/1/19	jhr4n
		persist_advance_party:
			Main loop was using the leader (oPC) instead 
			of the individual members (oMember)

	
	What I am thinking is this:
		I send the controller a request to update the state and delete
		the state variables.  I will know it "caught" the message if
		the state variable was actually updated.  If it wasn't, I will
		manually do it.
*/

#include "std_persist_i0"



string	std_quest_kStateVars = "StateVars";


string	persist_find_root(object oJournal);

void	persist_onjoin( object oPC );

int 	persist_check_requirements( object oPC, string quest, int require );
void	persist_advance_single(  object oPC, string quest, int require, int advance, int edge, string message="" );
void	persist_advance_party(  object oPC, string quest, int require, int advance, int edge, string message="" );

void	delete_quest( object oPC, string quest );
void	delete_statevars( object oPC, string quest );


/*

	Todo:
		Add force (advance without check)
		
		_XP* children don't work in ANY meaningful sense
		
		_new thing is crap also
	
*/



string	persist_find_root(object oJournal)
	{
	string kCampaign = "d2";
	string kMod = tree_child_use( oJournal, kCampaign, "Cear");
	string kQuestRoot = tree_child_use( oJournal, kMod, "stdpersistquest");
	
	return kQuestRoot;
	}

	
	
	
	


// 
int persist_check_requirements( object oPC, string quest, int require )
	{
	
	// Get journal
	object oJournal = std_journal_get(oPC);

	// QuestRoot -> SpecificQuest->nState
	string kQuestRoot = persist_find_root(oJournal);
	string kQuestNode = tree_child_use( oJournal, kQuestRoot, quest);	
	int nState = tree_leaf_getint( oJournal, kQuestNode, "nState" );

	// Compare and return	
	if ( nState == require )
		return TRUE;
	return FALSE;
	
	}


	
	
	
	

// Advance one guy if he meets the requirements
void	persist_advance_single(  object oPC, string quest, int require, int advance, int edge, string message="" )
	{
	
	// Get Journal
	object oJournal = std_journal_get(oPC);
	
	// QuestRoot -> SpecificQuest->nState
	string kQuestRoot = persist_find_root(oJournal);
	string kQuestNode = tree_child_use( oJournal, kQuestRoot, quest);	
	
	int nState = tree_leaf_getint( oJournal, kQuestNode, "nState" );

	// Check requirements
	if ( nState == require )
		{
		// Advance the journal
		AddJournalQuestEntry( quest, advance, oPC, FALSE, FALSE, TRUE );
		
		// Send message if he has one
		if ( message != "" )
			FloatingTextStringOnCreature(message, oPC, FALSE, 2.0, 4294967295, 4294967295, 0.4, [0.0,0.0,1.0]);
		
		// Pass variables to controller
		SetLocalString( oPC, "std_quest_var_qst", quest );
		SetLocalInt( 	oPC, "std_quest_var_req", require );
		SetLocalInt( 	oPC, "std_quest_var_adv", advance );
		SetLocalInt( 	oPC, "std_quest_var_edg", edge );
		
		// Send event	
		string controller = "qst_" + quest;
		ExecuteScript( controller, oPC );
		int return_state = tree_leaf_getint( oJournal, kQuestNode, "nState" );
		
		// If the controller did his part, so we're done.
		if ( return_state == advance )
			return;
			
		// The controller failed to advance the state
		// It either doesn't exist or violated it's contract
		
		// Either way, we assume the worst and do it ourselves
		string kStateVars = tree_child_use( oJournal, kQuestNode, std_quest_kStateVars);
		tree_leaf_setint( oJournal, kQuestNode, "nState", advance);
		tree_node_delete    ( oJournal, kStateVars );
		}	
	}

	
	
	
	
		
void	persist_advance_party(  object oPC, string quest, int require, int advance, int edge, string message="" )
	{

	object oMember = GetFirstFactionMember( oPC, TRUE );
	while ( GetIsObjectValid( oMember ) )
		{
		persist_advance_single( oMember, quest, require, advance, edge, message);
		oMember = GetNextFactionMember( oPC, TRUE );
		}

	}





	
	
	
	
	
	
// Called when a player joins, updates the journal with persisted entries.
void	persist_onjoin( object oPC )
	{
	// Get Journal
	object oJournal = std_journal_get(oPC);

	// QuestRoot -> SpecificQuest->nState
	string kQuestRoot = persist_find_root(oJournal);
	
	
	// Cycle through the children
	int count = tree_child_count    ( oJournal, kQuestRoot );
	int i;
	for ( i=1; i <= count; i++)
		{
		string kQuestNode = tree_child_get( oJournal, kQuestRoot, i );

		if ( tree_node_valid( oJournal, kQuestNode) )
			{
			int nState = tree_leaf_getint( oJournal, kQuestNode, "nState" );
			string sQuestTag = tree_node_name( oJournal, kQuestNode );
			
			if ( nState != 0 )
				{
				AddJournalQuestEntry( sQuestTag, nState, oPC, FALSE, FALSE, TRUE );			
				//SendMessageToPC(oPC, "Advancing " + sQuestTag + " to: " + IntToString( nState) );
				}
			}
		}		
	
	
	}


	
	
	
	
	
void	delete_quest( object oPC, string quest )
	{
	// Get Journal
	object oJournal = std_journal_get(oPC);
	
	// QuestRoot -> SpecificQuest->nState
	string kQuestRoot = persist_find_root(oJournal);
	string kQuestNode = tree_child_use( oJournal, kQuestRoot, quest);	
	
	tree_node_delete    ( oJournal, kQuestNode );
	RemoveJournalQuestEntry( quest, oPC, FALSE, FALSE );
	}


	
	
	
		
void	delete_statevars( object oPC, string quest )
	{
	// Get Journal
	object oJournal = std_journal_get(oPC);
	
	// QuestRoot -> SpecificQuest->nState
	string kQuestRoot = persist_find_root(oJournal);
	string kQuestNode = tree_child_use( oJournal, kQuestRoot, quest);	
	string kStateVars = tree_child_use( oJournal, kQuestNode, std_quest_kStateVars);
	
	tree_node_delete    ( oJournal, kStateVars );
	}
	
	
	

/*
*/