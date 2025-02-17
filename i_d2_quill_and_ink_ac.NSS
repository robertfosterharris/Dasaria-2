//	ON ACTIVATE - DISPLAY INPUT BOXES FOR WRITTING CUSTOM MESSAGES ON BLANK SCROLLS
//
//	ROBERT HARRIS	ROBERTHARRIS@ROBERTHARRIS.COM	08/22/2010
//
void main()
{
    object oPC      = GetItemActivator();
	object oTarget  = GetItemActivatedTarget();
	
	if (GetTag(oTarget) == "x2_it_cfm_bscrl" && GetName(oTarget) == "Blank Scroll")
	{
		SetLocalObject(oPC, "oTarget", oTarget);
		DisplayInputBox (oPC, 0, "Enter Message Subject", "gui_quill_subject_ok");
	}
	else
	{
		FloatingTextStringOnCreature("*Invalid Target*", oPC, FALSE, 2.0, 4294967295, 4294967295, 0.4, [0.0,0.0,1.0]);
	}
}