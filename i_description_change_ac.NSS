//	ITEM ON ACTIVATE - GETS THE NEW DESCRIPTION OF THE TARGETED OBJECT
//
//	07/20/07	RORBERT HARRIS		ROBERTHARRIS@ROBERTHARRIS.COM
//
void main()
{
	object oPC;
	object oTarget;
	
	oPC = GetItemActivator();
	oTarget = GetItemActivatedTarget();
	
	SetLocalObject(oPC, "oTarget", oTarget);
	DisplayInputBox (oPC, 0, "Enter New Description", "gui_description_change_ok", "gui_description_change_cancel",
	TRUE, "", 0, "", 0, "", GetDescription(oTarget));
}