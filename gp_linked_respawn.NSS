//	ONDEATH SCRIPT THAT RESPAWNS A CHAIN OF PLACEABLES
//
//	sNextLink 	RESREF OF THE NEXT ITEM TO SPAWN
//	fDelay 		NUMBER OF SECONDS BEFORE sNextLink IS DESTROYED
//
//	EXAMPLE:	VAMPIRE COFFIN -> CRUSHED VAMPIRE COFFIN
//					
//	01/27/07	ROBERT HARRIS	ROBERTHARRIS@ROBERTHARRIS.COM
//
void QueueNextLink(object oObject);

void main()
{

	float fDelay;
	object oObject;
	string sObject;
	
	
	fDelay = GetLocalFloat(OBJECT_SELF, "fDelay");
	sObject = GetLocalString(OBJECT_SELF, "sNextLink");
	oObject = CreateObject(OBJECT_TYPE_PLACEABLE, sObject, GetLocation(OBJECT_SELF), TRUE);

	if (fDelay > 0.0f)
	{
		AssignCommand(oObject, DelayCommand(fDelay, QueueNextLink(oObject)));
	}		
}

void QueueNextLink(object oObject)
{
	ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectDeath(TRUE), oObject);
}