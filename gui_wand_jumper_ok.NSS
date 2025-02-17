// get input from text box and execute
void main(string sWayPointTag)
{
	object oWP = GetWaypointByTag(sWayPointTag);
	object oPC = GetLocalObject(OBJECT_SELF, "oTarget");
		
	if ( !GetIsObjectValid( oWP ) )
		{
		// panic
		SendMessageToPC(OBJECT_SELF,"Can't find Waypoint "+sWayPointTag);
		return;
		}
		
	AssignCommand( oPC, 
		JumpToObject( oWP, 0 )
		);
}