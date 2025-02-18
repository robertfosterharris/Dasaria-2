/*

	This is a work in progress
	
	This script is now significantly obsolete by the new
	standard FSM advance code in std_quest_i0
	
	
	
	
	--------------
	
	
	It if for advancing a quest once all the tiggers/placeables have
	been triggerd.

	
	Main things left to do:
		UpdateSubGoal - 
			need to check that they have the quest I am updating to avoid 
			polluting the journal.  
			
			Need to make sure I am on the state I think I am, and not
			updating some randome state of the quest

			
-----------------------------------------------------		

	One major issue is when we pass in the advance state.  Is it on 
	every placeable?  Seems like a terrible idea.  That means 
	storing the "advance state" in the journal.

	It would be better to have a trigger, like, each time a identifier is
	triggered, the "OnTrigger" check, and will auto update the journal
	when ready.  Yeah, that could work.
	
	The convo adds a bunch of triggers you have to touch
		ga_addTrigger( quest, require, "tag1" );
		ga_addTrigger( quest, require, "tag2" );
		ga_setAdvance( quest, require, advance );
		
	The placeable/triggers do this:
		trigger_markTrigger();
		plc_markTrigger();
		
	When we advance, we force a clean.  Later on we will add more
	complex state-machine functions that force a clean anytime any
	state changes at all.	

	
	To assist with easy state changes, anytime nState is changed we can
	delete all the state variables assiociated with it.  Hence:
		All state Variables are stored in a "StateVars" subnode.
	This is pretty awesome, from a scripting standpoint.

		
	
---------------------------------------------------------

	What we want to do is this:
		1) check the require.  If fails, abort.
		2) check the placeable/trigger touched.  Add it to the list.
		3) If all the placeables/triggers are touched, move to advance.
	
	What about other triggers.  Like "get item" or "kill boss".  They
	aren't connected to "collect all tags" but they are still if->then
	type statements.
	
	Quests currently have ONE node, nState.  
	There is no reason not to load this down with ways to advance.
	"kill boss" and "find items" will need a faster way to work than
	scanning every quest.  but thats not a amazingly huge deal.
	
	
	Root
		ItemList
			item1 -> my_quest, trigger1
		BossList
			boss1 -> my_quest, trigger1
		QuestList
			my_quest
			
	I don't see any reason to make it any more complex.  The only thing I 
	can think of is like:
		QuestList
			my_quest
				nState
				AdvanceType="concersationbased"
				AdvanceType="tagbasedadvancement"
				TagAdvanceList
					tag1
					tag2
					tag3
				
	What does that even do for you?  Well, it makes it clear to a programmer
	what happens next, and nobdy else will ever care.  So it's kinda pointless.
		
*/


#include "std_persist_i0"
#include "std_quest_i0"



void	std_quest_auto_SetAdvance( object oPC, string quest, int advance );
void	std_quest_auto_AddSubGoal( object oPC, string quest, string tag);
void	std_quest_auto_CheckAllSubGoals( object oPC, string quest );
void	std_quest_auto_UpdateSubGoal( object oPC, string quest, string tag);




string	std_quest_auto_kStateVars = "StateVars";
string	std_quest_auto_kAdvance = "advance";
string	std_quest_auto_kSubGoals = "SubGoals";











// Does this need "require"?
void	std_quest_auto_SetAdvance( object oPC, string quest, int advance )
	{
	// Get Journal
	object oJournal = std_journal_get(oPC);
	
	// QuestRoot -> SpecificQuest->StateVars
	string kQuestRoot = persist_find_root(oJournal);
	string kQuestNode = tree_child_use( oJournal, kQuestRoot, quest);
	string kStateVars = tree_child_use( oJournal, kQuestRoot, std_quest_auto_kStateVars);
	
	// Set the advance state
	tree_leaf_setint( oJournal, kStateVars, std_quest_auto_kAdvance, advance );
		
	}

	
	
		
	
// Each subgoal has a tag
void	std_quest_auto_AddSubGoal( object oPC, string quest, string tag)
	{
	// Get Journal
	object oJournal = std_journal_get(oPC);
	
	// QuestRoot -> SpecificQuest->StateVars
	string kQuestRoot = persist_find_root(oJournal);
	string kQuestNode = tree_child_use( oJournal, kQuestRoot, quest);
	string kStateVars = tree_child_use( oJournal, kQuestRoot, std_quest_auto_kStateVars);

	// All subgoals in a list
	string kSubGoalList = tree_child_use( oJournal, kQuestRoot, std_quest_auto_kSubGoals);

	// Add the subgoal, start it uncompleted
	tree_leaf_setint( oJournal, kSubGoalList, tag, 0);
	}


	
	

	
		
void	std_quest_auto_CheckAllSubGoals( object oPC, string quest )
	{
	// Get Journal
	object oJournal = std_journal_get(oPC);
	
	// QuestRoot -> SpecificQuest->StateVars
	string kQuestRoot = persist_find_root(oJournal);
	string kQuestNode = tree_child_use( oJournal, kQuestRoot, quest);
	string kStateVars = tree_child_use( oJournal, kQuestRoot, std_quest_auto_kStateVars);

	// All subgoals in a list
	string kSubGoalList = tree_child_use( oJournal, kQuestRoot, std_quest_auto_kSubGoals);
	
	// Loop through all children7
	int i;
	int children = tree_child_count( oJournal, kSubGoalList);
	for(i = 1; i <= children; ++i)
		{
		string subnode = tree_child_get(oJournal, kSubGoalList, i);
		
		// Stop early if ANY nodes are incomplete
		if ( tree_node_getint( oJournal, subnode ) == 0 )
			return;
		}
		
		
	// All the nodes are completed.  Advance their journal to the next state.
	int advance = tree_leaf_getint( oJournal, kStateVars, std_quest_auto_kAdvance );
	tree_leaf_setint( oJournal, kQuestNode, "nState", advance );
		
		
	
		
	}







void	std_quest_auto_UpdateSubGoal( object oPC, string quest, string tag)
	{
	// Get Journal
	object oJournal = std_journal_get(oPC);
	
	// Check to see if they are even involved in this quest
	
	// QuestRoot -> SpecificQuest->StateVars
	string kQuestRoot = persist_find_root(oJournal);
	string kQuestNode = tree_child_use( oJournal, kQuestRoot, quest);
	string kStateVars = tree_child_use( oJournal, kQuestRoot, std_quest_auto_kStateVars);

	// All subgoals in a list
	string kSubGoalList = tree_child_use( oJournal, kQuestRoot, std_quest_auto_kSubGoals);

	// Check to see if there is a subgoal matching (not really necessary)
	
	// Set the subgoal complete
	tree_leaf_setint( oJournal, kSubGoalList, tag, 1);
	
	// See if that should advance the journal
	std_quest_auto_CheckAllSubGoals(oPC, quest);
	}
	
	
	
	
	
	

	
	
	
	
	
	
	
	
	
	
	
	
/*
*/