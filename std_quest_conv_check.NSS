/*
	
	gc_    ( conversation conditional/check )
	
	Check the state of a persistant quest	
	


	
	2006/11/19		jhr4n		
		initial revision

	2006/12/20		jhr4n
		Now uses common "require" check from "std_quest_i0"

*/

#include "std_quest_i0"



// Will return 0 if no quest.
int StartingConditional( string quest, int require )
	{

	// Locate the PC involved in this mess
	object oPC = GetPCSpeaker();
	if ( !GetIsObjectValid( oPC ) )
		oPC = OBJECT_SELF;	


	return persist_check_requirements( oPC, quest, require );
	}

/*

*/