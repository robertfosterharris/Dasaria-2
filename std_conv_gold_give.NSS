/*
	Give gold to a person or party
	
	2007/1/12	jhr4n
		Initial Revision
		
	2007/1/19	jhr4n
		Party action loop was using the leader (oPC) instead 
		of the individual members (oMember)

	
*/




void main( int quantity, int bParty )
	{
	// Get the PC involved in this mess
    object oPC = GetPCSpeaker();
	if ( !GetIsObjectValid(oPC) ) 
		oPC = OBJECT_SELF;

	// default stack size
	if ( quantity < 1 )
		quantity = 1;

 	if ( bParty == 0 )
		{
		GiveGoldToCreature( oPC, quantity );
		return;
		}
		
	// Give to rest of party also
	object oMember = GetFirstFactionMember(oPC);
	while ( GetIsObjectValid(oMember) == TRUE )
		{
		GiveGoldToCreature( oMember, quantity );
		oMember = GetNextFactionMember(oPC);
		}
		
	}