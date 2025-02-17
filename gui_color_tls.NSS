//*/////////////////////////////////////////////////////////////////////////////
//------------------------------------------------------------------------------ 
// gui_color_tls - Elechos - Script de GUI : Calcule une couleur RGB grace 
//								aux valeurs envoyé en TLS
// Scripteur:  Tyrnis
// Dernière Modification : 08 / 12 / 2007
//------------------------------------------------------------------------------
//*/////////////////////////////////////////////////////////////////////////////


#include "nwnx_craft_system"

void main (int iTeinte, int iLuminosite, int iSaturation)
{	
	//XPCraft_Debug(OBJECT_SELF,"TLS : \n T = " + IntToString(iTeinte) + "\n L = " + IntToString(iLuminosite) + "\n S = " + IntToString(iSaturation));
	object oPC = GetControlledCharacter(OBJECT_SELF);
	
	//Ath: Dummy tryouts 
	string sTailor = GetLocalString(oPC,"XPCraft_Tailor");
	object oTailor = GetObjectByTag(sTailor);
	
		
	struct strTint strMyTint = XPCraft_HLSToTintStruct(iTeinte, iLuminosite, iSaturation);
	int iNewColorValue =  XPCraft_strTintToInt(strMyTint);
	
	if (sTailor != "") //Ath: test condition. REMOVE ME WHEN TESTING IS OVER!!!!!!!!!!!!!!!!!
	SetLocalObject(oTailor, "XC_ITEM_TO_CRAFT", XPCraft_ActionChangeColor(oTailor, iNewColorValue));
	
	else
	SetLocalObject(oPC, "XC_ITEM_TO_CRAFT", XPCraft_ActionChangeColor(oPC, iNewColorValue));
		 
}