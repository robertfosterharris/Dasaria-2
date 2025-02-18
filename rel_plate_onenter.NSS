/*
	Pressure plate.  When all three plates are pressed down, 
	open a door.
*/

#include "ginc_partymath"
#include "x0_i0_partywide"

void	magic_check(int nDoor)
	{
	
	object oPlate;
	int c;
	int i;
	int nPlates = 8;
	
	string door_tag = "cuthbert_door_"+IntToString(nDoor);	
	string kTriggerCounter = "people_inside";
		
	for (i = 1; i <= nPlates; i++)
	{
		
		// Check each plate
		oPlate = GetObjectByTag("cuthbert_plate_"+IntToString(i));
		if ( !GetIsObjectValid( oPlate) )
			return;
		c = GetLocalInt(oPlate, kTriggerCounter);
		if ( c < 1 )
		return;
	}
			
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
	
	string kTriggerCounter = "people_inside";
	string enter_string = "The plate slides down with a satisifying 'click'";
	
	int nDoor = GetHighLocalInt(oPC, "cuthbert_door");
	
	
	if (GetAlignmentGoodEvil(oPC) == ALIGNMENT_EVIL)
	{
		FloatingTextStringOnCreature( "An evil heart may not walk the path of purity.", oPC, TRUE);
		return;
	}
	
	int c = GetLocalInt(oPlate, kTriggerCounter);
	++c;
	SetLocalInt(oPlate, kTriggerCounter, c);
	
	// If it is 1, it was 0, and is now occupied
	if ( c == 1 )
		FloatingTextStringOnCreature( enter_string, oPC, TRUE);
	
	//SendMessageToPC( oPC, IntToString( c ) );

	SetLocalIntOnAll(oPC, "cuthbert_door",1);
	magic_check(1);
	
	}



/*
*/