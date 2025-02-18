/*
	Flavor text with respawn/delay
	
	This should not be used any more.  
	Use "std_enviro_message_always" instead
*/

#include "std_i0_time"


string	kMessage = "std_message_message";
	


void main()
	{
	object oTrigger = OBJECT_SELF;
	object oPC = GetEnteringObject();
	
	if (!GetIsPC(oPC)) return;
	
	// Set key
	string concat = GetFirstName(oPC) + GetLastName(oPC);
	string key = "message_pctimer_" + concat;

	// Check timestamp
	int respawn = 8*60;
	int elapsed = time_stamp_seconds_elapsed( oTrigger, key );
	if ( elapsed < respawn )
		return;
			
	// Make sure the string exists
	string sMessage = GetLocalString( oTrigger, kMessage );
	if ( sMessage == "" )
		return;
		
	// Send the message
	FloatingTextStringOnCreature( sMessage, oPC, FALSE );
		
	// Update timestamp
	time_stamp_seconds_set( oTrigger, key);		
	
	}


/*
*/