// gui_pnpturn
// DM Loki
// Version 2.1
// Main script for PnP tool. Called by both DM and Player GUIs.
// 06/13/12

#include "inc_gui_timer_pnpturn"

void main(string sCase = "", string sTarget = "", string sName = "")
{
object oTarget,oCreature;
string sActivName;
int iCase;

object oPC = OBJECT_SELF;

if (GetGlobalInt("pnp_debug")>0) {SendMessageToAllDMs("gui_pnpturn.NSS Called by " + GetName(oPC));}//Debug
if (GetGlobalInt("pnp_debug")>2) {SendMessageToAllDMs("iCase: " + IntToString(iCase));}//Debug
iCase = StringToInt(sCase);
if (GetGlobalInt("pnp_debug")>2) {SendMessageToAllDMs("iCase: " + IntToString(iCase));}//Debug
if (GetGlobalInt("pnp_debug")>2) {SendMessageToAllDMs("sName: " + sName);}//Debug

switch (iCase)
	{
	case 1 : //Open player list display.
	if (GetGlobalInt("pnp_debug")>1) {SendMessageToAllDMs("Case 1 Fire");}//Debug
	DisplayGuiScreen(oPC, "SCREEN_PNP_LIST", FALSE, "pnp_list.xml");
	PnPList(oPC);
	break;
	
	case 2 : //Open player selection display.
	if (GetGlobalInt("pnp_debug")>1) {SendMessageToAllDMs("Case 2 Fire");}//Debug
	DisplayGuiScreen(oPC, "SCREEN_PNP_SELECT_LIST", FALSE, "pnp_select_list.xml");
	PnPSelect(oPC);
	break;
		
	case 3 : //Toggle single player from selection list
	if (GetGlobalInt("pnp_debug")>1) {SendMessageToAllDMs("Case 3 Fire");}//Debug
	oTarget = CreatureMatch(sName,1);
	if (GetGlobalInt("pnp_debug")>2) {SendMessageToAllDMs("gui_pnpturn oTarget: " + GetName(oTarget));}//Debug
	sActivName = GetPCPublicCDKey(oPC);
	
	if (GetItemPossessedBy(oTarget, "pnpturn") == OBJECT_INVALID)
		{
		if (GetGlobalInt("pnp_debug")>2) {SendMessageToAllDMs("gui_pnpturn: oTarget has no Widget " + GetName(oTarget));}//Debug
		CreateItemOnObject("psc_loki_pnpwidget", oTarget);
		}
		
	if (sActivName == GetLocalString(GetItemPossessedBy(oTarget, "pnpturn"), "sActivName"))
		{SetLocalString(GetItemPossessedBy(oTarget, "pnpturn"), "sActivName", "");}
		else
			{SetLocalString(GetItemPossessedBy(oTarget, "pnpturn"), "sActivName", sActivName);}
	PnPSelect(oPC);
	break;

	case 4 : //Reroll all Inits.
	if (GetGlobalInt("pnp_debug")>1) {SendMessageToAllDMs("Case 4 Fire");}//Debug
	PnPPopulate(oPC,OBJECT_INVALID);
	PnPSort(oPC);
	PnPListUpdate(oPC);
	break;

	case 5 : //Pause list for NPC action.
	if (GetGlobalInt("pnp_debug")>1) {SendMessageToAllDMs("Case 5 Fire");}//Debug
	//Remove any active pnpturn VFX
	sActivName = GetPCPublicCDKey(oPC);
	SetEffectSpellId(EffectNWN2SpecialEffectFile("pnpturneffect"),-50);
	oCreature = GetFirstPC(TRUE);
	while (GetIsObjectValid(oCreature))
		{
		effect eEffect = GetFirstEffect(oCreature);
		while (GetIsEffectValid(eEffect) && (sActivName == GetLocalString(GetItemPossessedBy(oCreature, "pnpturn"), "sActivName")))
			{
			SendMessageToPC(oCreature, "<c=gold>Turn: NPC</c>");
			if (GetEffectSpellId(eEffect) == -50)
				{RemoveEffect(oCreature, eEffect);}
			eEffect = GetNextEffect(oCreature);
			}
		oCreature = GetNextPC(TRUE);
		}
	break;
	
	case 6 : //Advance Turn.
	if (GetGlobalInt("pnp_debug")>1) {SendMessageToAllDMs("Case 6 Fire");}//Debug
	TurnAdvance(oPC);
	PnPListUpdate(oPC);
	break;
	
	case 7 : //Clear current player list.
	if (GetGlobalInt("pnp_debug")>1) {SendMessageToAllDMs("Case 7 Fire");}//Debug
	PnPClear(oPC);
	PnPSelect(oPC);
	break;

	case 8 : //Populate current player list.
	if (GetGlobalInt("pnp_debug")>1) {SendMessageToAllDMs("Case 8 Fire");}//Debug
	oTarget = StringToObject(sTarget);
	PnPPopulate(oPC,oTarget);
	PnPSort(oPC);
	PnPListUpdate(oPC);
	break;
	
	case 9 : //Kill timer function on PC.
	if (GetGlobalInt("pnp_debug")>1) {SendMessageToAllDMs("Case 9 Fire");}//Debug
	ClearUpTimer(oPC);
	break;
			      
	default : //None of the above happens.
	if (GetGlobalInt("pnp_debug")>1) {SendMessageToAllDMs("Default Case Statement Fire");}//Debug
	}
}