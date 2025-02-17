//	ONCONVERSATION		CREATES A HIDDEN DOORMAN WHO OPENS A DOOR WHEN THE CORRECT PASSWORD IS SPOKEN
//						SEE GB_PASSWORD_UNLOCK_SP
//
//				REQUIRED OBJECT VARIABLES
//				sPassword	PASSWORD REQUIRED TO OPEN THE DOOR
//				sDoor		TAG OF DOOR TO OPEN
//
//	3/90/2012	ROBERT HARRIS	ROBERTHARRIS@ROBERTHARRIS.COM
//	
void main()
{
	int nPattern;
	
	nPattern = GetListenPatternNumber();
	if(nPattern == 32171)
	{
		object oDoor = GetObjectByTag(GetLocalString(OBJECT_SELF, "sDoor"));
		if (GetIsObjectValid(oDoor))
		{
			DelayCommand(0.25f, AssignCommand(oDoor, SetLocked(oDoor, FALSE)));
			DelayCommand(0.50f, AssignCommand(oDoor, ActionOpenDoor(oDoor)));
		}
		else
		{
			WriteTimestampedLogEntry("ERROR: gb_password_co - sDoor is not valid.");
		}
	}
}