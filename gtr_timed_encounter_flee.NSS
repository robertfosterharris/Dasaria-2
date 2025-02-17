//	EXECUTE FLEE BEHAVIOR FOR CREATURES WITHIN AN DEACTIVATED ENCOUNTER
//
//	ROBERT HARRIS	ROBERTHARRIS@ROBERTHARRIS.COM	12/04/2009
//
#include "nw_i0_generic"

void main()
{
	if (GetFleeToExit())
	{
		SetSpawnInCondition(NW_FLAG_AMBIENT_ANIMATIONS, FALSE);
	   	SetSpawnInCondition(NW_FLAG_IMMOBILE_AMBIENT_ANIMATIONS, FALSE);
		ClearAllActions(TRUE);
		ActivateFleeToExit();
	}
	else
	{
		DestroyObject(OBJECT_SELF);
	}
}