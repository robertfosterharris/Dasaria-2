// gui_d2_xpcraft_inv
// wired 8/27/2011 shut the inventory screen if opened while in xp_craft dalog

void main()
{
	object oPC = GetControlledCharacter(OBJECT_SELF);
	if (GetLocalInt(oPC,"xp_craft") == 1)
	{
		CloseGUIScreen(oPC,"SCREEN_INVENTORY");
		SendMessageToPC(oPC,"You must quit the crafting dialog before accessing your inventory again.");
	}
}