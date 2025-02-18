/*
	ga_*	( conversation action )
	
	DO NOT USE!  Future update  will break your convo!
		What future updates?

	Attach this to conversation nodes to award XP.  
	Works just like the standard but it	persists.
	
	There is NOT currently a xp cap in place - you CAN accidentally give more 
	than 100% xp.  I hope to correct this "one day"
	
	2006/11/19		jhr4n		
		initial revision
		
	2007/1/12	jhr4n
		Fixed double give for the speaker

*/


#include "std_quest_i0"



void	give_xp_to_single( object oPC, string quest, int require, int xp)
	{
	// Get journal
	object oJournal = std_journal_get(oPC);

	// QuestRoot -> SpecificQuest->nState
	string kQuestRoot = persist_find_root(oJournal);
	string kQuestNode = tree_child_use( oJournal, kQuestRoot, quest);	
	int nState = tree_leaf_getint( oJournal, kQuestNode, "nState" );

	// Give xp if they qualify
	if ( nState == require )
		GiveXPToCreature( oPC, xp );	

	}



void	main( string quest, int require, int percent, int bParty )
	{
	// Locate the PC involved in this mess
	object oPC = GetPCSpeaker();
	if ( GetIsObjectValid(oPC) == FALSE ) 
		oPC = OBJECT_SELF;	

	// Calculate xp to give
	int total = GetJournalQuestExperience(quest);
	total *= 100;
	total /= percent;
		
	// Only do the player
	if ( bParty == 0 )
		{
		give_xp_to_single( oPC, quest, require, total );
		return;
		}

	// Give to whole party
	object oMember = GetFirstFactionMember( oPC );
	while ( GetIsObjectValid(oMember) )
		{
		give_xp_to_single( oMember, quest, require, total );
		oMember = GetNextFactionMember(oMember);
		}
		
	
	}



/*
*/