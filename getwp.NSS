// getwp
// Gets the tag of nearest waypoint to target and displays it to activator
void main()
{
	object oPC = GetPlayerCurrentTarget(OBJECT_SELF);
    location lPC = GetLocation(oPC);
	object oTarget = GetNearestObjectToLocation(OBJECT_TYPE_WAYPOINT, lPC, 1); 
	string sTargetTag = GetTag(oTarget);
	SendMessageToPC(oPC, "Nearest Waypoint is: "+sTargetTag);
}