/*
	Perform skill checks:
		flavor, xp, advance quests
		
	Supported skills:
		"listen"
		"spot" 
		"lore"
	
	To skip the skill check, skill = ""
	
	To skip quest related functions, quest = "" (set a respawn!)
	
	To require a quest but not advance, set advance=require (and respawn!)

*/

#include "std_i0_time"
#include "std_quest_i0"



// The message and the respawn for it.  
	string	kMessage = "cfg_message";


// only useful when no quest is required
	string	kRespawn = "cfg_respawn"; 	
	
	
// XP for a a party right at the CR
// TODO: CR not implementd
	string	kXP = "cfg_xp"; 
	string	kCR = "cfg_cr"; 	

// Party wide (quest and xp, or quest only?) I like both.
	string	kParty = "cfg_party";	

// Skill / DC
	string kSkill = "cfg_skill";
	string kDC = "cfg_skill_DC";
	
// Not Implemented: if you are making recurring, "beater style" checks
	string	kRepeat = "cfg_skill_repeat";


// Optionally require/advance a quest (optionally for party)
	string	kQuest 		= "cfg_quest";
	string	kRequire 	= "cfg_quest_require";
	string	kAdvance 	= "cfg_quest_advance";
	string	kEdge 		= "cfg_quest_edge";

	
	
		
/*
	Design considerations
	
	What about quests?
		+ Nice to avoid "spam" when not on quest
		+ Possibility to have some quests hinge on finding secret

		- Adds complexity where not really needed
		- Adds a dependency, requires persistance
		? Partial quest xp or straight xp?
			+ Straight if no quest, 
			+ partial if quest
			
		D 	Alternative is to have seperate triggers.  Seperate triggers
			implies seperate checks.  Could get message without update.
			Ugly. Best to keep them linked.
			
		
	Multiple concurrent skill checks?
			Certainly possible, only a small change required - but the message?
			Leave it out, it's complex enough
			
*/

	
#include "std_i0_skill"


void main()
	{
	// Get main functions
	object oTrigger = OBJECT_SELF;
	object oPC = GetEnteringObject();
	
	
	// Set key
	string concat = GetFirstName(oPC) + GetLastName(oPC);
	string key = "gather_pctimer_" + concat;
	
	// Return early if not respawned for this player
	int respawn_seconds_RL = GetLocalInt( oTrigger, kRespawn );
	int real_seconds_elapsed = time_stamp_elapsed_seconds( oTrigger, key);

	//SendMessageToPC( oPC, "Elapsed: " + IntToString( real_seconds_elapsed) );
			
	if ( real_seconds_elapsed < respawn_seconds_RL )
		return;

			
	// Update timestamp
	time_stamp_set( oTrigger, key);		
		

	// Do any appropriate skill check
	string 	sSkill = GetLocalString( oTrigger, kSkill );
	if ( sSkill != "" )
		{
		int 	nSkill = skill_get_fromname( sSkill );
		int		nDC = GetLocalInt( oTrigger, kDC );
		int		bPass = skill_check_silent( oPC, nSkill, nDC );
		if ( !bPass )
			return;
		}

		
	// Check to see if a quest exists
	string quest = GetLocalString( oTrigger, kQuest );
	if ( quest != "" )
		{
		int require = GetLocalInt( oTrigger, kRequire );
	
		// Only advance when advance != require
		int advance = GetLocalInt( oTrigger, kAdvance );
		if ( advance != require )
			{
			// Get the edge number
			int edge = GetLocalInt( oTrigger, kEdge );
			
			int bParty = GetLocalInt( oTrigger, kParty);
			if ( bParty == 0 )
				persist_advance_single( oPC, quest, require, advance, edge, "" );
			if ( bParty == 1 )
				{
				string message = GetFirstName(oPC) + "'s actions have advanced your quest";
				persist_advance_party(  oPC, quest, require, advance, edge, message );
				}
			}
			
		}
				
	
	// Deliver trigger's message to the finder (only to the finder)
	string sMessage = GetLocalString( oTrigger, kMessage );
	if ( sMessage != "" )
		FloatingTextStringOnCreature( sMessage, oPC, FALSE, 2.0, 4294967295, 4294967295, 0.4, [0.0,0.0,1.0]);

		
	// Reward XP if appropriate
	int nXP = GetLocalInt( oTrigger, kXP );
	if ( nXP > 0 )
		GiveXPToCreature( oPC, nXP);
		
		
			
	
	}


/*
*/