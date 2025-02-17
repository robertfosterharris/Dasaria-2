// i_pnpturn_ac
// DM Loki
// Version 2.1
// Activates GUI for players and DMs upon use of the P&P widget.
// 06/12/12

#include "inc_gui_timer_pnpturn"

void main()
{
if (GetGlobalInt("pnp_debug")>0) {SendMessageToAllDMs("i_pnpturn_ac.NSS Called by " + GetName(OBJECT_SELF));}//Debug

object oPC = GetItemActivator();

if ((GetIsDM(oPC)) || GetIsDM(OBJECT_SELF))
	{
	if (GetGlobalInt("pnp_debug")>1) {SendMessageToAllDMs("i_pnpturn_ac: Activator is DM");}//Debug
	DisplayGuiScreen(oPC, "PNP_SELECT_BAR_DM", FALSE, "pnp_select_bar_dm.xml");
	} else
		{
		if (GetGlobalInt("pnp_debug")>1) {SendMessageToAllDMs("i_pnpturn_ac: Activator is PC");}//Debug
		DisplayGuiScreen(oPC, "PNP_SELECT_BAR_PC", FALSE, "pnp_select_bar_pc.xml");
		}
}