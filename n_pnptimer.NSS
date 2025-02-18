// n_pnptimer
// DM Loki
// Version 2.1
// Called by DecTimer function at expiration of time limit for PnP script.
// Advances turn to next player.
// 06/12/12

#include "inc_gui_timer_pnpturn"

void main()
{
if (GetGlobalInt("pnp_debug")>0) {SendMessageToAllDMs("n_pnptimer.NSS Called by " + GetName(OBJECT_SELF));}//Debug

string sGender;
object oPC = OBJECT_SELF;

if (GetGender(oPC))
	{sGender = "her";}
	else
		{sGender = "his";}
		
if (GetGlobalInt("pnp_debug")>2) {SendMessageToAllDMs("Gender oPC: " + IntToString(GetGender(oPC)));}//Debug				
if (GetGlobalInt("pnp_debug")>2) {SendMessageToAllDMs("Gender oPC: " + sGender);}//Debug

string sName = GetName(oPC);
FloatingTextStringOnCreature("<c=gold>" + sName + " passes on " + sGender + " turn.</c>", oPC, TRUE);

TurnAdvance(OBJECT_SELF);
PnPListUpdate(OBJECT_SELF);

}