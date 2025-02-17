// wired 08/22/09
// gtr_jump_to_wp

void main()
{
	object oPC = GetEnteringObject();
	//if (!GetIsPC(oPC)) { SendMessageToPC(GetFirstPC(), "Something terrible happened 1."); return; }
	
	string sWP = GetLocalString(OBJECT_SELF,"sWP");
	
	object oWP = GetWaypointByTag( sWP );
	if ( !GetIsObjectValid( oWP ) ) { SendMessageToPC(oPC, "Invalid target."); return; }
	
	AssignCommand( oPC, JumpToObject( oWP, 0 )	);
	
}