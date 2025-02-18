/*
	List all faction members and have them announce their loyalty
*/

#include "std_faction_i0"

void	main( string faction )
	{

	object oPC = GetPCSpeaker();
	
	// Faction generators will have tag of:  prefix+faction
	string	module_faction_prefix = "d2_faction_";
	
	// Find generator	
	string tag = module_faction_prefix + faction;
	object oGenerator = GetObjectByTag(tag);
	if ( !GetIsObjectValid(oGenerator) )
		{
		SendMessageToPC( oPC,
			"Could not find tag: " + tag
			);
		}
		
	// Cycle and go
	int i = 0;
	object oMember = GetFirstFactionMember( oGenerator, FALSE );
	while ( GetIsObjectValid(oMember) )
		{
		++i;
		SendMessageToPC( oPC,
			"Member " + IntToString(i) + " found: " + GetName(oMember) + " and " 
				+ IntToString(GetReputation(oMember, oPC))
			);		
		AssignCommand( oMember,
			SpeakString("I am a member of: " + faction)
			);
		
		oMember = GetNextFactionMember( oGenerator, FALSE );
		}
		
	SendMessageToPC( oPC,
		"Membership: " + IntToString(i)
		);
		

	
	}

/*
*/