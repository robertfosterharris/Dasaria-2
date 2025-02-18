/*

	Useful for ghosts spawning from tombs.  And stuff.

	When a placeable is disturbed, 
		1) spawn a encounter
		2) destroy the placeable
		3) respawn after a delay

*/


string kRespawn = "cfg_plc_respawn";
string kEncounter = "cfg_enc_tag";


void	do_respawn( string resref, location loc)
	{
	CreateObject(OBJECT_TYPE_PLACEABLE, resref, loc);
	}


void	handle_encounter( object oPLC, object oPC )
	{
	// Load tag from variable
	string EncounterTag = GetLocalString( oPLC, kEncounter);
	if ( EncounterTag == "" )
		return;
		
	// Find nearest encounter with that tag
	object oEncounter = GetNearestObjectByTag( EncounterTag, oPLC );
	
	// If that doesn't work, try to find ANY encounter with that tag
	if ( !GetIsObjectValid(oEncounter) )
		oEncounter = GetObjectByTag( EncounterTag );

	// If we still don't have one, give up		
	if ( !GetIsObjectValid(oEncounter) )
		return;
		
	// Trigger the encounter
	SetEncounterActive(TRUE, oEncounter);
	TriggerEncounter(oEncounter, oPC, ENCOUNTER_CALC_FROM_FACTION, 0.0);
	}
	

void	main()
	{
	object oPLC = OBJECT_SELF;
	object oPC = GetLastDisturbed();
	
	handle_encounter( oPLC, oPC );
	

	string resref = GetResRef( oPLC );
	location loc = GetLocation( oPLC );

	// Load delay from variable (with default)
	float fDelay = GetLocalFloat( oPLC, kRespawn );
	if ( fDelay < 1.0 )
		fDelay = 300.0;

	// Destroy the (empty) placeable
	DestroyObject( oPLC );
		
	// Respawn after delay
	AssignCommand( GetArea(oPLC), 
		DelayCommand( fDelay, 
			do_respawn(resref, loc)
			)
		);
		
	}

	


/*
*/