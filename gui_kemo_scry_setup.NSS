#include "kemo_scry_includes"

void main()
{
	object oPC = OBJECT_SELF;
	switch (GetLocalInt(oPC,"Scry_Anon"))
	{
		case 0: SetGUIObjectText(oPC,"KEMO_SCRY_PANEL","KEMO_SCRY_ANON",-1,"Go Anon"); break;
		case 1: SetGUIObjectText(oPC,"KEMO_SCRY_PANEL","KEMO_SCRY_ANON",-1,"Go Visible"); break;
	}
	switch (GetLocalInt(oPC,"Scry_LFG"))
	{
		case 0: SetGUIObjectText(oPC,"KEMO_SCRY_PANEL","KEMO_SCRY_LFG",-1,"Start LFG"); break;
		case 1: SetGUIObjectText(oPC,"KEMO_SCRY_PANEL","KEMO_SCRY_LFG",-1,"End LFG"); break;
	}
	switch (GetLocalInt(oPC,"Scry_AFK"))
	{
		case 0: SetGUIObjectText(oPC,"KEMO_SCRY_PANEL","KEMO_SCRY_AFK",-1,"Go AFK"); break;
		case 1: SetGUIObjectText(oPC,"KEMO_SCRY_PANEL","KEMO_SCRY_AFK",-1,"End AFK"); break;
	}
	switch (GetLocalInt(oPC,"Scry_DND"))
	{
		case 0: SetGUIObjectText(oPC,"KEMO_SCRY_PANEL","KEMO_SCRY_DND",-1,"Do Not Disturb"); break;
		case 1: SetGUIObjectText(oPC,"KEMO_SCRY_PANEL","KEMO_SCRY_DND",-1,"Make Available"); break;
	}
	if (KEMO_USE_CAPTURE)
	{
		switch (GetLocalInt(oPC,"Scry_PVP"))
		{
			case 0: SetGUIObjectText(oPC,"KEMO_SCRY_PANEL","KEMO_SCRY_PVP",-1,"PVP OK"); break;
			case 1: SetGUIObjectText(oPC,"KEMO_SCRY_PANEL","KEMO_SCRY_PVP",-1,"PVP Negotiable"); break;
			case 2: SetGUIObjectText(oPC,"KEMO_SCRY_PANEL","KEMO_SCRY_PVP",-1,"PVP Capture OK"); break;
			case 3: SetGUIObjectText(oPC,"KEMO_SCRY_PANEL","KEMO_SCRY_PVP",-1,"No PVP"); break;
		}
	}
	if (!KEMO_USE_CAPTURE)
	{
		switch (GetLocalInt(oPC,"Scry_PVP"))
		{
			case 0: SetGUIObjectText(oPC,"KEMO_SCRY_PANEL","KEMO_SCRY_PVP",-1,"PVP OK"); break;
			case 1: SetGUIObjectText(oPC,"KEMO_SCRY_PANEL","KEMO_SCRY_PVP",-1,"PVP Negotiable"); break;
			case 2: SetGUIObjectText(oPC,"KEMO_SCRY_PANEL","KEMO_SCRY_PVP",-1,"No PVP"); break;
		}
	}
	
	ExecuteScript("gui_kemo_scry_gather",oPC);
}