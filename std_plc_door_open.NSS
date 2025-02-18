/*
	When used, this placeable will open a door.
	
	Put this script in the OnDeath event.
	
	In case you get trapped "behind" some door.
		
	
	2007/1/25		jhr4n
		Initial revision
	
*/



string kDoorTag = "cfg_plc_door";


void	main()
	{
	object oPLC = OBJECT_SELF;
	
	string tag = GetLocalString( oPLC, kDoorTag );
	if ( tag == "" )
		{
		// Panic
		return;		
		}
		
	object oDoor;
	
	// Try getting the nearest one
	oDoor = GetNearestObjectByTag( tag );
	
	// if that fails, try getting any door
	if ( !GetIsObjectValid( oDoor ) )
		oDoor = GetObjectByTag( tag);
	
	// if that fails, give up
	if ( !GetIsObjectValid( oDoor ) )
		{
		// Panic
		return;
		}
		
	// Come on guys
	if ( GetObjectType( oDoor ) != OBJECT_TYPE_DOOR )
		{
		//Panic
		return;
		}
		
	
	// Open the door allready.
	AssignCommand( oDoor, 
		ActionOpenDoor( oDoor )
		);
	
	

	}



/*
*/