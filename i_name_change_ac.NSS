//	ITEM ON ACTIVATE - GETS THE NEW NAME OF THE TARGETED OBJECT
//
//	07/16/07	RORBERT HARRIS		ROBERTHARRIS@ROBERTHARRIS.COM
//
void main()
{
	object oPC;
	object oTarget;
	
	oPC = GetItemActivator();
	oTarget = GetItemActivatedTarget();
	
	SetLocalObject(oPC, "oTarget", oTarget);
	DisplayInputBox (oPC, 0, "Enter New Name", "gui_name_change_ok", "gui_name_change_cancel",
	TRUE, "", 0, "", 0, "", GetName(oTarget));
}