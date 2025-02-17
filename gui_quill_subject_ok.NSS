//	GUI OK - 	QUILL AND INK
//				WRITES MESSAGE SUBJECT
//				MAKES CALL TO GET MESSAGE BODY
//
//	ROBERT HARRIS	ROBERTHARRIS@ROBERTHARRIS.COM	08/22/2010
//
void main(string sInput)
{
	object oTarget;
	
	oTarget = GetLocalObject(OBJECT_SELF, "oTarget");
	SetFirstName(oTarget, sInput);
	DisplayInputBox (OBJECT_SELF, 0, "Enter Message Body", "gui_quill_body_ok");
}