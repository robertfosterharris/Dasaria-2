// createwp
// Creates a WP at the target location from area tag
void main()
{

    object oPC      = GetItemActivator();
    object oItem    = GetItemActivated();
    object oTarget  = GetItemActivatedTarget();
    location lTarget = GetItemActivatedTargetLocation();
	location lPC = GetLocation(oPC);
	int objtype = GetObjectType(oTarget);  

	if ( objtype != 64)  {	
	 string sArea = GetTag(GetArea(oTarget));
	 string sNewTag = "DM_"+IntToString(d100(10))+sArea;
	 object oWP = CreateObject(OBJECT_TYPE_WAYPOINT, "nw_waypoint001", lTarget, FALSE, sNewTag);
	 string sTargetTag = GetTag(oWP);
	 SetLocalString(oItem, "_wp", sTargetTag);
	 SendMessageToPC(oPC, "Waypoint Created: "+sTargetTag);
	 return;
	 }
	
	if ( objtype == 64)  {
	 string sTargetTag = GetLocalString(oItem, "_wp");	
	 SetLocalString(oTarget, "std_transition_target", sTargetTag);
	 SendMessageToPC(oPC, "Object linked to " +sTargetTag);
	 return;
	 }	
	
	SendMessageToPC(oPC, "Error: Target is invalid");
}