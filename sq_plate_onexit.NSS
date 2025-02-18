/*
	Pressure plate.  When all three plates are pressed down, 
	open a door.
*/


#include "sq_plate_cfg"





void	main()
	{
	
	object oPlate = OBJECT_SELF;
	object oPC = GetEnteringObject();
	
	int c = GetLocalInt(oPlate, kTriggerCounter);
	--c;
	SetLocalInt(oPlate, kTriggerCounter, c);
	
	// If it is 0, it was 1, and is now unoccupied
	if ( c == 0 )
		FloatingTextStringOnCreature( exit_string, oPC, TRUE);
	
	//SendMessageToPC( oPC, IntToString( c ) );
	
	}



/*
*/