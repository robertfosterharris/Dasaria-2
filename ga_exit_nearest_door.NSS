#include "ginc_misc"

void main(int bRun)
{
	object oExit;
	
	oExit = GetNearestObjectToLocation(OBJECT_TYPE_DOOR, GetLocation(OBJECT_SELF));
	if (GetIsObjectValid(oExit))
	{
		AssignCommand(OBJECT_SELF, ActionForceExit(GetTag(oExit), bRun));
	}
	else
	{
		DestroyObject(OBJECT_SELF);
	}
}