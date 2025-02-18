void main()
{
	object oPC;
	object oTarget;
	string sTarget;
	string sMessage;
	
	oPC = GetEnteringObject();
	
	if ( !GetIsPC(oPC) )	// if the entering object is not a PC, bail out
		return;
		
	sTarget = GetLocalString( OBJECT_SELF, "std_transition_target");
	sMessage = GetLocalString( OBJECT_SELF, "std_transition_message");

	oTarget = GetWaypointByTag (sTarget);
	if (sMessage != "")	FloatingTextStringOnCreature(sMessage, oPC, FALSE, 2.0, 4294967295, 4294967295, 0.4, [0.0,0.0,1.0]);
	AssignCommand(oPC, ClearAllActions(TRUE));
	AssignCommand(oPC, ActionJumpToObject(oTarget, FALSE));
}