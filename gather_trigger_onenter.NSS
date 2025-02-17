/*
	When the PC enters, do a skill check, and spawn a placeable.

	
	Enhancement opportunities:
		- Make it so that wiping only destorys herbs, not arbitrary items
		- XP for defeating a CR
		- Spot/wilderness check to get a "hint" ("looks like a good place")
		- Multiple or random placeable appearances 
		- configureable respawn timer(s)



	2006/11/??		jhr4n
		Initial revision

	2006/11/25		jhr4n
		Made respawn second accurate instead of game hour accurate
		Made respawn trigger dependent instead of player dependent

	2006/11/26		jhr4n
		Changed the way checks were performed.  Used to add them all 
		togeather and check vs one DC for "find" and one for "know"

*/


#include "std_i0_time"
#include "std_i0_skill"


// New variables (trigger) - not currently used
	string kFindSpot	= "cfg_find_spot"; // do you want this?
	string kHintSpot	= "cfg_hint_spot";
	string kHintSurvive	= "cfg_hint_survive";

//	The find and know DCs
	string kFindSearch	= "cfg_find_search";
	string kFindSurvive	= "cfg_find_survive";
	
	string kKnowLore	= "cfg_know_lore";
	string kKnowSurvive	= "cfg_know_survive";

	
// The product and placeable resrefs (trigger)
	string kProduct 	= "cfg_product";
	string kAppearance 	= "cfg_placeable_0";
	
	
	
	
// XP reward - not implemented	
	string kCR 			= "cfg_CR"; 					


// Respawn rates - not implemented
	string kRespawn1	= "cfg_respawn_search";
	string kRespawn2	= "cfg_respawn_harvest";
		

// The message to display when the placeable appears (placeable)
	string kSpawnMessage = "cfg_message";

	
/*
	Discussion: 
		Q: Why put the "SpawnMessage" on the placeable instead of the
		trigger?
		
		A: The placeable could be a mushroom.  You could have several
		appearances, each with a semi-random message.
	
	Enhancement suggestion:
		Hints.
		
		When you step on a trigger, you can get a hint.
		"Looks like a good place to search!"	
		

	Enhancement suggestion:
		Add a CONFIGUREABLE respawn timer.  Two is even better.
		
		Search again prevents repeating checks over and over.  It should be player
		dependent.
		
		Find again limits the maximum amount of stuff you can pull.  It should be
		module dependent.
		

*/


int		gather_search_new( object oTrigger, object oPC )
	{	
	// Load DCs
	int DC_find_search 	= GetLocalInt( oTrigger, kFindSearch );
	int DC_find_survive = GetLocalInt( oTrigger, kFindSurvive );
	int DC_know_lore 	= GetLocalInt( oTrigger, kFindSearch );
	int DC_know_survive	= GetLocalInt( oTrigger, kFindSearch );

		
	// Load required skills
	int mod_search = GetSkillRank( SKILL_SEARCH, oPC );
	int mod_survive = GetSkillRank( SKILL_SURVIVAL, oPC );
	int mod_lore = GetSkillRank( SKILL_LORE, oPC );

	
	// Find out which "find" skill is best
	int find_skill = SKILL_SURVIVAL;
	int find_best = 21;
	
	
	// Survival is untrained and always active
	int roll_find_survive = DC_find_survive - mod_survive;
	if ( roll_find_survive < find_best)
		{
		find_skill = SKILL_SURVIVAL;
		find_best = roll_find_survive;
		}


	// Search only when active
	if ( GetActionMode( oPC, ACTION_MODE_DETECT ) )
		{
		int roll_find_search = DC_find_search - mod_search;	
		if ( roll_find_search < find_best )
			{
			find_skill = SKILL_SEARCH;
			find_best = roll_find_search;
			}		
		}
		

	/*
	if ( find_skill == SKILL_SEARCH )
		SendMessageToPC( oPC, "Search: " + IntToString( find_best ) );
		
	if ( find_skill == SKILL_SURVIVAL )
		SendMessageToPC( oPC,  "Survive: " + IntToString( find_best ) );		
	*/


	// Do find check now for possible early return
	int find_roll = d20();
	if ( find_roll < find_best )
		return FALSE;

		
	//SendMessageToPC( oPC, "Passed the find check" );		

	
	
		
		
	// Find out which "know" skill is best
	int know_skill = SKILL_SURVIVAL;
	int know_best = 21;

	
	// Survival is untrained and always active
	int roll_know_survive = DC_know_survive - mod_survive;
	if ( roll_know_survive < know_best )
		{
		know_skill = SKILL_SURVIVAL;			
		know_best = roll_know_survive;
		}
	
		
	int roll_know_lore = DC_know_lore - mod_lore;
	if ( roll_know_lore < know_best )
		{
		know_skill = SKILL_LORE;
		know_best = roll_know_lore;
		}
		
		
	
	// Do find check now for possible early return
	int know_roll = d20();
	if ( know_roll < know_best )
		return FALSE;
		
	// Holy crap.  They found it.
	/*
	SendMessageToPC( oPC, 
		"Find: " + IntToString(find_roll) + " + " + IntToString( find_mod )
		+ " vs DC " + IntToString( find_dc )
		);
	SendMessageToPC( oPC, 
		"Know: " + IntToString(know_roll) + " + " + IntToString( know_mod )
		+ " vs DC " + IntToString( know_dc )
		);		
	*/	
	
	return TRUE;
	}


	
void main()
	{

	object oPC = GetEnteringObject();
	if ( !GetIsPC(oPC) )
		return;
	
	object oTrigger = OBJECT_SELF;
	string herb_ownerpc = "herb_ownerpc";
	
	//int debug = TRUE;
		
	//if (debug) SendMessageToPC(oPC, "Running");
	
	
	// You can check a trigger every 30 seconds
	int elapsed_skillchecks = time_stamp_seconds_elapsed( oTrigger, "skillchecktimestamp");
	if ( elapsed_skillchecks < 30 )
		{
		//if (debug) SendMessageToPC(oPC, "Skillcheck Timer: " + IntToString(elapsed_skillchecks) );
		return;
		}
		
	//if (debug) SendMessageToPC(oPC, "Allowed to check");
	
	// Only do checks if there is something to find
	int elapsed = time_stamp_seconds_elapsed( oTrigger, "respawntimestamp");
	if ( elapsed < 120 )
		{
		//if (debug) SendMessageToPC(oPC, "Respawn Timer: " + IntToString(elapsed) );
		return;
		}
		
	
	//if (debug) SendMessageToPC(oPC, "Something to find");


	// Mark the last search, and search
	time_stamp_seconds_set( oTrigger, "skillchecktimestamp");		
	if ( !gather_search_new(oTrigger, oPC) )
		return;

	
	//if (debug) SendMessageToPC(oPC, "Check Passed");

	// Set last spawn timer
	time_stamp_seconds_set( oTrigger, "respawntimestamp");
	
	// Spawn placeable at PC's location	
	string herb_placeable = GetLocalString( oTrigger, kAppearance );
	//if ( herb_placeable == "") herb_placeable = "herb_placeable_default00";
	location sp = GetLocation(oPC);
	object oHerb = CreateObject( OBJECT_TYPE_PLACEABLE, herb_placeable, sp );
			
	// Send message to PC based on placeable
	string spawn_message = GetLocalString( oHerb, kSpawnMessage );
	SendMessageToPC(oPC, spawn_message );

	// Set backlink to PC
	SetLocalObject( oHerb, herb_ownerpc, oPC );
			
	// Spawn in placeable's inventory
	string item_resref = GetLocalString( oTrigger, kProduct );	
	object oItem = CreateItemOnObject( item_resref, oHerb, 1 );
		
	// Rename placeable to match item's name
	SetFirstName( oHerb, GetFirstName(oItem) );

	}
	