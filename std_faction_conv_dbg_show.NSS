/*
	Tell the PC his current standing
*/

#include "std_faction_i0"

void	main( string faction )
	{
	
	object oPC = GetPCSpeaker();
	
	int value = std_reputation_get( oPC, faction );
	
	SendMessageToPC( oPC, 
		"Faction " + faction + ": " + IntToString(value)
		);
	
	
	}

/*
*/