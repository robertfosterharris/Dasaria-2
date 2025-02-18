/*
	
	gc_    ( conversation conditional/check )
	
	Advance the state of a persistant quest	
	
	2006/11/19		jhr4n
		initial revision
		
	2006/12/20		jhr4n
		Now uses common "require" check from "std_quest_i0"
		Now uses common "advance" check from "std_quest_i0"
		
	2010/07/21		wired
		if bParty is -1, single player only
*/

#include "std_quest_i0"


void	main( string quest, int require, int advance, int bParty )
	{
	
	// Locate the PC involved in this mess
	object oPC = GetPCSpeaker();
	if ( !GetIsObjectValid( oPC ) )
		oPC = OBJECT_SELF;	

	// wired 2010/07/21
	if (bParty == -1)
	{
		persist_advance_single( oPC, quest, require,advance, 0, "" );
		return;
	}
	
	// Do the advancement
	persist_advance_party( oPC, quest, require, advance, 0, "" );
		
	}


/*
*/