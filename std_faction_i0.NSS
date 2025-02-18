/*
	This implements fairly generic faction handling.
	
	There is some D2 specific code, in the /d2/faction directory.  
	I'll move that over pretty soon.	
	
	2006/12/9	jhr4n
		Initial revision
*/


#include "std_persist_i0"


// Get the root directory from the journal (cfg)
string	std_faction_util_getroot( object oJournal );


// Set game factions to the valued from the journal (login, respawn)
void	std_reputation_reset( object oPC, string faction );

// Load/Store values on the journal
int		std_reputation_get( object oPC, string faction );
void	std_reputation_set( object oPC, string faction, int value );



/*
*/





string	std_faction_util_getroot( object oJournal )
	{
	// Int's stored on journal under: /d2/faction/faction_name
	string	sRoot = "d2";
	string	sFactRoot = "faction";
	
	// Traverse directory
	string kFactionRoot = tree_child_use( oJournal, sRoot, sFactRoot );
	
	return kFactionRoot;	
	}

	


void	std_reputation_reset( object oPC, string faction )
	{
	// Faction generators will have tag of:  prefix+faction
	string	module_faction_prefix = "d2_faction_";
	
	int	value = std_reputation_get( oPC, faction );
	
	// If value is undefined, exit out early
	if (value == -1)
		return;
	
	string tag = module_faction_prefix + faction;
	object oGenerator = GetObjectByTag(tag);

	if ( !GetIsObjectValid(oGenerator) )
		{
		// Panic
		SendMessageToPC( oPC,
			"Could not find tag: " + tag
			);
		}
	
	
	
	// Adjust to target value
	int old = GetReputation( oGenerator, oPC); 
	int adjust = value - old;
	AdjustReputation(oPC, oGenerator, adjust);				
	
		

	}
	
	
	
	
void	std_reputation_set( object oPC, string faction, int value )
	{
	// Get faction node
	object oJournal = std_journal_get( oPC );
	string kFactionRoot = std_faction_util_getroot( oJournal );

	// Create the int if not present
	string kThisFaction = tree_child_use( oJournal, kFactionRoot, faction);
	tree_node_setint(oJournal, kThisFaction, value);	

	}
	
	
int		std_reputation_get( object oPC, string faction )
	{
	// Get faction node
	object oJournal = std_journal_get( oPC );
	string kFactionRoot = std_faction_util_getroot( oJournal );
	string kThisFaction = tree_child_find( oJournal, kFactionRoot, faction);

	// Stop if no data
	if ( kThisFaction == "" )
		return -1;
	
	int value = tree_node_getint(oJournal, kThisFaction);
	return value;
	}


	


/*
*/