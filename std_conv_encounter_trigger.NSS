/*
	Trigger a encounter
	The encounter will be chosen based on a tag
	
	2006/12/10		jhr4n
		Initial revision
		
*/


void	main( string tag )
	{
	object oPC = GetPCSpeaker();
	object oEncounter = GetObjectByTag( tag );
	
	if ( !GetIsObjectValid(oEncounter) )
		{
		// Panic
		return;		
		}
	
	
	SetEncounterActive(TRUE, oEncounter);
	TriggerEncounter(oEncounter, oPC, ENCOUNTER_CALC_FROM_FACTION, -1.0);
	
	}


/*
*/