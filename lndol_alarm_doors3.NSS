

void main()
{

	{
	    object oDoor1       = GetNearestObjectByTag ("alarm_dr_5");
		object oDoor2       = GetNearestObjectByTag ("alarm_dr_6");
	    object oDoor3       = GetNearestObjectByTag ("alarm_dr_7");
		object oDoor4       = GetNearestObjectByTag ("alarm_dr_8");		
		
		
		
		AssignCommand(oDoor1, ActionOpenDoor(oDoor1));
		AssignCommand(oDoor2, ActionOpenDoor(oDoor2));
		AssignCommand(oDoor1, ActionOpenDoor(oDoor3));
		AssignCommand(oDoor2, ActionOpenDoor(oDoor4));		
		
	}
	

}