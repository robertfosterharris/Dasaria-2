

void main()
{

	{
	    object oDoor1       = GetNearestObjectByTag ("alarm_dr_1");
		object oDoor2       = GetNearestObjectByTag ("alarm_dr_2");
		object oDoor3       = GetNearestObjectByTag ("ol_rescue_gate");
		
		
		
		AssignCommand(oDoor1, ActionOpenDoor(oDoor1));
		AssignCommand(oDoor2, ActionOpenDoor(oDoor2));
		AssignCommand(oDoor3, ActionCloseDoor(oDoor3));
		SetLocked(oDoor3, TRUE);
		
	}
	

}
