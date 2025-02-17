// gui_d2_bio_open
//
// wired 6/15/2011


void main()
{
	object oPC = GetOwnedCharacter(OBJECT_SELF);
	CloseGUIScreen(oPC,"SCREEN_EXAMINE");
	CloseGUIScreen(oPC,"SCREEN_CREATURE_EXAMINE");
	DisplayGuiScreen(oPC, "D2_BIO_EDIT", FALSE, "d2_bio_edit.xml");
}