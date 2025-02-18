/*
	Load the player's data from his journal onto the NPCs
*/

#include "std_faction_i0"

void	main( string faction )
	{
	
	object oPC = GetPCSpeaker();
	
	std_reputation_reset( oPC, faction );	
	
	SendMessageToPC( oPC,
		"Making it so"
		);
	}

/*
*/