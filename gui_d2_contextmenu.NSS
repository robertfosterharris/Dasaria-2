// gui_d2_contextmenu
// wired 07/27/12

#include "std_inc_mounts"

void main()
{

	object oPC = OBJECT_SELF;
	object oTarget = GetPlayerCurrentTarget(oPC);
	
	if (bDEBUG_mounts) SendMessageToPC(oPC,"DEBUG: gui_d2_contextmenu is running!");
	
	// am i clicking on something mountable?
	// show mount node
 	if (GetIsMount(oTarget) )
	{	
		SetGUIObjectHidden(OBJECT_SELF,"SCREEN_CONTEXTMENU","node-mount",FALSE);
	}
	else
	{
		SetGUIObjectHidden(OBJECT_SELF,"SCREEN_CONTEXTMENU","node-mount",TRUE);
	}
	
	// am i clicking on myself and i am mounted?
	// show unmount node
 	if (oTarget == OBJECT_SELF && GetIsMounted(oPC) )
	{
		SetGUIObjectHidden(OBJECT_SELF,"SCREEN_CONTEXTMENU","node-dismount",FALSE);
	} 
	else
	{
		SetGUIObjectHidden(OBJECT_SELF,"SCREEN_CONTEXTMENU","node-dismount",TRUE);
	}	
}