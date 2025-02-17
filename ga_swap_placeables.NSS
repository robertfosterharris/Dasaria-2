//	REPLACES AN OLD PLACEABLE WITH A NEW PLACEABLE
//
//	sOld - TAG OF THE OLD PLACEABLE
//	sNew - RESREF OF THE NEW PLACEABLE
//
void main(string sOld, string sNew)
{
	location lLocation;
	object oOld;
	object oNew;
	
	oOld = GetObjectByTag(sOld);
	if (GetIsObjectValid(oOld))
	{
		lLocation = GetLocation(oOld);
		oNew = CreateObject(OBJECT_TYPE_PLACEABLE, sNew, lLocation, TRUE, sOld);
		if (GetIsObjectValid(oNew))
		{
			DestroyObject(oOld);
		}
	}
}