/*

	Advance the state of a persistant quest.
	Only does the PC that walked over it.
	
	"Skill Check" can do everything this does, plus more.
	This is mainly for convience.  I don't really recommend it.
	
	Significantly: 
		No message
		No skill check
		No XP/CR
				
	The trigger that fires this can actually use the same script.
	That makes this script... REALLY pointless.
	

	2006/11/19		jhr4n		
		initial revision
			
*/

#include "std_persist_i0"
#include "std_quest_i0"


string 	kQuest = "cfg_quest";
string 	kRequire = "cfg_quest_require";
string 	kAdvance = "cfg_quest_advance";

// Not currently used
string	kParty = "cfg_party";  


void	main( )
	{
	
	object oPC = GetEnteringObject();
	object oTrigger = OBJECT_SELF;
	
	string quest = GetLocalString( oTrigger, kQuest );
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