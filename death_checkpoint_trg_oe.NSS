/*
*/

#include "death_i0_respawn"




void	main()
	{
	
	object oPC = GetEnteringObject();
	if ( !GetIsPC( oPC ) )
		return;
	
	
	object oTrigger = OBJECT_SELF;
	
	
	string	tag = GetLocalString( oTrigger, respawn_kTag );
	
	// Return if the PC allready is using this point
	if ( tag == GetLocalString( oPC, respawn_kPlayerVar ) )
		return;
	
	// Set variable
	SetLocalString( oPC, respawn_kPlayerVar, tag );
	
	// Feedback
	SendMessageToPC( oPC, "Checkpoint" );
	
	}






/*
*/