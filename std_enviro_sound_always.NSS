/*
	Flavor sound with respawn/delay

*/

#include "std_i0_time"


string	kSound = "std_enviro_sound";
	

void main()
	{
	object oTrigger = OBJECT_SELF;
	object oPC = GetEnteringObject();
	
	// Set key
	string concat = GetFirstName(oPC) + GetLastName(oPC);
	string key = "message_pctimer_" + concat;

	// Check timestamp
	int respawn = 8*60;
	int elapsed = time_stamp_seconds_elapsed( oTrigger, key );
	if ( elapsed < respawn )
		return;
			
	// Make sure the string exists
	string sSoundName = GetLocalString( oTrigger, kSound );
	if ( sSoundName == "" )
		return;
		
	// Play the sound
	AssignCommand(oPC, PlaySound(sSoundName));
		
		
	// Update timestamp
	time_stamp_seconds_set( oTrigger, key);		
	
	}


/*
*/