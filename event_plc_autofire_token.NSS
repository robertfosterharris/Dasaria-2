//event_plc_autofire_token
//By Loki
//Version 1.0
//07/26/12
//Sets tokens for event_plc_autofire_convo object dialogue

void main()
{
if (GetGlobalInt("plc_fire_debug") >0) {SendMessageToAllDMs("event_plc_autofire_token.NSS Called by " + GetName(OBJECT_SELF));}//Debug
object oPLC = OBJECT_SELF;

int iRateOfFire = GetLocalInt(oPLC, "iRateOfFire");
SetCustomToken(1501, IntToString(iRateOfFire));
if (GetGlobalInt("plc_fire_debug") >2) {SendMessageToAllDMs("SetCustomToken 1501: " + IntToString(iRateOfFire));}//Debug

string sAmmoType = GetLocalString(oPLC, "sAmmoType");
if (sAmmoType == "ActionCastSpellAtObject")
	{
	int iSpell = GetLocalInt(oPLC, "iSpell");
	sAmmoType = "iSpell - " + IntToString(iSpell);
	}
SetCustomToken(1502, sAmmoType);
if (GetGlobalInt("plc_fire_debug") >2) {SendMessageToAllDMs("SetCustomToken 1502: " + sAmmoType);}//Debug

int iSplashDmg = GetLocalInt(oPLC, "iSplashDmg");
SetCustomToken(1503, IntToString(iSplashDmg));
if (GetGlobalInt("plc_fire_debug") >2) {SendMessageToAllDMs("SetCustomToken 1503: " + IntToString(iSplashDmg));}//Debug

int iSplashDur = GetLocalInt(oPLC, "iSplashDur");
SetCustomToken(1504, IntToString(iSplashDur));
if (GetGlobalInt("plc_fire_debug") >2) {SendMessageToAllDMs("SetCustomToken 1504: " + IntToString(iSplashDur));}//Debug

}