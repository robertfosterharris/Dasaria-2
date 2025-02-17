// i_wand_polymorph_ac
void main()
{
    object oPC      = GetItemActivator();
    object oItem    = GetItemActivated();
    object oTarget  = GetItemActivatedTarget();
    location lTarget = GetItemActivatedTargetLocation();
	
	SetLocalObject(oPC, "oTarget", oTarget);
	
	DisplayInputBox (oPC, 0, "Enter POLYMORPH_TYPE", "gui_wand_polymorph_ok", "gui_wand_polymorph_cancel",
	TRUE, "", 0, "", 0, "", "");

}