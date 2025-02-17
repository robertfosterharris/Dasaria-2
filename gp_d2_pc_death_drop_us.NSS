//	ON USE SCRIPT FOR PVP DEATH DROP CONTAINER
//	UNLOCK CONTAINER FOR EITHER THE PVP VICTOR OR PVP LOSER
//	THE CONTAINER IS LOCKED TO ALL OTHERS.
//
//	ROBERT HARRIS	ROBERTHARRIS@ROBERTHARRIS.COM	03/06/2007
//
void main()
{
	object oContainer;
	object oPC;
	
	oContainer = OBJECT_SELF;
	oPC = GetLastUsedBy();

	if ((oPC == GetLocalObject(OBJECT_SELF, "oKiller") || (oPC == GetLocalObject(OBJECT_SELF, "oPC"))))
	{
		if (GetLocked(OBJECT_SELF))
		{
			SetLocked(OBJECT_SELF, FALSE);
			AssignCommand(oPC, ActionInteractObject(oContainer));
		}			
	}
}