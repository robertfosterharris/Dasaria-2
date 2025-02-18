

void main()
{

	{
	    object oDoor1       = GetNearestObjectByTag ("alarm_dr_3");
		object oDoor2       = GetNearestObjectByTag ("alarm_dr_4");
		
		
		
		
		AssignCommand(oDoor1, ActionOpenDoor(oDoor1));
		AssignCommand(oDoor2, ActionOpenDoor(oDoor2));
		
		
	}
	

}