//event_plc_autofire_hb
//Based on event_wired_trebuchet_hb by Wired
//By Loki
//Version 1.0
//07/26/12
//Controls firing of a placeable. Parameters are set via conversation event_plc_autofire_convo.

#include "catapult_boulder_throw"

void main()
{
if (GetGlobalInt("plc_fire_debug") >0) {SendMessageToAllDMs("event_plc_autofire_hb.NSS Called by " + GetName(OBJECT_SELF));}//Debug
object oPLC = OBJECT_SELF;
int iRateOfFire = GetLocalInt(oPLC, "iRateOfFire");
int nRand = Random(10);

if ( nRand < iRateOfFire )
	{
	//Get target
	object oTarget = GetNearestCreature(CREATURE_TYPE_REPUTATION, REPUTATION_TYPE_ENEMY, OBJECT_SELF, Random(4)+1, CREATURE_TYPE_PERCEPTION, PERCEPTION_SEEN);
	if (GetGlobalInt("plc_fire_debug") >2) {SendMessageToAllDMs("oTarget: " + GetName(oTarget));}//Debug
	
	//Set ammunition type
	string sAmmoType = GetLocalString(oPLC, "sAmmoType");
	if (GetGlobalInt("plc_fire_debug") >2) {SendMessageToAllDMs("sAmmoType: " + sAmmoType);}//Debug
	if (sAmmoType == "fireball")
		{
		ActionCastSpellAtObject(SPELL_CATAPULT, oTarget, METAMAGIC_ANY, TRUE, 0, PROJECTILE_PATH_TYPE_BALLISTIC_LAUNCHED, TRUE);
		//Set splash damage and duration
		int iSplashDmg = GetLocalInt(oPLC, "iSplashDmg");
		if (GetGlobalInt("plc_fire_debug") >2) {SendMessageToAllDMs("iSplashDmg: " + IntToString(iSplashDmg));}//Debug
		if (iSplashDmg >0)
			{
			string sSplashPLC = "aoe_fire_" + IntToString(iSplashDmg) + "d6";
			int iSplashDur = GetLocalInt(oPLC, "iSplashDur");
			if (GetGlobalInt("plc_fire_debug") >2) {SendMessageToAllDMs("iSplashDur: " + IntToString(iSplashDur));}//Debug
			float fDur = IntToFloat(iSplashDur)*6;
			//Spawn invisible fire AoE placeable
			float fTime	= TravelTime(GetLocation(oTarget));
			if (GetGlobalInt("plc_fire_debug") >2) {SendMessageToAllDMs("fTime: " + FloatToString(fTime));}//Debug
			DelayCommand(fTime, AssignCommand(GetArea(OBJECT_SELF), DestroyObject(CreateObject(OBJECT_TYPE_PLACEABLE, sSplashPLC, GetLocation(oTarget), TRUE, "BodyBag"), fDur)));
			}
		}
	if (sAmmoType == "grease")
		{
		ActionCastSpellAtObject(SPELL_GREASE, oTarget, METAMAGIC_ANY, TRUE, 0, PROJECTILE_PATH_TYPE_BALLISTIC_LAUNCHED, TRUE);
		}
	if (sAmmoType == "ActionCastSpellAtObject")
		{
		int iSpell = GetLocalInt(oPLC, "iSpell");
		if (GetGlobalInt("plc_fire_debug") >2) {SendMessageToAllDMs("iSpell: " + IntToString(iSpell));}//Debug
		ActionCastSpellAtObject(iSpell, oTarget, METAMAGIC_ANY, TRUE, 0, PROJECTILE_PATH_TYPE_HIGH_BALLISTIC, TRUE);
		}
	if (sAmmoType == "ActionCastSpellAtLocation")
		{
		int iSpell = GetLocalInt(oPLC, "iSpell");
		if (GetGlobalInt("plc_fire_debug") >2) {SendMessageToAllDMs("iSpell: " + IntToString(iSpell));}//Debug
		ActionCastSpellAtLocation(iSpell, GetLocation(oTarget), METAMAGIC_ANY, TRUE, PROJECTILE_PATH_TYPE_HIGH_BALLISTIC, TRUE);
		}
	if (sAmmoType == "boulder")
		{
		//Use target's own abilities to calulate attack mod
		catapultThrow(oTarget,OBJECT_SELF,GetLocation(oTarget));
		}
	}
}