//	GUI OK - 	QUILL AND INK
//				WRITES MESSAGE BODY
//
//	ROBERT HARRIS	ROBERTHARRIS@ROBERTHARRIS.COM	08/22/2010
//
void main(string sInput)
{
	object oTarget;
	
	oTarget = GetLocalObject(OBJECT_SELF, "oTarget");
	SetDescription(oTarget, sInput);
	DeleteLocalObject(OBJECT_SELF, "oTarget");
}