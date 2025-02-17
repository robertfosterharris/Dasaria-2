//	TRIGGER ON ENTER
//	CLOSES THE CELL DOOR AND CLEARS THE CHARACTERS CRIMINAL STATUS
//
//	02/06/07	ROBERT HARRIS	ROBERTHARRIS@ROBERTHARRIS.COM
//
#include "ginc_das_jail"

void main()
{
	int nNumberOfArrests;
	int nLegalStatus;
	object oCriminal;
	object oDoor;
	
	oCriminal = GetEnteringObject();
	nLegalStatus = GetLocalInt(oCriminal, "nLegalStatus");

	if (nLegalStatus > LEGAL_STATUS_CLEAR)
	{
		nNumberOfArrests = GetLocalInt(oCriminal, "nNumberOfArrests");
		nNumberOfArrests++;
		SetLocalInt(oCriminal, "nNumberOfArrests", nNumberOfArrests);
		
		oDoor = GetNearestObjectByTag("jail_d_cell");
		AssignCommand(oDoor, ClearAllActions());
 		AssignCommand(oDoor, ActionCloseDoor(oDoor));
		AssignCommand(oDoor, ActionLockObject(oDoor));
		if (nNumberOfArrests < 3)
		{
			AssignCommand(oDoor, ActionWait(JAILTIME * nNumberOfArrests));
			AssignCommand(oDoor, ActionUnlockObject(oDoor));
			AssignCommand(oDoor, ActionOpenDoor(oDoor));
			AssignCommand(oDoor, ActionSpeakString("You are free to go."));
		}			

		issueResolved(oCriminal);
	}
}