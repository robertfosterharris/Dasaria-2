/*
	Pressure plate.  When all plates are pressed down, open a door.
*/



void	main()
	{
	
	object oPlate = OBJECT_SELF;
	object oPC = GetEnteringObject();
	string exit_string = "The plate returns to a slightly raised position";
	string kTriggerCounter = "people_inside";
	
	
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