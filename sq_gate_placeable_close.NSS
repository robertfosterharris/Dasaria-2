/*
	RFH	03/03/2007	INCREASED PORTAL DELETION QUEUE FROM 200 TO 600.
					PLAYERS WHO DIE IN THE LAST ROOM ARE UNABLE TO RETURN WITHOUT SOLOING THE CONTENT.
*/


string	plc_tag1 = "Shai_Q_Crstl_Chp_P";
string	plc_tag2 = "Shai_Q_Crstl_Chp_Y";
	
string	item_tag1 = "sq_it_crystal_purple";
string	item_tag2 = "sq_it_crystal_yellow";

string	waypoint_tag1 = "sq_wp_portal_mouth";
string	waypoint_tag2 = "sq_wp_portal_room";



string	portal_resref = "sq_plc_portal";
string 	portal_target_key = "target";



void	main()
	{
	object oPlaceable = OBJECT_SELF;	
	
	
	// Placeables	
	object oP1 = GetObjectByTag( plc_tag1 );
	object oP2 = GetObjectByTag( plc_tag2 );
	
	
	// Items
	object oI1 = GetFirstItemInInventory(oP1);
	object oI2 = GetFirstItemInInventory(oP2);
	
	// Check that both items are correct
	if ( GetTag(oI1) != item_tag1 )
		return;
	if ( GetTag(oI2) != item_tag2 )
		return;	
		
		
	// Destroy the crystals
	DestroyObject( oI1 );
	DestroyObject( oI2 );
	
		
	// Check that the portal WPs exist
	object oWP1 = GetWaypointByTag( waypoint_tag1 );
	object oWP2 = GetWaypointByTag( waypoint_tag2 );
	if ( !GetIsObjectValid( oWP1 ) || !GetIsObjectValid( oWP2 ) )
		{
		// Panic, one or both don't exist
		return;
		}

	// Create the portals
	object oPortal_1 = CreateObject( 
		OBJECT_TYPE_PLACEABLE, portal_resref,
		GetLocation( oWP1 ),
		FALSE, ""
		);		
	object oPortal_2 = CreateObject( 
		OBJECT_TYPE_PLACEABLE, portal_resref,
		GetLocation( oWP2 ),
		FALSE, ""
		);		

		
	// Connect the portals to each other
	SetLocalObject( oPortal_1, portal_target_key, oPortal_2 );
	SetLocalObject( oPortal_2, portal_target_key, oPortal_1 );

	// Queue them for deletion in 600 seconds
	DestroyObject( oPortal_1, 600.0 );
	DestroyObject( oPortal_2, 600.0 );
	
	
	}



/*
*/