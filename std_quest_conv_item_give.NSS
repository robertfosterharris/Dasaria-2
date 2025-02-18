/*

	Give item with "require" check.

		
	IN TESTING.  USE AT YOUR OWN RISK.
	
	
	2006/11/28		jhr4n		
		initial revision
		
	2006/12/20		jhr4n
		Now uses common "require" check from "std_quest_i0"
		
	2007/1/12	jhr4n
		Fixed double give for the speaker		

	2007/1/19	jhr4n
		Party action loop was using the leader (oPC) instead 
		of the individual members (oMember)
		
		
*/

#include "std_persist_i0"
#include "std_quest_i0"



void CreateItemsOnObject( string sTemplate, object oTarget, int nItems, string quest, int require )
	{	
	if ( !persist_check_requirements( oTarget, quest, require ) )
		return;
	
	// Loop through and give individually		
	int i = 1;
	while ( i <= nItems )
		{
		CreateItemOnObject( sTemplate, oTarget, 1 );
		i++;
		}


	}




void	main( string quest, int require, string resref, int quantity, int bParty )
	{
	// Locate the PC involved in this mess
	object oPC = GetPCSpeaker();
	if ( GetIsObjectValid(oPC) == FALSE ) 
		oPC = OBJECT_SELF;
		
		
	// default stack size, positive numbers only please
	if ( quantity < 1 )
		quantity = 1;
				
	// Only do the player
 	if ( bParty == 0 )
		{
		CreateItemsOnObject( resref, oPC, quantity,  quest, require  );
		return;
		}

	
	// Give to whole party
	object oMember = GetFirstFactionMember( oPC );
	while ( GetIsObjectValid(oMember) )
		{
		CreateItemsOnObject( resref, oMember, quantity, quest, require );
		oMember = GetNextFactionMember(oMember);
		}
		
	return;
	}
	



/*
*/