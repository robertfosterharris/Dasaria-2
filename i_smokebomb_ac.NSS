//i_smokebomb_ac
//By Loki
//Version 1.2
//02/01/13
//Reads target from UniquePower activation and deploys timed smoke vfx at location

void main()
{
if (GetGlobalInt("smokebomb_debug") >0) {SendMessageToAllDMs("i_smokebomb_ac.NSS Called by " + GetName(OBJECT_SELF));}//Debug
object oItem = GetItemActivated();
object oPC = GetItemActivator();

//Get target
location lTarget = GetItemActivatedTargetLocation();
vector vTarget = GetPositionFromLocation(lTarget);
if (GetGlobalInt("smokebomb_debug")>1) {SendMessageToAllDMs("TargetLocation(" + FloatToString(vTarget.x) + ", " + FloatToString(vTarget.y) + ", " + FloatToString(vTarget.z) + ")");}//Debug
	
//Set ammunition type
string sAmmoType = GetLocalString(oItem, "sAmmoType");
if (GetGlobalInt("smokebomb_debug") >2) {SendMessageToAllDMs("sAmmoType: " + sAmmoType);}//Debug
if (sAmmoType == "smoke")
	{
	//ActionCastSpellAtLocation(SPELL_GREASE, lTarget, METAMAGIC_ANY, TRUE, 0, PROJECTILE_PATH_TYPE_BALLISTIC_LAUNCHED, TRUE);
	effect eVFX = EffectNWN2SpecialEffectFile("fx_smoke_bomb_large");
	float fTime	= GetProjectileTravelTime(GetLocation(oPC), lTarget, PROJECTILE_PATH_TYPE_DEFAULT, IP_CONST_CASTSPELL_GRENADE_THUNDERSTONE_1);
	if (GetGlobalInt("smokebomb_debug") >2) {SendMessageToAllDMs("fTime: " + FloatToString(fTime));}//Debug
	DelayCommand(fTime, AssignCommand(oPC, ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, eVFX, lTarget, 60.0f)));
	}
	
if (sAmmoType == "smoke_small")
	{
	//ActionCastSpellAtLocation(SPELL_GREASE, lTarget, METAMAGIC_ANY, TRUE, 0, PROJECTILE_PATH_TYPE_BALLISTIC_LAUNCHED, TRUE);
	effect eVFX = EffectNWN2SpecialEffectFile("fx_smoke_bomb_small");
	float fTime	= GetProjectileTravelTime(GetLocation(oPC), lTarget, PROJECTILE_PATH_TYPE_DEFAULT, IP_CONST_CASTSPELL_GRENADE_THUNDERSTONE_1);
	if (GetGlobalInt("smokebomb_debug") >2) {SendMessageToAllDMs("fTime: " + FloatToString(fTime));}//Debug
	DelayCommand(fTime, AssignCommand(oPC, ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, eVFX, lTarget, 30.0f)));
	}
	
}