// n_dynamicmap
// Chemical Agent
// Version 1.0
// Loads copy of campaign map and territory overlays when placed in OnUse script of an item
// 09/29/12
#include "ginc_renown"


void main()
{
if (GetGlobalInt("map_debug")>0) {SendMessageToAllDMs("n_dynamicmap.NSS Called by " + GetName(OBJECT_SELF));}//Debug

object oPC = GetLastUsedBy();
if (GetGlobalInt("map_debug")>2) {SendMessageToAllDMs("fScore: " + GetName(oPC));}//Debug

int iCanite = getRenownFromMetaFaction(3);
int iImperial = getRenownFromMetaFaction(1);
int iRebel = getRenownFromMetaFaction(2);

if (GetGlobalInt("map_stub")>0) {
	iCanite = 4500;
	iImperial = 2000;
	iRebel = 6000;
	}

if (GetGlobalInt("map_debug")>2) {
	SendMessageToAllDMs("iCanite: " + IntToString(iCanite));
	SendMessageToAllDMs("iImperial: " + IntToString(iImperial));
	SendMessageToAllDMs("iRebel: " + IntToString(iRebel));
	}//Debug

// Calculation of percentages based on scores
float fCanite,fImperial,fRebel,fAdjust,fScore;
fCanite = IntToFloat(iCanite);
fImperial = IntToFloat(iImperial);
fRebel = IntToFloat(iRebel);
fAdjust = 1.8f; //Adjustment factor for moving contested area in map
fScore = (fCanite * fAdjust) / (fCanite+ fImperial + fRebel);
if (GetGlobalInt("map_debug")>2) {SendMessageToAllDMs("fScore: " + FloatToString(fScore));}//Debug
//


// Display GUI screen and populate overlays
DisplayGuiScreen(oPC, "SCREEN_MAP_DYNAMIC", FALSE, "map_dynamic.xml");
SetGUIProgressBarPosition(oPC, "SCREEN_MAP_DYNAMIC", "CANITE_OVERLAY", 1.0f);
SetGUIProgressBarPosition(oPC, "SCREEN_MAP_DYNAMIC", "CONTESTED_OVERLAY", fScore);
SetGUIObjectText(oPC, "SCREEN_MAP_DYNAMIC", "SCORE_CANITES", -1, IntToString(iCanite));
SetGUIObjectText(oPC, "SCREEN_MAP_DYNAMIC", "SCORE_IMPERIALS", -1, IntToString(iImperial));
SetGUIObjectText(oPC, "SCREEN_MAP_DYNAMIC", "SCORE_REBELS", -1, IntToString(iRebel));

}