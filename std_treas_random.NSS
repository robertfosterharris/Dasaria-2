//
//	CREATES RANDOM LOOTO AT WAYPOINTS
//
void makeLoot(object oObject)
{
	int nRespawnChance;
	object oLoot;
	string sLootResRef;
	
	nRespawnChance = GetLocalInt(oObject, "RespawnChance");
	if (nTrapRespawnChance == 0) nTrapRespawnChance = 100;	
	
	if (d100() <= nTrapRespawnChance)
	{
		if (GetObjectType(oObject) == OBJECT_TYPE_WAYPOINT)
		{
			sLootResRef = GetLocalString(oObject, "LootResRef");
			oLoot = CreateObject(OBJECT_TYPE_PLACEABLE,sLootResRef,GetLocation(oObject));
		}
	}
}