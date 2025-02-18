/*

	Set local string to the tag of a WP
	"std_plc_transition_target" 

*/

void main()
	{

	string target = "std_transition_target";
	string k_message = "std_transition_message";
	int nFloor = GetLocalInt(OBJECT_SELF,"std_transition_floor");
	int nCap = GetLocalInt(OBJECT_SELF,"std_transition_cap");
	
	object oPC = GetLastUsedBy();
	object oLadder = OBJECT_SELF;
	int nHD = GetHitDice(oPC);
	
	string tag = GetLocalString( oLadder, target);
	if ( tag == "")
		{
		// panic!		
		return;
		}
	
	object oWP = GetWaypointByTag( tag );
	if ( !GetIsObjectValid( oWP ) )
		{
		// panic
		return;
		}
		
	if (nHD < nFloor )
	{
		SendMessageToPC(oPC,"This area seems too treacherous for someone of your experience.  You should return once you're prepared to journey so from help.");
			
	}
	if (nHD > nCap )
	{
		SendMessageToPC(oPC,"The dangers posed by this area seem beneath someone of your experience. You'd be better off seeking a path more aligned with your capabilities.");
	}
	
	if (nHD > nFloor && nHD < nCap)
	{	
		string sMessage = GetLocalString( oLadder, k_message);
		if ( sMessage != "" )
			FloatingTextStringOnCreature( sMessage, oPC, FALSE, 2.0, 4294967295, 4294967295, 0.4, [0.0,0.0,1.0]);
			
		AssignCommand( oPC, 
			JumpToObject( oWP, 0 )
			);
	}
}

/*
*/