// i_wand_appearance_ac
void main()
{
    object oPC      = GetItemActivator();
    object oItem    = GetItemActivated();
    object oTarget  = GetItemActivatedTarget();
    location lTarget = GetItemActivatedTargetLocation();
	
	SetLocalObject(oPC, "oTarget", oTarget);
	
	
	DisplayInputBox (oPC, 0, "Enter Appearance #", "gui_wand_appearance_ok", "gui_wand_appearance_cancel",
	TRUE, "", 0, "", 0, "", "");
	
 	//prototype
	//SetCreatureAppearanceType(oTarget, 564);

}