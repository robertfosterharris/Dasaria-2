// wired 08/28/2011 some functions to control GUI use in xp_craft

void DeactivateGUI(object oPC)
{
	if (!GetIsObjectValid(oPC)) return;
	
	//Close all of the Ingame UI elements we want hidden.
	CloseGUIScreen(oPC, "SCREEN_INVENTORY");
	CloseGUIScreen(oPC, "SCREEN_HOTBAR");
	CloseGUIScreen(oPC, "SCREEN_HOTBAR_2");
	CloseGUIScreen(oPC, "SCREEN_HOTBAR_V1");
	CloseGUIScreen(oPC, "SCREEN_HOTBAR_V2");
	CloseGUIScreen(oPC, "SCREEN_PLAYERMENU");
	CloseGUIScreen(oPC, "SCREEN_ACTIONQUEUE");
	SetLocalInt(oPC,"xp_craft",1);

}

void ReactivateGUI(object oPC)
{
	if (!GetIsObjectValid(oPC)) return;

	//Reopen hotbars and playermenu.
	DisplayGuiScreen(oPC, "SCREEN_HOTBAR",FALSE);
	DisplayGuiScreen(oPC, "SCREEN_HOTBAR_2",FALSE);
	DisplayGuiScreen(oPC, "SCREEN_PLAYERMENU",FALSE);
	DisplayGuiScreen(oPC, "SCREEN_ACTIONQUEUE",FALSE);
	DeleteLocalInt(oPC,"xp_craft");
}