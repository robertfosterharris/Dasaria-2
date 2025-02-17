//	ONSPAWN SCRIPT 	RANDOMIZES THE APPEARANCE OF AN NPC.  SEE ALSO GB_COMMONER_UD.
//
//	OBJECT VARIABLES
//	string	SpawnScript 		- THE NAME OF THIS SCRIPT (CALLED FROM NW_C2_DEFAULT9)
//	string	sAppearanceList		- COMMA DELIMITED LIST OF APPEARANCE VALUES (SEE APPEARANCE_TYPE_* FOR VALUES)
//	string	sChance				- COMMA DELIMITED LIST OF VALUES REPRESENTING THE CHANCE OF THE NPC SPAWNING WITH PREVIOUSILY DEFINED APPEARANCE.  USE WHOLE NUMBERS THAT TOTAL 100.
//	string	sArmorList			- COMMA DELIMITED LIST OF RESREFS REPRESENTING THE NPCS WARDROBE.  THE NPC WILL WEAR ONE OF THESE ITEMS ON SPAWN.
//	int		nSizeVariance		- A WHOLE NUMBER REPRESENTING THE PERCENTAGE THE NPC'S SIZE WILL VARY
//
//	12/25/2011		ROBERT HARRIS		ROBERTHARRIS@ROBERTHARRIS.COM
//
#include "x0_i0_anims"
#include "x0_i0_stringlib"

void main()
{
	float fX;
	float fY;
	float fZ;
	int nAppearance;
	int nChance;
	int nChanceTotal;
	int nNth;
	int nSizeVariance;
	object oArmor;
	object oItem;
	string sChance;
	string sChanceList;
	string sArmor;
	string sArmorList;
	string sAppearanceList;
	
    //SetSpawnInCondition(NW_FLAG_HEARTBEAT_EVENT);        //OPTIONAL BEHAVIOR - Fire User Defined Event 1001
    //SetSpawnInCondition(NW_FLAG_PERCIEVE_EVENT);         //OPTIONAL BEHAVIOR - Fire User Defined Event 1002
	SetSpawnInCondition(NW_FLAG_ATTACK_EVENT);           //OPTIONAL BEHAVIOR - Fire User Defined Event 1005
    //SetSpawnInCondition(NW_FLAG_DAMAGED_EVENT);          //OPTIONAL BEHAVIOR - Fire User Defined Event 1006
    //SetSpawnInCondition(NW_FLAG_DISTURBED_EVENT);        //OPTIONAL BEHAVIOR - Fire User Defined Event 1008
    //SetSpawnInCondition(NW_FLAG_END_COMBAT_ROUND_EVENT); //OPTIONAL BEHAVIOR - Fire User Defined Event 1003
    SetSpawnInCondition(NW_FLAG_ON_DIALOGUE_EVENT);      //OPTIONAL BEHAVIOR - Fire User Defined Event 1004
    //SetSpawnInCondition(NW_FLAG_DEATH_EVENT);            //OPTIONAL BEHAVIOR - Fire User Defined Event 1007
//
//	SET RANDOM APPEARNCE
//
	nNth = 0;
	sAppearanceList = GetLocalString(OBJECT_SELF, "sAppearanceList");
	sChanceList = GetLocalString(OBJECT_SELF, "sChanceList");
	
	nChance = Random(100);
	sChance = GetTokenByPosition(sChanceList, ",", nNth);
	while (sChance != "")
	{
		nNth++;
		nChanceTotal += StringToInt(sChance);
		if (nChanceTotal > nChance) break;
		sChance = GetTokenByPosition(sChanceList, ",", nNth);
	}
	nAppearance = StringToInt(GetTokenByPosition(sAppearanceList, ",", nNth-1));
	SetCreatureAppearanceType(OBJECT_SELF, nAppearance);
//
//	SET RANDOM ARMOR
//
	nNth = 0;
	sArmorList = GetLocalString(OBJECT_SELF, "sArmorList");
	sArmor = GetTokenByPosition(sArmorList, ",", nNth);
	while (sArmor != "")
	{
		nNth++;
		sArmor = GetTokenByPosition(sArmorList, ",", nNth);
	}
	nNth = Random(nNth);
	sArmor = GetTokenByPosition(sArmorList, ",", nNth);
	oArmor = CreateItemOnObject(sArmor);
	SetDroppableFlag(oArmor, FALSE);
	AssignCommand(OBJECT_SELF, ActionEquipItem(oArmor, INVENTORY_SLOT_CHEST));
//
//
//	SET RANDOM SIZE
//
	nSizeVariance = GetLocalInt(OBJECT_SELF, "nSizeVariance");
	if (Random(100) < 50) 
	{
		fX = 1.0 + Random(nSizeVariance) / 100;
	}
	else
	{
		fX = 1.0 - Random(nSizeVariance) / 100;
	}
	if (Random(100) < 50) 
	{
		fY = 1.0 - Random(nSizeVariance) / 100;
	}
	else
	{
		fY = 1.0 - Random(nSizeVariance) / 100;
	}
	if (Random(100) < 50) 
	{
		fZ = 1.0 + Random(nSizeVariance) / 100;
	}
	else
	{
		fZ = 1.0 - Random(nSizeVariance) / 100;
	}
	SetScale(OBJECT_SELF, fX, fY, fZ);
}