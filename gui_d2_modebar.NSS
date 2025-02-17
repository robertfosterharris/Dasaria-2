// gui_d2_modebar

#include "std_inc_mounts"

void main()
{
	object oPC = GetOwnedCharacter(OBJECT_SELF);
	if (bDEBUG_mounts) SendMessageToPC(oPC,"DEBUG: gui_d2_modebar Running!");
	
	if (GetIsMounted(oPC))
	{	
		SendMessageToPC(oPC,"Cannot use unmounted combat modes while mounted.");
		CloseGUIScreen(oPC, "SCREEN_MODEBAR");
	}
}