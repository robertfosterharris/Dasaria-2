/*

	Delete a quest and all stored information.  
	Resets it completly.	

	2006/11/19		jhr4n		
		initial revision
		
	2006/12/20		jhr4n
		Now uses common "delete" from "std_quest_i0"
		
	2007/1/19	jhr4n
		Party action loop was using the leader (oPC) instead 
		of the individual members (oMember)		

*/



#include "std_quest_i0"



void	main( string quest, int bParty )
	{
	
	// Locate the PC involved in this mess
	object oPC = GetPCSpeaker();
	if ( !GetIsObjectValid( oPC ) )
		oPC = OBJECT_SELF;	

	// Only do the player
 	if ( bParty == 0 )
		{
		delete_quest( oPC, quest );
		return;
		}
		

	// Do the whole party
	if ( bParty == 1)
		{
		object oMember = GetFirstFactionMember( oPC, TRUE );
		while ( GetIsObjectValid( oMember ) )
			{
			delete_quest( oMember, quest );
			oMember = GetNextFactionMember( oPC, TRUE );
			}
		}
	
	}

/*
*/