//	GUI OK - CHANGES A CREATURES DESCRIPTION VIA QUILL OF DESCRIPTION CHANGING.
//
//	07/20/07	RORBERT HARRIS		ROBERTHARRIS@ROBERTHARRIS.COM
//
void main(string sInput)
{
	object oTarget;
	string sOriginalDescription;
	
	oTarget = GetLocalObject(OBJECT_SELF, "oTarget");
	sOriginalDescription = GetDescription(oTarget);
	
	SetDescription(oTarget, sInput);
	WriteTimestampedLogEntry("DESCRIPTION CHANGE: " + sOriginalDescription + " to " + sInput);
}