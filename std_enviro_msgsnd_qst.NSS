// std_enviro_msgsnd_qst

/*
	Flavor text with respawn/delay
	
	Use the Skill check trigger if you 	need something 
	with more flexibility.
*/

// wired 07/12/11 options to play a sound 
// wired 02/18/12 same as before but check quest state
// if(sOperator == ">" || sOperator == "<" || sOperator == "=" || sOperator == "!")

#include "std_i0_time"
#include "ginc_var_ops"
#include "ginc_partymath"


string	kMessage = "std_message_message";
	

void main()
	{
	object oTrigger = OBJECT_SELF;
	object oPC = GetEnteringObject();
	
	string sQuestTag = GetLocalString(oTrigger, "sQuestTag");
	string sCheck = GetLocalString(oTrigger, "sCheck");
	
	int	nJournalEntry	= 	GetHighJournalEntry(sQuestTag,oPC);
	
	if ( CompareInts(nJournalEntry, sCheck) )
	{	
		
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
			
		// Optional Sound
		string sSound = GetLocalString( oTrigger, "sSound" );
		if ( sMessage != "" )
		{
			AssignCommand(oPC,PlaySound(sSound));
		}
				
		// Send the message
		FloatingTextStringOnCreature( sMessage, oPC, FALSE, 2.0, 4294967295, 4294967295, 0.4, [0.0,0.0,1.0]);
			
		// Update timestamp
		time_stamp_seconds_set( oTrigger, key);		
		
		}
}

/*
*/