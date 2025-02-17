// gc_pnp_token
// DM Loki
// Version 1.0
// Conditional script for displaying names associated with pnp_turn_convo

#include "nw_i0_plot"

int StartingConditional(int iPlayerToken)
{
    object oPC = GetPCSpeaker();
	string sPCList = "sPC" + IntToString(iPlayerToken);
	string sName = GetLocalString(oPC,sPCList);
	SendMessageToAllDMs("gc_pnp_token: sName" + sName);//Debug
	if (sName != "")
	 {
	 SetCustomToken(iPlayerToken,sName);
	 SendMessageToAllDMs("gc_pnp_token: SetCustomToken" + IntToString(iPlayerToken));//Debug
	 return TRUE;
	 }
    return FALSE;
}