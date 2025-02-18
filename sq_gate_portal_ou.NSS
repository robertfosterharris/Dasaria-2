/*
	Portal, on clicked
*/


string portal_target_key = "target";


void	main()
	{
	
	object oThis = OBJECT_SELF;
	
	object oPC = GetLastUsedBy();
	
	
	// Get linked portal
	object oLinked = GetLocalObject( oThis, portal_target_key);
	if ( !GetIsObjectValid( oLinked) )
		return;

	
	AssignCommand( oPC, 
		JumpToLocation( GetLocation(oLinked) )
		);
	}


/*
*/