/*
	Pressure plate.  When all three plates are pressed down, 
	open a door.
*/

#include "sq_plate_cfg"


/*
*/


void	magic_check()
	{
	
	object oPlate;
	int c;
		
		
	// Check plate 1
	oPlate = GetObjectByTag(plate1_tag);
	if ( !GetIsObjectValid( oPlate) )
		return;
	c = GetLocalInt(oPlate, kTriggerCounter);
	if ( c < 1 )
		return;


	// Check plate 2	
	oPlate = GetObjectByTag(plate2_tag);
	if ( !GetIsObjectValid( oPlate) )
		return;
	c = GetLocalInt(oPlate, kTriggerCounter);
	if ( c < 1 )
		return;

		
	// Check plate 3
	oPlate = GetObjectByTag(plate3_tag);
	if ( !GetIsObjectValid( oPlate) )
		return;
	c = GetLocalInt(oPlate, kTriggerCounter);
	if ( c < 1 )
		return;


			
	// Find the door	
	object oDoor = GetObjectByTag( door_tag );
	if ( !GetIsObjectValid( oDoor ) )
		return;


	// Open the door
	SetLocked( oDoor, FALSE );
	AssignCommand(oDoor, 
		ActionOpenDoor(oDoor)
		);
				
	
	
	}



void	main()
	{
	
	object oPlate = OBJECT_SELF;
	object oPC = GetEnteringObject();
	
	int c = GetLocalInt(oPlate, kTriggerCounter);
	++c;
	SetLocalInt(oPlate, kTriggerCounter, c);
	
	// If it is 1, it was 0, and is now occupied
	if ( c == 1 )
		FloatingTextStringOnCreature( enter_string, oPC, TRUE);
	
	//SendMessageToPC( oPC, IntToString( c ) );
	
	magic_check();
	
	}



/*
*/