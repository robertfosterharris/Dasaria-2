// i_wand_jumper_ac
// move a normal PC around for testing
void main()
{
    object oPC      = GetItemActivator();
	object oTarget = GetItemActivatedTarget();
	SetLocalObject(oPC, "oTarget", oTarget);

	DisplayInputBox (oPC, 0, "Enter tag of object to jump to", "gui_wand_jumper_ok", "gui_wand_jumper_cancel",
	TRUE, "", 0, "", 0, "", "");

}