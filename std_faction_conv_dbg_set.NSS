/*
	Set the faction on the player's journal
	Will not load the settings
*/

#include "std_faction_i0"

void	main( string faction, int number )
	{
	
	object oPC = GetPCSpeaker();
	
	std_reputation_set( oPC, faction, number );
	
	
	
	
	}

/*
*/