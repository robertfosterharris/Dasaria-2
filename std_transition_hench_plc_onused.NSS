/*

	Set local string to the tag of a WP
	"std_plc_transition_target" 

*/
// wired 12/26/07
// jump henchman with you
void main()
{

	string target = "std_transition_target";
	string k_message = "std_transition_message";
	
	object oPC = GetLastUsedBy();
	object oLadder = OBJECT_SELF;
	// wired 12/26/07
	object oHench = GetAssociate(ASSOCIATE_TYPE_HENCHMAN, oPC);
	
	
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
		
	string sMessage = GetLocalString( oLadder, k_message);
	if ( sMessage != "" )
		FloatingTextStringOnCreature( sMessage, oPC, FALSE );
	
	DelayCommand(1.0,AssignCommand( oPC,JumpToObject( oWP, 0 )	));
		
	// wired 12/26/07
	if (GetIsObjectValid(oHench)) 
	{
		// this should happen automatically, let's try putting the henchman near PC
		DelayCommand(1.5,AssignCommand (oHench, ActionJumpToObject (oPC)));
		//AssignCommand(oHench, ClearAllActions());
	    //AssignCommand(oHench, ActionJumpToObject(oWP));
	}		
		
}



/*
*/