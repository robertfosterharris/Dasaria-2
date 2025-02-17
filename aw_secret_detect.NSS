//aw_secret_detect
//General script for spawning secret objects with OnEnter triggers. Reads variables directly from trigger.
//Spawned items will remain for 60 seconds, centered on sTarget.
//sTarget - object to spawn secret door on top of
//sPlaceable - placeable to use for secret entrance
//iDC - DC for search check to find item
//Loki - 07/27/12

void main()
{
	if (GetGlobalInt("waa_debug")>0) {SendMessageToAllDMs("n_secret_detect.NSS Called by " + GetName(OBJECT_SELF));}//Debug 
	object oPC = GetEnteringObject();
	object oTarget = GetObjectByTag(GetLocalString(OBJECT_SELF, "sTarget"));
	if (GetGlobalInt("waa_debug")>2) {SendMessageToAllDMs("oTarget: " + GetName(oTarget));}//Debug
	
	int iDC = GetLocalInt(OBJECT_SELF, "iDC");
	if (GetGlobalInt("waa_debug")>2) {SendMessageToAllDMs("iDC: " + IntToString(iDC));}//Debug
	
	if (GetIsSkillSuccessful(oPC, SKILL_SEARCH, iDC, FALSE))
		{
		string sPlaceable = GetLocalString(OBJECT_SELF, "sPlaceable");
		if (GetGlobalInt("waa_debug")>2) {SendMessageToAllDMs("sPlaceable: " + sPlaceable);}//Debug
		object oEntrance = CreateObject(OBJECT_TYPE_PLACEABLE, sPlaceable, GetLocation(oTarget), TRUE, "BodyBag");
		AssignCommand(oEntrance, DestroyObject(OBJECT_SELF, 60.f));
		return;
		}

}