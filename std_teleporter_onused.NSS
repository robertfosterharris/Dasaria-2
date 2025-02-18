/*

	Set local string to the tag of a WP
	"std_plc_transition_target" 

*/

void main()
	{

	string target = "std_transition_target";
	string k_message = "std_transition_message";
	
	object oPC = GetLastUsedBy();
	object oTeleporter = OBJECT_SELF;
	
	
	string tag = GetLocalString( oTeleporter, target);
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
		
	string sMessage = GetLocalString( oTeleporter, k_message);
	if ( sMessage != "" )
		FloatingTextStringOnCreature( sMessage, oPC, FALSE, 2.0, 4294967295, 4294967295, 0.4, [0.0,0.0,1.0]);

	effect eTeleport = EffectVisualEffect(VFX_HIT_CLEANSING_NOVA);
	ApplyEffectToObject(DURATION_TYPE_INSTANT, eTeleport, oPC);
	DelayCommand(3.0, AssignCommand(oPC, JumpToObject( oWP, 0 ))); 		
	}


/*
*/