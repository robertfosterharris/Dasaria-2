/*
*/

#include "std_faction_i0"

void main()
	{
	object oPC;
	object oTarget;
	
	oPC = GetItemActivator();
	oTarget = GetItemActivatedTarget();
	
	// Only DMs may use these
	if ( !GetIsDM(oPC) )
		return;
	
	string faction = "cearguard";
	int number = 80;
	
	std_reputation_set( oTarget, faction, number );
	std_reputation_reset( oTarget, faction );
	}		
	
	
/*
*/