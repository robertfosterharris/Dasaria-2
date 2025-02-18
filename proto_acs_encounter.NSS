/*
	This is a j4 prototype
		Do not use
		Do not delete
*/


void	main()
	{
	object oPC = GetPCSpeaker();
	
	object oEncounter = GetNearestObject( OBJECT_TYPE_ENCOUNTER );
	
	SendMessageToPC( oPC,
		"Encounter located: " + GetName( oEncounter )
		);
	
	// Report on activity	
	if ( GetEncounterActive(oEncounter) )
		SendMessageToPC( oPC, "Active");
	else
		SendMessageToPC( oPC, "Inactive");
		
	// Report on current spawn count
	SendMessageToPC( oPC, 
		"Current spawns: " + IntToString(GetEncounterSpawnsCurrent(oEncounter))
		);
	
		
	// Note to self:
	//int ENCOUNTER_CALC_FROM_CR 			= 0;	// Use the CR value passed in determining the spawn pool
	//int ENCOUNTER_CALC_FROM_FACTION 	= 1;	// Calculate the encounter based on normal encounter processing (based on a radius around the triggering object)

	// And spawn it
	/*
	SetEncounterActive(TRUE, oEncounter);
	TriggerEncounter(oEncounter, oPC, ENCOUNTER_CALC_FROM_FACTION, 0.0);
	*/
	
	}


/*
*/