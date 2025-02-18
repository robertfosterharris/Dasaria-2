/*
	Give an item to a person or party
	
	2007/1/12	jhr4n
		Fixed double give for the speaker
	
*/

#include "ginc_debug"

void CreateItemsOnObject( string sTemplate, object oTarget=OBJECT_SELF, int nItems=1 );

void main( string sTemplate, int quantity, int bParty )
	{
	// Get the PC involved in this mess
    object oPC = GetPCSpeaker();
	if ( !GetIsObjectValid(oPC) ) 
		oPC = OBJECT_SELF;

	// default stack size
	if ( quantity < 1 )
		quantity = 1;

	// Only do the player
 	if ( bParty == 0 )
		{
		CreateItemsOnObject( sTemplate, oPC, quantity );
		return;
		}
		
	// Give to whole party
	object oMember = GetFirstFactionMember(oPC);
	while ( GetIsObjectValid(oMember) == TRUE )
		{
		CreateItemsOnObject( sTemplate, oMember, quantity );
		oMember = GetNextFactionMember(oPC);
		}
		
	}

void CreateItemsOnObject( string sTemplate, object oTarget=OBJECT_SELF, int nItems=1 )
{
	
	int i = 1;
	while ( i <= nItems )
	{
		CreateItemOnObject( sTemplate, oTarget, 1 );
		i++;
	}
}