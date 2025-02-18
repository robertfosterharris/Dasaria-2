//	COHORT SYSTEM FUNCTIONS
//
//	ROBERT HARRIS	11/08/2013	ROBERTHARRIS@ROBERTHARRIS.COM
//
#include "x0_i0_stringlib"
#include "nw_i0_henchman"
#include "nwnx_include"
#include "nwnx_objectattributes_include"
#include "nwnx_sql"
#include "x2_inc_itemprop"
//
//	MISSING FEAT CONSTANTS
//
const int FEAT_MONK_UNARMED_STRIKE = 1762;
const int FEAT_PALADIN_MOUNT = 3041;
const int FEAT_WEAPON_PROFICIENCY_BARD = 1763;
const int FEAT_WEAPON_PROFICIENCY_DWARF = 1770;
const int FEAT_WEAPON_PROFICIENCY_SPIRIT_SHAMAN = 2015;
//
//	COMMA DELIMITED LIST OF COHORT APPEARANCE OPTIONS	
//
const string HEADS_DWARF_FEMALE		= "1,2,3,4,5,6";
const string HEADS_DWARF_MALE		= "1,2,3,4,5,6";
const string HEADS_ELF_FEMALE		= "1,2,3,4,5,6,7,8,43,44,51,52,53,61,62,63,78,83,86,92,93,94,99";
const string HEADS_ELF_MALE			= "1,2,3,4,5,6,7,8,18,83,86";
const string HEADS_GNOME_FEMALE		= "1,2,3,4,7";
const string HEADS_GNOME_MALE		= "1,2,3,4,5,6,7,8,10";
const string HEADS_HALFELF_FEMALE	= "1,2,3,4,5,6,70,71,83,86,92,93,94,95";
const string HEADS_HALFELF_MALE		= "1,2,3,4,5,6,11,12,13,14,15";
const string HEADS_HALFLING_FEMALE	= "1,2,3,4,5,6,7,8,9,84,85,86";
const string HEADS_HALFLING_MALE	= "1,2,3,4,5,6,7,8,9,10";
const string HEADS_HALFORC_FEMALE	= "1,2,3,4,5,6,7";
const string HEADS_HALFORC_MALE		= "1,2,3,4,5,6";
const string HEADS_HUMAN_FEMALE		= "1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,21,22,31,32,33,34,35,36,37,45,47,51,52,53,54,62,65,70,75,82,88,89,91,94,95,97";
const string HEADS_HUMAN_MALE		= "1,2,3,4,5,6,7,8,9,10,12,13,14,15,16,17,18,19,20,22,23,24,81,82,83,84,85,86,87,99";

const string HAIR_DWARF_FEMALE		= "1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,60,73,94";
const string HAIR_DWARF_MALE		= "1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,60,61,62,94";
const string HAIR_ELF_FEMALE		= "1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,50,51,52,53,54,55,56,57,58,59,60,61,62,63,64,66,67,70,71,72,73,74,75,76,80,81,82,83,84,85,86,87,88,89,90,91,92,93,94,101,102,104,105,106,107,108,109,110,111,112";
const string HAIR_ELF_MALE			= "1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,50,51,52,60,61,62,74,75,80,81,82,94";
const string HAIR_GNOME_FEMALE		= "1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,61,62,71,72,73,94";
const string HAIR_GNOME_MALE		= "1,2,3,4,5,6,7,8,10,11,12,13,14,15,16,17,94";
const string HAIR_HALFELF_FEMALE	= "1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,50,51,52,53,54,55,56,57,58,59,60,61,62,63,64,66,67,70,71,72,73,74,75,76,77,78,79,80,81,82,84,85,86,87,88,89,90,91,92,93,94,101,102,104,105,106,107,108,109,110,111,112,113,114,115";
const string HAIR_HALFELF_MALE		= "1,2,3,4,5,6,11,12,13,14,15,16,17,37,38,40,50,51,52,60,61,62,74,75,80,81,82,85,94,101";
const string HAIR_HALFLING_FEMALE	= "1,2,3,4,5,6,7,8,10,11,12,13,14,15,16,17,19,66,73,74,75,80,94,111,112";
const string HAIR_HALFLING_MALE		= "1,2,3,4,5,6,7,8,10,11,12,13,14,15,16,17,19,66,74,75,94";
const string HAIR_HALFORC_FEMALE	= "1,2,3,4,5,6,7,8,10,11,12,13,14,15,16,17,19,90,94";
const string HAIR_HALFORC_MALE		= "1,2,3,4,5,6,7,8,10,11,12,13,14,15,16,17,19,94";
const string HAIR_HUMAN_FEMALE		= "1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,50,51,52,53,54,55,56,57,58,59,60,61,62,63,64,66,67,70,71,72,73,74,75,76,77,78,79,80,81,82,84,85,86,87,88,89,90,91,92,93,94,101,102,104,105,106,107,108,109,110,111,112,113,114,115";
const string HAIR_HUMAN_MALE		= "1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,37,38,40,50,51,52,60,61,62,74,75,80,81,82,85,94,101";

const string SOUNDSET_FEMALE		= "357,358,359,360,361,421,422,423,433,460,461,462,463,464,526,532";
const string SOUNDSET_MALE			= "363,364,365,366,367,368,418,419,420,465,466,467,468,469,525,531";

//
//	COHORT STATUS CONSTANTS
//
const string COHORT_STATUS_ALIVE		= "1";
const string COHORT_STATUS_DEAD			= "2";
const string COHORT_STATUS_FIRED		= "3";

//
//	FUNCTION PROTOTYPES
//
float GetRGBVariant(float fColor, int nPercent);
int ExpToLevel(int nExperience);
int GetLeadershipScore(object oPC);
int GetRandomPackage(object oCreature, string sMetaClass);
int GetStartingLevel(object oPC);
int LevelToExp(int nLevel);
object CreateCohort(object oPC, string sMetaClass = "", string sRace = "", string sGender = "", int nLevel = 0);
string GetBestArmor(object oCreature);
string GetBestGear(object oCreature);
string GetBestShield(object oCreature);
string GetBestWeapons(object oCreature, int bRanged);
string getPCid(object oPC);
string GetRandomGender();
string GetRandomName(string sRace, string sGender);
string GetRandomRace();
string GetRandomToken(string sDelimitedList, string sDelimiter);
void CreateInventory(object oCreature);
void CreateItemsOnObject(string sResrefs, object oCreature);
void DestroyCohort(object oCreature);
void DestroyInventory(object oCreature);
void EnchantInventory(object oCreature);
void EquipInventory(object oCreature);
void InitializeCohort(object oCreature);
void JumpCohort(object oCreature);
void SaveCohort(object oCreature, string sStatus = "1");
void SetAbilities(object oCreature);
void SetPackage(object oCreature, int nPackage);
void SetRandomAlignment(object oCreature, object oPC);
void SetRandomDeity(object oCreature);
void SetRandomFacialHair(object oCreature);
void SetRandomHair(object oCreature);
void SetRandomHead(object oCreature);
void SetRandomScale(object oCreature);
void SetRandomSoundSet(object oCreature);
void SetRandomTint(object oCreature);
void SetVariables(object oCreature);
void SummonCohort(object oCreature);

//
//	COPIED FROM N2_SQL (USING AN INCLUDE IS A REFERENCE NIGHTMARE)
//
string getPCid(object oPC)
{
	string sBicName;
	
	if (!GetIsObjectValid(oPC) || !GetIsPC(oPC) ) return "ERROR_OBJ_INVALID";
	
	// give DMs pcid zero
	if (GetIsDM(oPC)) 
	{
		//sBicName = "[DM] "+GetPCPlayerName(oPC);
		SetLocalString( oPC, "pcid", "0");	
		return "0";
	}
	// regular player
	else 
	{	
		sBicName = GetBicFileName(oPC);
		
		// local vault character, invalid
		if (sBicName == "SERVERVAULT:temp_char")
		{
			SetLocalString(oPC,"pcid","ERROR_OBJ_INVALID");
			return "ERROR_OBJ_INVALID";
		}
		
		// safety first!
		sBicName = SQLEncodeSpecialChars(sBicName);
	
	    SQLExecDirect("SELECT pcid FROM pc_data WHERE bic_name = '" + sBicName + "'");
	    if (SQLFetch()) 
		{
			// find the pc
	        return SQLGetData(1);
	    }
		else
		{
			// else new pc
	   		return "NEW";
		}
	}
}

//
//	INITIALIZATION OF COHORT OBJECT.  THE COHORT OBJECT NEEDS TIME TO INSTANTIATE, SO THIS FUNCTION IS SEPERATED FROM CREATECOHORT().
//
void InitializeCohort(object oCreature)
{
	int nLevel;
	int nPackage;
	object oPC;
	string sMetaClass;

	oPC = GetLocalObject(oCreature, "oPC");
	sMetaClass = GetLocalString(oCreature, "sMetaClass");
	nLevel = GetLocalInt(oCreature, "nLevel");

	if (nLevel == 0) nLevel = GetStartingLevel(oPC);

	SetRandomAlignment(oCreature, oPC);					//	ALIGNMENT NEEDED FOR PACKAGE RESTRICTIONS
	
	nPackage = GetRandomPackage(oCreature, sMetaClass);	//	PACKAGE NEEDED FOR SCALE ADJUSTMENTS
	
	SetPackage(oCreature, nPackage);					
	SetRandomScale(oCreature);
	SetRandomHead(oCreature);
	SetRandomHair(oCreature);
	SetRandomFacialHair(oCreature);
	SetRandomTint(oCreature);
	SetRandomSoundSet(oCreature);
	SetRandomDeity(oCreature);
	SetXP(oCreature, LevelToExp(nLevel));
	SetPackage(oCreature, nPackage);

	DeleteLocalString(oCreature, "sMetaClass");
	DeleteLocalInt(oCreature, "nLevel");
}

//
//	REMOVES ALL ITEMS FROM oCREATURE
//
void DestroyInventory(object oCreature)
{
	int nNth;
	object oItem;
	
	//
	//	DESTROY INVENTORY ITEMS
	//
	oItem = GetFirstItemInInventory(oCreature);
	while(GetIsObjectValid(oItem))
	{
		DestroyObject(oItem);
		oItem = GetNextItemInInventory(oCreature);
	}
	//
	//	DESTROY EQUIPPED ITEMS
	//
	for (nNth = 0; nNth < NUM_INVENTORY_SLOTS; nNth++)
	{
		oItem = GetItemInSlot(nNth, oCreature);
		if (GetIsObjectValid(oItem) && GetBaseItemType(oItem) != BASE_ITEM_AMULET && GetBaseItemType(oItem) != BASE_ITEM_CLOAK && GetBaseItemType(oItem) != BASE_ITEM_RING)
		{
			DestroyObject(oItem);
		}
	}
}

//
//	GIVES oCREATURE THE COMMA DELIMITED LIST OF sRESREFS
//
void CreateItemsOnObject(string sResrefs, object oCreature)
{
	int nNth;
	object oItem;
	string sResref;
	string sResrefList;
	//
	//	REMOVE NULL FIELDS THAT COULD TERMINATE THE LOOP PREMATURELY
	//
	sResrefList = sResrefs;
	
	nNth = FindSubString(sResrefList, ",,");
	while (nNth != -1)
	{
		sResrefList = GetStringLeft(sResrefList, nNth) + GetStringRight(sResrefList, GetStringLength(sResrefList) - nNth - 1);
		nNth = FindSubString(sResrefList, ",,");
	}
	//
	//	REMOVE TRAILING DELIMITER
	//
	if (GetStringRight(sResrefList, 1) == ",") sResrefList = GetStringLeft(sResrefList, GetStringLength(sResrefList) - 1);

	//
	//	CREATE ITEMS
	//
	nNth = 0;
	sResref = GetTokenByPosition(sResrefList, ",", nNth);
	while (sResref != "")
	{
		oItem = CreateItemOnObject(sResref, oCreature);
		SetIdentified(oItem, TRUE);
		SetDroppableFlag(oItem, FALSE);
		nNth++;
		sResref = GetTokenByPosition(sResrefList, ",", nNth);
	}
}

//
//	SETS A CREATURES ABILITIES TO THE DEFAULTS FOR LEVEL UP PACKAGE AND RACE
//
void SetAbilities(object oCreature)
{
	int nPackage;
	int nClass;
	int nSubRace;
	int nChaBase;
	int nChaRace;
	int nConBase;
	int nConRace;
	int nDexBase;
	int nDexRace;
	int nIntBase;
	int nIntRace;
	int nStrBase;
	int nStrRace;
	int nWisBase;
	int nWisRace;
	
	nPackage = GetLevelUpPackage(oCreature);
	nClass = StringToInt(Get2DAString("packages", "ClassID", nPackage));
	nSubRace = GetSubRace(oCreature);

	nChaBase = StringToInt(Get2DAString("classes", "Cha", nClass));
	nChaRace = StringToInt(Get2DAString("racialsubtypes", "ChaAdjust", nSubRace));
	
	nConBase = StringToInt(Get2DAString("classes", "Con", nClass));
	nConRace = StringToInt(Get2DAString("racialsubtypes", "ConAdjust", nSubRace));
	
	nDexBase = StringToInt(Get2DAString("classes", "Dex", nClass));
	nDexRace = StringToInt(Get2DAString("racialsubtypes", "DexAdjust", nSubRace));
	
	nIntBase = StringToInt(Get2DAString("classes", "Int", nClass));
	nIntRace = StringToInt(Get2DAString("racialsubtypes", "IntAdjust", nSubRace));
	
	nStrBase = StringToInt(Get2DAString("classes", "Str", nClass));
	nStrRace = StringToInt(Get2DAString("racialsubtypes", "StrAdjust", nSubRace));
	
	nWisBase = StringToInt(Get2DAString("classes", "Wis", nClass));
	nWisRace = StringToInt(Get2DAString("racialsubtypes", "WisAdjust", nSubRace));
	
	SetBaseAbilityScore(oCreature, ABILITY_CHARISMA, nChaBase + nChaRace);
	SetBaseAbilityScore(oCreature, ABILITY_CONSTITUTION, nConBase + nConRace);
	SetBaseAbilityScore(oCreature, ABILITY_DEXTERITY, nDexBase + nDexRace);
	SetBaseAbilityScore(oCreature, ABILITY_INTELLIGENCE, nIntBase + nIntRace);
	SetBaseAbilityScore(oCreature, ABILITY_STRENGTH, nStrBase + nStrRace);
	SetBaseAbilityScore(oCreature, ABILITY_WISDOM, nWisBase + nWisRace);
}

//
//	CHANGES A CREATURES LEVEL UP PACKAGE
//
void SetPackage(object oCreature, int nPackage)
{
	int nXP;
	
	nXP = GetXP(oCreature);
	
	ResetCreatureLevelForXP(oCreature, 0, FALSE);
	SetLevelUpPackage(oCreature, nPackage);
	SetAbilities(oCreature);
	ResetCreatureLevelForXP(oCreature, nXP, FALSE);
	ForceRest(oCreature);
}

//
//	FINDS THE OPTIMAL ARMOR FOR oCREATURE.  RETURNS A RESREF FOR THAT TYPE OF ARMOR.
//
string GetBestArmor(object oCreature)
{
	int nAlignment;
	int nArmor;
	int nACBonus;
	int nDexBonus;
	int nTotalAC;
	int nDexModifier;
	int nBestAC;
	string sItem;
	
	nAlignment = GetGoodEvilValue(oCreature);
	nBestAC = 0;
	nDexModifier = GetAbilityScore(oCreature, ABILITY_DEXTERITY, TRUE) / 2 - 5;
	
	if (GetHasFeat(FEAT_ARMOR_PROFICIENCY_HEAVY, oCreature))
	{
		//
		//	FULL PLATE		
		//
		nDexBonus = nDexModifier;
		if (nDexBonus > 1) nDexBonus = 1;
		nTotalAC = 8 + nDexBonus;
		
		if (nTotalAC >= nBestAC)
		{
			nBestAC = nTotalAC;
			if (nAlignment >= 0 && nAlignment <= 30)	sItem = "cohort_plate_evil";
			if (nAlignment >= 31 && nAlignment <= 69)	sItem = "cohort_plate_neutral";
			if (nAlignment >= 70 && nAlignment <= 100)	sItem = "cohort_plate_good";
		}
	}
	if (GetHasFeat(FEAT_ARMOR_PROFICIENCY_MEDIUM, oCreature))
	{
		//
		//	BREASTPLATE		
		//
		nDexBonus = nDexModifier;
		if (nDexBonus > 3) nDexBonus = 3;
		nTotalAC = 5 + nDexBonus;
		
		if (nTotalAC >= nBestAC)
		{
			nBestAC = nTotalAC;
			if (nAlignment >= 0 && nAlignment <= 30)	sItem = "cohort_breastplate_evil";
			if (nAlignment >= 31 && nAlignment <= 69)	sItem = "cohort_breastplate_neutral";
			if (nAlignment >= 70 && nAlignment <= 100)	sItem = "cohort_breastplate_good";
		}
	}
	if (GetHasFeat(FEAT_ARMOR_PROFICIENCY_LIGHT, oCreature))
	{
		//
		//	CHAIN SHIRT		
		//
		nDexBonus = nDexModifier;
		if (nDexBonus > 4) nDexBonus = 4;
		nTotalAC = 4 + nDexBonus;
		
		if (nTotalAC >= nBestAC)
		{
			nBestAC = nTotalAC;
			if (nAlignment >= 0 && nAlignment <= 30)	sItem = "cohort_chainshirt_evil";
			if (nAlignment >= 31 && nAlignment <= 69)	sItem = "cohort_chainshirt_neutral";
			if (nAlignment >= 70 && nAlignment <= 100)	sItem = "cohort_chainshirt_good";
		}
		//
		//	STUDDED LEATHER
		//
		nDexBonus = nDexModifier;
		if (nDexBonus > 5) nDexBonus = 5;
		nTotalAC = 3 + nDexBonus;
		
		if (nTotalAC >= nBestAC)
		{
			nBestAC = nTotalAC;
			if (nAlignment >= 0 && nAlignment <= 30)	sItem = "cohort_studded_evil";
			if (nAlignment >= 31 && nAlignment <= 69)	sItem = "cohort_studded_neutral";
			if (nAlignment >= 70 && nAlignment <= 100)	sItem = "cohort_studded_good";
		}
		//
		//	LEATHER
		//
		nDexBonus = nDexModifier;
		if (nDexBonus > 6) nDexBonus = 6;
		nTotalAC = 2 + nDexBonus;
		
		if (nTotalAC >= nBestAC)
		{
			nBestAC = nTotalAC;
			if (nAlignment >= 0 && nAlignment <= 30)	sItem = "cohort_leather_evil";
			if (nAlignment >= 31 && nAlignment <= 69)	sItem = "cohort_leather_neutral";
			if (nAlignment >= 70 && nAlignment <= 100)	sItem = "cohort_leather_good";
		}
		//
		//	PADDED
		//
		nDexBonus = nDexModifier;
		if (nDexBonus > 8) nDexBonus = 8;
		nTotalAC = 1 + nDexBonus;
		
		if (nTotalAC >= nBestAC)
		{
			nBestAC = nTotalAC;
			if (nAlignment >= 0 && nAlignment <= 30)	sItem = "cohort_padded_evil";
			if (nAlignment >= 31 && nAlignment <= 69)	sItem = "cohort_padded_neutral";
			if (nAlignment >= 70 && nAlignment <= 100)	sItem = "cohort_padded_good";
		}
	}
	//
	//	CLOTHING
	//
	nTotalAC = nDexModifier;
	
	if (nTotalAC >= nBestAC)
	{
		nBestAC = nTotalAC;
		if (nAlignment >= 0 && nAlignment <= 30)	sItem = "cohort_cloth_evil";
		if (nAlignment >= 31 && nAlignment <= 69)	sItem = "cohort_cloth_neutral";
		if (nAlignment >= 70 && nAlignment <= 100)	sItem = "cohort_cloth_good";
	}
	
return sItem;
}

//
//	FINDS THE OPTIMAL SHIELD FOR oCREATURE.  RETURNS A RESREF FOR THAT TYPE OF SHIELD.
//
string GetBestShield(object oCreature)
{
	string sItem;

	sItem = "";
		
	if (GetHasFeat(FEAT_SHIELD_PROFICIENCY, oCreature) && !(GetHasFeat(FEAT_TWO_WEAPON_FIGHTING, oCreature) || GetHasFeat(FEAT_COMBATSTYLE_RANGER_DUAL_WIELD, oCreature)))
	{
		if (GetHasFeat(FEAT_TOWER_SHIELD_PROFICIENCY, oCreature) && GetCreatureSize(oCreature) == CREATURE_SIZE_MEDIUM)
		{
			sItem = "nw_ashto001";
		}
		else
		{
			sItem = "nw_ashlw001";
		}
	}
	
return sItem;
}

//
//	FINDS THE OPTIMAL WEAPONS FOR oCREATURE.  RETURNS A COMMA DELIMITED LIST OF RESREFS FOR THOSE WEAPONS.
//
string GetBestWeapons(object oCreature, int bRanged)
{
	int nCount;
	int nCriticalFeat;
	int nFocusFeat;
	int nSize;
	int nOptimalSize;
	string sDefaultWeapon;
	string sSQL;
	string sItem;
//
//	DETERMINE OPTIMAL WEAPON SIZE
//	
	nOptimalSize = GetCreatureSize(oCreature) + 2;
	if (GetHasFeat(FEAT_MONKEY_GRIP, oCreature)) nOptimalSize++;
	if (bRanged == FALSE)
	{
		if (GetHasFeat(FEAT_SHIELD_PROFICIENCY, oCreature) || GetHasFeat(FEAT_COMBATSTYLE_RANGER_DUAL_WIELD, oCreature) || GetHasFeat(FEAT_TWO_WEAPON_FIGHTING, oCreature) || GetHasFeat(FEAT_WEAPON_FINESSE, oCreature)) nOptimalSize--;	//	USE ONE HANDED WEAPONS
		if (GetHasFeat(FEAT_COMBATSTYLE_RANGER_DUAL_WIELD, oCreature) || GetHasFeat(FEAT_TWO_WEAPON_FIGHTING, oCreature)) nOptimalSize--;																									//	USE SMALLER ONE HANDED WEAPONS
	}
//
//	GET OPTIMAL WEAPONS FROM DATABASE
//
	sSQL = "SELECT resref, critical_feat, focus_feat FROM cohort_weapons WHERE (";
	if (GetHasFeat(FEAT_WEAPON_PROFICIENCY_BARD, oCreature))			sSQL = sSQL + "proficiency_bard = TRUE OR ";
	if (GetHasFeat(FEAT_WEAPON_PROFICIENCY_DRUID, oCreature))			sSQL = sSQL + "proficiency_druid = TRUE OR ";
	if (GetHasFeat(FEAT_WEAPON_PROFICIENCY_DWARF, oCreature))			sSQL = sSQL + "proficiency_dwarf = TRUE OR ";
	if (GetHasFeat(FEAT_WEAPON_PROFICIENCY_ELF, oCreature))				sSQL = sSQL + "proficiency_elf = TRUE OR ";
	if (GetHasFeat(FEAT_WEAPON_PROFICIENCY_EXOTIC, oCreature))			sSQL = sSQL + "proficiency_exotic = TRUE OR ";
	if (GetHasFeat(FEAT_WEAPON_PROFICIENCY_MARTIAL, oCreature))			sSQL = sSQL + "proficiency_martial = TRUE OR ";
	if (GetHasFeat(FEAT_WEAPON_PROFICIENCY_MONK, oCreature))			sSQL = sSQL + "proficiency_monk = TRUE OR ";
	if (GetHasFeat(FEAT_WEAPON_PROFICIENCY_ROGUE, oCreature))			sSQL = sSQL + "proficiency_rogue = TRUE OR ";
	if (GetHasFeat(FEAT_WEAPON_PROFICIENCY_SIMPLE, oCreature))			sSQL = sSQL + "proficiency_simple = TRUE OR ";
	if (GetHasFeat(FEAT_WEAPON_PROFICIENCY_SPIRIT_SHAMAN, oCreature))	sSQL = sSQL + "proficiency_spirit_shaman = TRUE OR ";
	if (GetHasFeat(FEAT_WEAPON_PROFICIENCY_WIZARD, oCreature))			sSQL = sSQL + "proficiency_wizard = TRUE OR ";
	sSQL = GetStringLeft(sSQL, GetStringLength(sSQL)-4) + ") ";
	
	if (bRanged)
	{
		sSQL = sSQL + "AND ranged = TRUE ";
		if (GetHasFeat(FEAT_RAPID_SHOT, oCreature) || GetHasFeat(FEAT_COMBATSTYLE_RANGER_ARCHERY_RAPID_SHOT, oCreature)) sSQL = sSQL + "AND id != 6 AND id != 7 ";	//	EXCLUDE CROSSBOWS
	}
	else
	{
		sSQL = sSQL + "AND ranged = FALSE ";
		if (GetHasFeat(FEAT_WEAPON_FINESSE, oCreature)) sSQL = sSQL + "AND finesse = TRUE ";
	}
	
	sSQL = sSQL + "AND size < " + IntToString(nOptimalSize) + " ";
	sSQL = sSQL + "ORDER BY (dicetoroll * numdice) DESC, (critical_multiplier * critical_threat) DESC, size DESC";
	SQLExecDirect(sSQL);
	nCount = 0;
	
	//
	//	GET ALL WEAPONS THE CREATURE IS PROFICENT WITH, ORDERED BY MOST DAMAGING.
	//
	while (SQLFetch() == SQL_SUCCESS)
	{
		nCount++;
		
		//
		//	SAVE THE FIRST WEAPON AS IT IS MOST DAMAGING.  GIVE THIS WEAPON IF THE CREATURE HAS NO EXTRA WEAPON FEATS.
		//
		if (nCount == 1)
		{
			sDefaultWeapon = SQLGetData(1);
			if (bRanged == FALSE)
			{
				if (GetHasFeat(FEAT_COMBATSTYLE_RANGER_DUAL_WIELD, oCreature) || GetHasFeat(FEAT_TWO_WEAPON_FIGHTING, oCreature)) sDefaultWeapon = sDefaultWeapon + "," + SQLGetData(1);
				if (GetHasFeat(FEAT_WEAPON_FOCUS_UNARMED_STRIKE) || GetHasFeat(FEAT_MONK_UNARMED_STRIKE)) sDefaultWeapon = "";
			}
		}
		//
		//	GIVE THE CREATURE WEAPONS FOR WHICH THEY HAVE EXTRA WEAPON FEATS.
		//
		nCriticalFeat = StringToInt(SQLGetData(2));
		nFocusFeat = StringToInt(SQLGetData(3));
		if (GetHasFeat(nCriticalFeat, oCreature) || GetHasFeat(nFocusFeat, oCreature))
		{
			sItem = sItem + SQLGetData(1) + ",";
			if (bRanged == FALSE)
			{
				if (GetHasFeat(FEAT_COMBATSTYLE_RANGER_DUAL_WIELD, oCreature) || GetHasFeat(FEAT_TWO_WEAPON_FIGHTING, oCreature)) sItem = sItem + "," + SQLGetData(1);
			}
		}
	}

	if (sItem == "") sItem = sDefaultWeapon;

return sItem;
}

//
//	INSTANCE A NEW COHORT OBJECT
//
object CreateCohort(object oPC, string sMetaClass = "", string sRace = "", string sGender = "", int nLevel = 0)
{
	object oCreature;
	
	if (sRace == "") sRace = GetRandomRace();
	if (sGender == "") sGender = GetRandomGender();
	
	oCreature = CreateObject(OBJECT_TYPE_CREATURE, "cohort_" + sRace + "_" + sGender, GetLocation(GetWaypointByTag("wp_cohort_spawn")), TRUE);
	
	if (GetIsObjectValid(oCreature))
	{
		SetFirstName(oCreature, GetRandomName(sRace, sGender));
		SetLastName(oCreature, GetRandomName(sRace, ""));
		SetLocalObject(oCreature, "oPC", oPC);
		SetLocalString(oCreature, "sMetaClass", sMetaClass);
		SetLocalInt(oCreature, "nLevel", nLevel);
	}

return oCreature;
}

//
//	RETURNS A RANDOM RACE STRING
//
string GetRandomRace()
{
	int nNumber;
	string sRace;
	
	nNumber = d100();
	if (nNumber >= 01 && nNumber <= 40)		sRace = "human";
	if (nNumber >= 41 && nNumber <= 50)		sRace = "dwarf";
	if (nNumber >= 51 && nNumber <= 60)		sRace = "elf";
	if (nNumber >= 61 && nNumber <= 70)		sRace = "gnome";
	if (nNumber >= 71 && nNumber <= 80)		sRace = "halfelf";
	if (nNumber >= 81 && nNumber <= 90)		sRace = "halforc";
	if (nNumber >= 91 && nNumber <= 100)	sRace = "halfling";
	
return sRace;
}

//
//	RETURNS A RANDOM GENDER STRING
//
string GetRandomGender()
{
	int nNumber;
	string sGender;
	
	nNumber = d2();
	if (nNumber == 1)
	{
		sGender = "male";
	}
	else
	{
		sGender = "female";
	}
	
return sGender;
}

//
//	RETURNS A RANDOM NAME STRING FROM OUR PC DATABASE
//
//	sRace = dwarf, elf, gnome, halfelf, halforc, halfling or human
//	sGender = male, female or "" for last name
//	
//
string GetRandomName(string sRace, string sGender)
{
	string sSQL;
	string sName;
	
	if (sGender == "male") sSQL = "select o_fname from pc_data where race = '" + sRace + "' and gender = 'M' and o_fname <> '' order by rand() limit 1";
	if (sGender == "female") sSQL = "select o_fname from pc_data where race = '" + sRace + "' and gender = 'F' and o_fname <> '' order by rand() limit 1";
	if (sGender == "") sSQL = "select o_lname from pc_data where race = '" + sRace + "' and o_lname <> '' order by rand() limit 1";

	SQLExecDirect(sSQL);
	
	if (SQLFetch() == SQL_SUCCESS)
	{
		sName = SQLGetData(1);
	}
	else
	{
		sName = RandomName();
	}
	
return sName;
}

//
//	RETURNS A COHORTS STARTING LEVEL BASED ON oPC'S LEADERSHIP SCORE
//
int GetStartingLevel(object oPC)
{
	int nStartingLevel;
	int nLeadershipScore;
	int nPCLevel;
	
	nLeadershipScore = GetLeadershipScore(oPC);
	nPCLevel = GetHitDice(oPC);

	if (nLeadershipScore <=	2)	nStartingLevel = 1;
	if (nLeadershipScore ==	3)	nStartingLevel = 2;
	if (nLeadershipScore ==	4)	nStartingLevel = 3;
	if (nLeadershipScore ==	5)	nStartingLevel = 3;
	if (nLeadershipScore ==	6)	nStartingLevel = 4;
	if (nLeadershipScore ==	7)	nStartingLevel = 5;
	if (nLeadershipScore ==	8)	nStartingLevel = 5;
	if (nLeadershipScore ==	9)	nStartingLevel = 6;
	if (nLeadershipScore ==	10)	nStartingLevel = 7;
	if (nLeadershipScore ==	11)	nStartingLevel = 7;
	if (nLeadershipScore ==	12)	nStartingLevel = 8;
	if (nLeadershipScore ==	13)	nStartingLevel = 9;
	if (nLeadershipScore ==	14)	nStartingLevel = 10;
	if (nLeadershipScore ==	15)	nStartingLevel = 10;
	if (nLeadershipScore ==	16)	nStartingLevel = 11;
	if (nLeadershipScore ==	17)	nStartingLevel = 12;
	if (nLeadershipScore ==	18)	nStartingLevel = 12;
	if (nLeadershipScore ==	19)	nStartingLevel = 13;
	if (nLeadershipScore ==	20)	nStartingLevel = 14;
	if (nLeadershipScore ==	21)	nStartingLevel = 15;
	if (nLeadershipScore ==	22)	nStartingLevel = 15;
	if (nLeadershipScore ==	23)	nStartingLevel = 16;
	if (nLeadershipScore ==	24)	nStartingLevel = 17;
	if (nLeadershipScore >=	25)	nStartingLevel = 17;
	
	if (nStartingLevel + 2 > nPCLevel) nStartingLevel = nPCLevel - 2;
	if (nStartingLevel < 1) nStartingLevel = 1;
	
return nStartingLevel;
}

//
//	RETURNS A RANDOM, BUT ALIGNMENT APPROPRIATE, PACKAGE
//
int GetRandomPackage(object oCreature, string sMetaClass)
{
	int bAlignmentMatch;
	int nNumber;
	int nRandomPackage;

	bAlignmentMatch = FALSE;
	
	while (!bAlignmentMatch)
	{
		if (sMetaClass == "")
		{
			nNumber = Random(4);
			
			if (nNumber == 0) sMetaClass = "arcane";
			if (nNumber == 1) sMetaClass = "divine";
			if (nNumber == 2) sMetaClass = "rogue";
			if (nNumber == 3) sMetaClass = "warrior";
		}
		
		if (sMetaClass == "arcane")
		{
			nNumber = Random(30);
			
			if (nNumber == 0)	nRandomPackage = 1;		//Bard
			if (nNumber == 1)	nRandomPackage = 43;	//Bard_Blade
			if (nNumber == 2)	nRandomPackage = 44;	//Bard_Gallant
			if (nNumber == 3)	nRandomPackage = 91;	//Bard_Harper
			if (nNumber == 4)	nRandomPackage = 45;	//Bard_Jester
			if (nNumber == 5)	nRandomPackage = 46;	//Bard_Loremaster
			if (nNumber == 6)	nRandomPackage = 9;		//Sorcerer
			if (nNumber == 7)	nRandomPackage = 35;	//Sorcerer_Abjuration
			if (nNumber == 8)	nRandomPackage = 36;	//Sorcerer_Conjuration
			if (nNumber == 9)	nRandomPackage = 37;	//Sorcerer_Divination
			if (nNumber == 10)	nRandomPackage = 99;	//Sorcerer_DragonDisciple
			if (nNumber == 11)	nRandomPackage = 38;	//Sorcerer_Enchantment
			if (nNumber == 12)	nRandomPackage = 39;	//Sorcerer_Evocation
			if (nNumber == 13)	nRandomPackage = 40;	//Sorcerer_Illusion
			if (nNumber == 14)	nRandomPackage = 41;	//Sorcerer_Necromancy
			if (nNumber == 15)	nRandomPackage = 42;	//Sorcerer_Transmutation
			if (nNumber == 16)	nRandomPackage = 27;	//Wizard_Abjuration
			if (nNumber == 17)	nRandomPackage = 28;	//Wizard_Conjuration
			if (nNumber == 18)	nRandomPackage = 29;	//Wizard_Divination
			if (nNumber == 19)	nRandomPackage = 30;	//Wizard_Enchantment
			if (nNumber == 20)	nRandomPackage = 31;	//Wizard_Evocation
			if (nNumber == 21)	nRandomPackage = 32;	//Wizard_Illusion
			if (nNumber == 22)	nRandomPackage = 33;	//Wizard_Necromancy
			if (nNumber == 23)	nRandomPackage = 100;	//Wizard_PaleMaster
			if (nNumber == 24)	nRandomPackage = 34;	//Wizard_Transmutation
			if (nNumber == 25)	nRandomPackage = 10;	//WizardGeneralist
			if (nNumber == 26)	nRandomPackage = 143;	//Warlock_Artificier
			if (nNumber == 27)	nRandomPackage = 144;	//Warlock_Battle
			if (nNumber == 28)	nRandomPackage = 142;	//Warlock_Generalist
			if (nNumber == 29)	nRandomPackage = 201;	//Warlock_Hellfire
		}
	
		if (sMetaClass == "divine")
		{
			nNumber = Random(23);
			
			if (nNumber == 0)	nRandomPackage = 2;		//Cleric
			if (nNumber == 1)	nRandomPackage = 21;	//Cleric_Crusader
			if (nNumber == 3)	nRandomPackage = 20;	//Cleric_DeadWalker
			if (nNumber == 4)	nRandomPackage = 92;	//Cleric_Divine
			if (nNumber == 5)	nRandomPackage = 200;	//Cleric_Doomguide
			if (nNumber == 6)	nRandomPackage = 19;	//Cleric_Nature
			if (nNumber == 7)	nRandomPackage = 158;	//Cleric_Warpriest_2ndClass
			if (nNumber == 8)	nRandomPackage = 3;		//Druid
			if (nNumber == 9)	nRandomPackage = 14;	//Druid_Feral
			if (nNumber == 10)	nRandomPackage = 12;	//Druid_Guardian
			if (nNumber == 11)	nRandomPackage = 11;	//Druid_Interloper
			if (nNumber == 12)	nRandomPackage = 13;	//Druid_Shaman
			if (nNumber == 13)	nRandomPackage = 164;	//Spirit_Shaman
			if (nNumber == 14)	nRandomPackage = 184;	//Spirit_Shaman_Eidolon_Champion
			if (nNumber == 15)	nRandomPackage = 181;	//Spirit_Shaman_Elementalist
			if (nNumber == 16)	nRandomPackage = 183;	//Spirit_Shaman_Focused_Sentinel
			if (nNumber == 17)	nRandomPackage = 185;	//Spirit_Shaman_Stormlord
			if (nNumber == 18)	nRandomPackage = 182;	//Spirit_Shaman_Summoner
			if (nNumber == 19)	nRandomPackage = 166;	//Favored_Soul
			if (nNumber == 20)	nRandomPackage = 169;	//Favored_Soul_Chaotic_Fury
			if (nNumber == 21)	nRandomPackage = 168;	//Favored_Soul_Summoner
			if (nNumber == 22)	nRandomPackage = 167;	//Favored_Soul_Warpriest
		}
		
		if (sMetaClass == "rogue")
		{
			nNumber = Random(6);
	
			if (nNumber == 0)	nRandomPackage = 8;		//Rogue
			if (nNumber == 1)	nRandomPackage = 98;	//Rogue_Assassin
			if (nNumber == 2)	nRandomPackage = 60;	//Rogue_Bandit
			if (nNumber == 3)	nRandomPackage = 61;	//Rogue_Scout
			if (nNumber == 4)	nRandomPackage = 62;	//Rogue_Swashbuckler
			if (nNumber == 5)	nRandomPackage = 59;	//Rogue_Vagabond
		}
		
		if (sMetaClass == "warrior")
		{
			nNumber = Random(29);

			if (nNumber == 0)	nRandomPackage = 0;		//Barbarian							
			if (nNumber == 1)	nRandomPackage = 18;	//Barbarian_Berserker
			if (nNumber == 2)	nRandomPackage = 15;	//Barbarian_Brute
			if (nNumber == 3)	nRandomPackage = 17;	//Barbarian_Savage
			if (nNumber == 4)	nRandomPackage = 16;	//Barbarian_Slayer
			if (nNumber == 5)	nRandomPackage = 4;		//Fighter
			if (nNumber == 6)	nRandomPackage = 24;	//Fighter_Defender
			if (nNumber == 7)	nRandomPackage = 23;	//Fighter_Finesse
			if (nNumber == 8)	nRandomPackage = 25;	//Fighter_Gladiator
			if (nNumber == 9)	nRandomPackage = 94;	//Fighter_WeaponMaster
			if (nNumber == 10)	nRandomPackage = 5;		//Monk
			if (nNumber == 11)	nRandomPackage = 49;	//Monk_Devout
			if (nNumber == 12)	nRandomPackage = 50;	//Monk_Peasant
			if (nNumber == 13)	nRandomPackage = 95;	//Monk_Shadowdancer
			if (nNumber == 14)	nRandomPackage = 47;	//Monk_Spirit
			if (nNumber == 15)	nRandomPackage = 6;		//Paladin
			if (nNumber == 16)	nRandomPackage = 96;	//Paladin_Divine
			if (nNumber == 17)	nRandomPackage = 51;	//Paladin_Errant
			if (nNumber == 18)	nRandomPackage = 53;	//Paladin_Inquisitor
			if (nNumber == 19)	nRandomPackage = 52;	//Paladin_Undead
			if (nNumber == 20)	nRandomPackage = 7;		//Ranger
			if (nNumber == 21)	nRandomPackage = 97;	//Ranger_ArcaneArcher
			if (nNumber == 22)	nRandomPackage = 56;	//Ranger_Feralan
			if (nNumber == 23)	nRandomPackage = 55;	//Ranger_Marksman
			if (nNumber == 24)	nRandomPackage = 57;	//Ranger_Stalker
			if (nNumber == 25)	nRandomPackage = 58;	//Ranger_Trophyhunter
			if (nNumber == 26)	nRandomPackage = 186;	//Swashbuckler
			if (nNumber == 27)	nRandomPackage = 188;	//Swashbuckler_Duelist
			if (nNumber == 28)	nRandomPackage = 187;	//Swashbuckler_Tactician
		}
		switch (nRandomPackage)
		{
			//
			//	BARBARIANS CANNOT BE LAWFUL
			//
			case 0:
			case 18:
			case 15:
			case 17:
			case 16:
			//
			// BARDS CANNOT BE LAWFUL
			//
			case 1:
			case 43:
			case 44:
			case 91:
			case 45:
			case 46:
				if (GetAlignmentLawChaos(oCreature) == ALIGNMENT_LAWFUL)
				{
					bAlignmentMatch = FALSE;
				}
				else
				{
					bAlignmentMatch = TRUE;
				}
				
				break;
			//
			//	DRUIDS MUST BE PARTIALLY NEUTRAL
			//
			
			case 3:
			case 14:
			case 12:
			case 11:
			case 13:
				if ((GetAlignmentLawChaos(oCreature) == ALIGNMENT_NEUTRAL) || (GetAlignmentGoodEvil(oCreature) == ALIGNMENT_NEUTRAL))
				{
					bAlignmentMatch = TRUE;
				}
				else
				{
					bAlignmentMatch = FALSE;
				}

				break;
			//
			//	MONKS MUST BE LAWFUL
			//
			case 5:
			case 49:
			case 50:
			case 95:
			case 47:
				if (GetAlignmentLawChaos(oCreature) == ALIGNMENT_LAWFUL)
				{
					bAlignmentMatch = TRUE;
				}
				else
				{
					bAlignmentMatch = FALSE;
				}
				
				break;
			//
			//	PALADINS MUST BE LAWFUL GOOD
			//
			case 6:
			case 96:
			case 51:
			case 53:
			case 52:
				if ((GetAlignmentLawChaos(oCreature) == ALIGNMENT_LAWFUL) && (GetAlignmentGoodEvil(oCreature) == ALIGNMENT_GOOD))
				{
					bAlignmentMatch = TRUE;
				}
				else
				{
					bAlignmentMatch = FALSE;
				}
				
				break;
			//
			//	WARLOCKS MUST BE EVIL OR CHAOTIC
			//
			case 143:
			case 144:
			case 142:
			case 201:
				if ((GetAlignmentLawChaos(oCreature) == ALIGNMENT_CHAOTIC) || (GetAlignmentGoodEvil(oCreature) == ALIGNMENT_EVIL))
				{
					bAlignmentMatch = TRUE;
				}
				else
				{
					bAlignmentMatch = FALSE;
				}
			
				break;
			//
			//	NOBODY ELSE HAS ALIGNMENT RESTRICTIONS
			//
			default:
				bAlignmentMatch = TRUE;
				
				break;
		}
	}
	
return nRandomPackage;
}

//
//	SET oCREATURE'S ALIGNMENT WITHIN ONE STEP OF oPC'S ALIGNMENT
//
void SetRandomAlignment (object oCreature, object oPC)
{
	//
	//	SET CREATURE'S ALIGNMENT TO THAT OF PC
	//
	AdjustAlignment(oCreature, GetAlignmentLawChaos(oPC), 100);
	AdjustAlignment(oCreature, GetAlignmentGoodEvil(oPC), 100);
	//
	//	RANDOMIZE ALIGNMENT
	//
	if (d2() == 1)	//	RANDOMIZE ON LAW/CHAOS
	{
		AdjustAlignment(oCreature, ALIGNMENT_LAWFUL, 50 * (d2()-1));
		AdjustAlignment(oCreature, ALIGNMENT_CHAOTIC, 50 * (d2()-1));	
	}
	else			//	RANDOMIZE ON GOOD/EVIL
	{
		AdjustAlignment(oCreature, ALIGNMENT_GOOD, 50 * (d2()-1));
		AdjustAlignment(oCreature, ALIGNMENT_EVIL, 50 * (d2()-1));
	}
}

//
//	SCALES oCREATURE FROM 0.95 TO 1.05 BASED ON STRENGTH
//
void SetRandomScale(object oCreature)
{
	float fScale;
	
	fScale = 1 + ((GetAbilityScore(oCreature, ABILITY_STRENGTH) - 13) * 0.01);	//	THIS SHOULD YEILD BETWEEN 1.05 AND 0.95
	SetScale(oCreature, fScale, fScale, fScale);
}

//
//	GIVES oCREATURE A RANDOM VOICE SET BASED ON GENDER
//
void SetRandomSoundSet(object oCreature)
{
	if (GetGender(oCreature) == GENDER_FEMALE)
	{
		SetSoundSet(oCreature, StringToInt(GetRandomToken(SOUNDSET_FEMALE, ",")));
	}
	if (GetGender(oCreature) == GENDER_MALE)
	{
		SetSoundSet(oCreature, StringToInt(GetRandomToken(SOUNDSET_MALE, ",")));
	}
}

//
//	SET A RANDOM DEITY WHICH IS UP TO ONE ALIGNMENT STEP REMOVED FROM oCREATURE
//
void SetRandomDeity(object oCreature)
{
	int nNumber;
	string sDeity;
	
	if (GetAlignmentLawChaos(oCreature) == ALIGNMENT_LAWFUL)
	{
		if (GetAlignmentGoodEvil(oCreature) == ALIGNMENT_GOOD)
		{
				nNumber = Random(5);
				
				if (nNumber == 0) sDeity = "Etoth (Anu)";
				if (nNumber == 1) sDeity = "Ineania (Enki)";
				if (nNumber == 2) sDeity = "Tharon (Marduk)";
				if (nNumber == 3) sDeity = "Tyrak (Girru)";
				if (nNumber == 4) sDeity = "Tyrak (Girru)";
				if (nNumber == 5) sDeity = "Rel (Utu)";
		}
		if (GetAlignmentGoodEvil(oCreature) == ALIGNMENT_NEUTRAL)
		{
				nNumber = Random(10);
				
				if (nNumber == 0) sDeity = "Lochwar (Druaga)";
				if (nNumber == 1) sDeity = "Etoth (Anu)";
				if (nNumber == 2) sDeity = "Etoth (Anu)";
				if (nNumber == 3) sDeity = "Farallis (Ea)";
				if (nNumber == 4) sDeity = "Peralia (Ereshkigal)";
				if (nNumber == 5) sDeity = "Iaosia (Ki)";
				if (nNumber == 6) sDeity = "Tharon (Marduk)";
				if (nNumber == 7) sDeity = "Tharon (Marduk)";
				if (nNumber == 8) sDeity = "Brintha (Nin-Hursag)";
				if (nNumber == 9) sDeity = "Tyrak (Girru)";
		}
		if (GetAlignmentGoodEvil(oCreature) == ALIGNMENT_EVIL)
		{
				nNumber = Random(5);
				
				if (nNumber == 0) sDeity = "Lochwar (Druaga)";
				if (nNumber == 1) sDeity = "Lochwar (Druaga)";
				if (nNumber == 2) sDeity = "Etoth (Anu)";
				if (nNumber == 3) sDeity = "Tharon (Marduk)";
				if (nNumber == 4) sDeity = "Culnul (Nergal)";
		}
	}
	
	if (GetAlignmentLawChaos(oCreature) == ALIGNMENT_NEUTRAL)
	{
		if (GetAlignmentGoodEvil(oCreature) == ALIGNMENT_GOOD)
		{
				nNumber = Random(10);
				
				if (nNumber == 0) sDeity = "Farallis (Ea)";
				if (nNumber == 1) sDeity = "Ineania (Enki)";
				if (nNumber == 2) sDeity = "Ineania (Enki)";
				if (nNumber == 3) sDeity = "Peralia (Ereshkigal)";
				if (nNumber == 4) sDeity = "Iaosia (Ki)";
				if (nNumber == 5) sDeity = "Nuarari (Nanna-Sin)";
				if (nNumber == 6) sDeity = "Brintha (Nin-Hursag)";
				if (nNumber == 7) sDeity = "Tyrak (Girru)";
				if (nNumber == 8) sDeity = "Rel (Utu)";
				if (nNumber == 9) sDeity = "Rel (Utu)";
		}
		if (GetAlignmentGoodEvil(oCreature) == ALIGNMENT_NEUTRAL)
		{
				nNumber = Random(15);
				
				if (nNumber == 0) sDeity = "Etoth (Anu)";
				if (nNumber == 1) sDeity = "Farallis (Ea)";
				if (nNumber == 2) sDeity = "Farallis (Ea)";
				if (nNumber == 3) sDeity = "Ineania (Enki)";
				if (nNumber == 4) sDeity = "Peralia (Ereshkigal)";
				if (nNumber == 5) sDeity = "Peralia (Ereshkigal)";
				if (nNumber == 6) sDeity = "Teshalia (Ishtar)";
				if (nNumber == 7) sDeity = "Iaosia (Ki)";
				if (nNumber == 8) sDeity = "Iaosia (Ki)";
				if (nNumber == 9) sDeity = "Tharon (Marduk)";
				if (nNumber == 10) sDeity = "Brintha (Nin-Hursag)";
				if (nNumber == 11) sDeity = "Brintha (Nin-Hursag)";
				if (nNumber == 12) sDeity = "Culnul (Nergal)";
				if (nNumber == 13) sDeity = "Rhauth (Ramman)";
				if (nNumber == 14) sDeity = "Rel (Utu)";
		}
		if (GetAlignmentGoodEvil(oCreature) == ALIGNMENT_EVIL)
		{
				nNumber = Random(9);
				
				if (nNumber == 0) sDeity = "Lochwar (Druaga)";
				if (nNumber == 1) sDeity = "Coloth (Anshar)";
				if (nNumber == 2) sDeity = "Farallis (Ea)";
				if (nNumber == 3) sDeity = "Peralia (Ereshkigal)";
				if (nNumber == 4) sDeity = "Iaosia (Ki)";
				if (nNumber == 5) sDeity = "Brintha (Nin-Hursag)";
				if (nNumber == 6) sDeity = "Culnul (Nergal)";
				if (nNumber == 7) sDeity = "Culnul (Nergal)";
				if (nNumber == 8) sDeity = "Brintha (Nin-Hursag)";
		}
	}
	
	if (GetAlignmentLawChaos(oCreature) == ALIGNMENT_CHAOTIC)
	{
		if (GetAlignmentGoodEvil(oCreature) == ALIGNMENT_GOOD)
		{
				nNumber = Random(5);
				
				if (nNumber == 0) sDeity = "Ineania (Enki)";
				if (nNumber == 1) sDeity = "Teshalia (Ishtar)";
				if (nNumber == 2) sDeity = "Nuarari (Nanna-Sin)";
				if (nNumber == 2) sDeity = "Nuarari (Nanna-Sin)";
				if (nNumber == 3) sDeity = "Rhauth (Ramman)";
				if (nNumber == 4) sDeity = "Rel (Utu)";
		}
		if (GetAlignmentGoodEvil(oCreature) == ALIGNMENT_NEUTRAL)
		{
				nNumber = Random(10);
				
				if (nNumber == 0) sDeity = "Coloth (Anshar)";
				if (nNumber == 1) sDeity = "Farallis (Ea)";
				if (nNumber == 2) sDeity = "Peralia (Ereshkigal)";
				if (nNumber == 3) sDeity = "Teshalia (Ishtar)";
				if (nNumber == 4) sDeity = "Teshalia (Ishtar)";
				if (nNumber == 5) sDeity = "Iaosia (Ki)";
				if (nNumber == 6) sDeity = "Nuarari (Nanna-Sin)";
				if (nNumber == 7) sDeity = "Brintha (Nin-Hursag)";
				if (nNumber == 8) sDeity = "Rhauth (Ramman)";
				if (nNumber == 9) sDeity = "Rhauth (Ramman)";
		}
		if (GetAlignmentGoodEvil(oCreature) == ALIGNMENT_EVIL)
		{
				nNumber = Random(5);
				
				if (nNumber == 0) sDeity = "Coloth (Anshar)";
				if (nNumber == 1) sDeity = "Coloth (Anshar)";
				if (nNumber == 2) sDeity = "Teshalia (Ishtar)";
				if (nNumber == 3) sDeity = "Culnul (Nergal)";
				if (nNumber == 4) sDeity = "Rhauth (Ramman)";
		}
	}
	
	SetDeity(oCreature, sDeity);
}

//
//	FINDS THE OPTIMAL GEAR FOR oCREATURE.  RETURNS A COMMA DELIMITED LIST OF THOSE ITEMS.
//
string GetBestGear(object oCreature)
{
	int nAlignment;
	int nNth;
	string sItem;
	string sItemList;
	
	nAlignment = GetGoodEvilValue(oCreature);
	
	if (nAlignment >= 0 && nAlignment <= 30)
	{
		sItemList = "cohort_cloak_evil_01,cohort_cloak_evil_02,cohort_cloak_evil_03";
	}
	if (nAlignment >= 31 && nAlignment <= 69)
	{
		sItemList = "cohort_cloak_neutral_01,cohort_cloak_neutral_02,cohort_cloak_neutral_03";
	}
	if (nAlignment >= 70 && nAlignment <= 100)
	{
		sItemList = "cohort_cloak_good_01,cohort_cloak_good_02,cohort_cloak_good_03";
	}

	sItem = GetRandomToken(sItemList, ",");
	
	sItem = sItem + ",nw_it_mneck020,nw_it_mring021";

return sItem;
}

//
//	RETURNS A RANDOM TOKEN FROM A DELIMITED LIST OF TOKENS
//
string GetRandomToken(string sDelimitedList, string sDelimiter)
{
	int nNth;
	int nTokens;
	string sToken;
	
	nNth = 1;
	nTokens = 1;
	sToken = GetSubString(sDelimitedList, nNth, 1);
	while (sToken != "")
	{
		
		if (sToken == sDelimiter) nTokens++;
		nNth++;
		sToken = GetSubString(sDelimitedList, nNth, 1);
	}

	sToken = GetTokenByPosition(sDelimitedList, sDelimiter, Random(nTokens));
	
return sToken;
}

//
//	SETS RANDOM HEAD FOR oCREATURE
//
void SetRandomHead(object oCreature)
{
	string sHead;
	int nGender;
	int nRace;
	
	sHead = "1";
	
	nRace = GetRacialType(oCreature);
	nGender = GetGender(oCreature);
	
	if (nRace == RACIAL_TYPE_DWARF		&& nGender == GENDER_FEMALE)	sHead = GetRandomToken(HEADS_DWARF_FEMALE, ",");
	if (nRace == RACIAL_TYPE_DWARF		&& nGender == GENDER_MALE)		sHead = GetRandomToken(HEADS_DWARF_MALE, ",");
	if (nRace == RACIAL_TYPE_ELF		&& nGender == GENDER_FEMALE)	sHead = GetRandomToken(HEADS_ELF_FEMALE, ",");
	if (nRace == RACIAL_TYPE_ELF		&& nGender == GENDER_MALE)		sHead = GetRandomToken(HEADS_ELF_MALE, ",");
	if (nRace == RACIAL_TYPE_GNOME		&& nGender == GENDER_FEMALE)	sHead = GetRandomToken(HEADS_GNOME_FEMALE, ",");
	if (nRace == RACIAL_TYPE_GNOME		&& nGender == GENDER_MALE)		sHead = GetRandomToken(HEADS_GNOME_MALE, ",");
	if (nRace == RACIAL_TYPE_HALFELF	&& nGender == GENDER_FEMALE)	sHead = GetRandomToken(HEADS_HALFELF_FEMALE, ",");
	if (nRace == RACIAL_TYPE_HALFELF	&& nGender == GENDER_MALE)		sHead = GetRandomToken(HEADS_HALFELF_MALE, ",");
	if (nRace == RACIAL_TYPE_HALFLING	&& nGender == GENDER_FEMALE)	sHead = GetRandomToken(HEADS_HALFLING_FEMALE, ",");
	if (nRace == RACIAL_TYPE_HALFLING	&& nGender == GENDER_MALE)		sHead = GetRandomToken(HEADS_HALFLING_MALE, ",");
	if (nRace == RACIAL_TYPE_HALFORC	&& nGender == GENDER_FEMALE)	sHead = GetRandomToken(HEADS_HALFORC_FEMALE, ",");
	if (nRace == RACIAL_TYPE_HALFORC	&& nGender == GENDER_MALE)		sHead = GetRandomToken(HEADS_HALFORC_MALE, ",");
	if (nRace == RACIAL_TYPE_HUMAN		&& nGender == GENDER_FEMALE)	sHead = GetRandomToken(HEADS_HUMAN_FEMALE, ",");
	if (nRace == RACIAL_TYPE_HUMAN 		&& nGender == GENDER_MALE)		sHead = GetRandomToken(HEADS_HUMAN_MALE, ",");
	
	XPObjectAttributesSetHeadVariation(oCreature, StringToInt(sHead));
}

//
//	SETS RANDOM HAIR FOR oCREATURE
//
void SetRandomHair(object oCreature)
{
	string sHair;
	int nGender;
	int nRace;
	
	sHair = "1";
	
	nRace = GetRacialType(oCreature);
	nGender = GetGender(oCreature);
	
	if (nRace == RACIAL_TYPE_DWARF		&& nGender == GENDER_FEMALE)	sHair = GetRandomToken(HAIR_DWARF_FEMALE, ",");
	if (nRace == RACIAL_TYPE_DWARF		&& nGender == GENDER_MALE)		sHair = GetRandomToken(HAIR_DWARF_MALE, ",");
	if (nRace == RACIAL_TYPE_ELF		&& nGender == GENDER_FEMALE)	sHair = GetRandomToken(HAIR_ELF_FEMALE, ",");
	if (nRace == RACIAL_TYPE_ELF		&& nGender == GENDER_MALE)		sHair = GetRandomToken(HAIR_ELF_MALE, ",");
	if (nRace == RACIAL_TYPE_GNOME		&& nGender == GENDER_FEMALE)	sHair = GetRandomToken(HAIR_GNOME_FEMALE, ",");
	if (nRace == RACIAL_TYPE_GNOME		&& nGender == GENDER_MALE)		sHair = GetRandomToken(HAIR_GNOME_MALE, ",");
	if (nRace == RACIAL_TYPE_HALFELF	&& nGender == GENDER_FEMALE)	sHair = GetRandomToken(HAIR_HALFELF_FEMALE, ",");
	if (nRace == RACIAL_TYPE_HALFELF	&& nGender == GENDER_MALE)		sHair = GetRandomToken(HAIR_HALFELF_MALE, ",");
	if (nRace == RACIAL_TYPE_HALFLING	&& nGender == GENDER_FEMALE)	sHair = GetRandomToken(HAIR_HALFLING_FEMALE, ",");
	if (nRace == RACIAL_TYPE_HALFLING	&& nGender == GENDER_MALE)		sHair = GetRandomToken(HAIR_HALFLING_MALE, ",");
	if (nRace == RACIAL_TYPE_HALFORC	&& nGender == GENDER_FEMALE)	sHair = GetRandomToken(HAIR_HALFORC_FEMALE, ",");
	if (nRace == RACIAL_TYPE_HALFORC	&& nGender == GENDER_MALE)		sHair = GetRandomToken(HAIR_HALFORC_MALE, ",");
	if (nRace == RACIAL_TYPE_HUMAN		&& nGender == GENDER_FEMALE)	sHair = GetRandomToken(HAIR_HUMAN_FEMALE, ",");
	if (nRace == RACIAL_TYPE_HUMAN 		&& nGender == GENDER_MALE)		sHair = GetRandomToken(HAIR_HUMAN_MALE, ",");
	
	XPObjectAttributesSetHairVariation(oCreature, StringToInt(sHair));
}

//
//	SETS RANDOM FACIAL HAIR FOR oCREATURE
//
void SetRandomFacialHair(object oCreature)
{
	XPObjectAttributesSetFacialHairVariation(oCreature, Random(2));
}

//
//	SETS RANDOM HAIR, SKIN AND EYE COLOR FOR oCREATURE
//
void SetRandomTint(object oCreature)
{

	int nNumber;
	
	float fAccessoryR;
	float fAccessoryG;
	float fAccessoryB;
	float fEyesR;
	float fEyesG;
	float fEyesB;
	float fHair1R;
	float fHair1G;
	float fHair1B;	
	float fHair2R;
	float fHair2G;
	float fHair2B;
	float fSkinR;
	float fSkinG;
	float fSkinB;
	
	
	fAccessoryR = 255.0;
	fAccessoryG = 228.0;
	fAccessoryB = 156.0;

	fEyesR = 109.0;
	fEyesG = 153.0;
	fEyesB = 101.0;
	
	//
	//	HAIR COLOR
	//
	nNumber = Random(100) + 1;
	//
	//	BROWN
	//
	if (nNumber >= 1 && nNumber <=50)
	{
		fHair1R = 72.0;
		fHair1G = 49.0;
		fHair1B = 48.0;
		fHair2R = 148.0;
		fHair2G = 101.0;
		fHair2B = 95.0;
	}
	//
	//	BLACK
	//
	if (nNumber >= 51 && nNumber <=71)
	{
		fHair1R = 28.0;
		fHair1G = 28.0;
		fHair1B = 53.0;
		fHair2R = 41.0;
		fHair2G = 41.0;
		fHair2B = 51.0;
	}
	//
	//	BLONDE
	//
	if (nNumber >= 71 && nNumber <=90)
	{
		fHair1R = 227.0;
		fHair1G = 193.0;
		fHair1B = 132.0;
		fHair2R = 241.0;
		fHair2G = 216.0;
		fHair2B = 173.0;
	}
	//
	//	GRAY
	//
	if (nNumber >= 91 && nNumber <=95)
	{
		fHair1R = 143.0;
		fHair1G = 143.0;
		fHair1B = 143.0;
		fHair2R = 81.0;
		fHair2G = 81.0;
		fHair2B = 81.0;
	}
	//
	//	RED
	//
	if (nNumber >= 96 && nNumber <=100)
	{
		fHair1R = 126.0;
		fHair1G = 33.0;
		fHair1B = 26.0;
		fHair2R = 186.0;
		fHair2G = 87.0;
		fHair2B = 33.0;
	}
	//
	//	SKIN COLOR
	//
	nNumber = Random(6) + 1;
	//
	//	VON LUSCHAN 14
	//
	if (nNumber == 1)
	{
		fSkinR = 255.0;
		fSkinG = 249.0;
		fSkinB = 225.0;
	}
	//
	//	VON LUSCHAN 16
	//
	if (nNumber == 2)
	{
		fSkinR = 239.0;
		fSkinG = 226.0;
		fSkinB = 173.0;
	}
	//
	//	VON LUSCHAN 18
	//
	if (nNumber == 3)
	{
		fSkinR = 242.0;
		fSkinG = 226.0;
		fSkinB = 151.0;
	}
	//
	//	VON LUSCHAN 20
	//
	if (nNumber == 4)
	{
		fSkinR = 235.0;
		fSkinG = 217.0;
		fSkinB = 133.0;
	}
	//
	//	VON LUSCHAN 22
	//
	if (nNumber == 5)
	{
		fSkinR = 225.0;
		fSkinG = 193.0;
		fSkinB = 106.0;
	}
	//
	//	VON LUSCHAN 24
	//
	if (nNumber == 6)
	{
		fSkinR = 222.0;
		fSkinG = 184.0;
		fSkinB = 119.0;
	}
	//
	//	EYE COLOR
	//
	nNumber = Random(4) + 1;
	//
	//	BLUE
	//
	//
	if (nNumber == 1)
	{
		fEyesR = 65.0;
		fEyesG = 72.0;
		fEyesB = 81.0;
	}
	//	GREEN
	//
	if (nNumber == 2)
	{
		fEyesR = 86.0;
		fEyesG = 91.0;
		fEyesB = 85.0;
	}
	//
	//	AMBER
	//
	if (nNumber == 3)
	{
		fEyesR = 76.0;
		fEyesG = 38.0;
		fEyesB = 7.0;
	}
	//
	//	BROWN
	//
	if (nNumber == 4)
	{
		fEyesR = 56.0;
		fEyesG = 30.0;
		fEyesB = 12.0;
	}
	//
	//	CONVERT TO PERCENTAGES AND GIVE VARIATION
	//
	fAccessoryR = GetRGBVariant(fAccessoryR, 5);
	fAccessoryG = GetRGBVariant(fAccessoryG, 5);
	fAccessoryB = GetRGBVariant(fAccessoryB, 5);
	
	fHair1R = GetRGBVariant(fHair1R, 5);
	fHair1G = GetRGBVariant(fHair1G, 5);
	fHair1B = GetRGBVariant(fHair1B, 5);
	
	fHair2R = GetRGBVariant(fHair2R, 5);
	fHair2G = GetRGBVariant(fHair2G, 5);
	fHair2B = GetRGBVariant(fHair2B, 5);

	fEyesR = GetRGBVariant(fEyesR, 10);
	fEyesG = GetRGBVariant(fEyesG, 10);
	fEyesB = GetRGBVariant(fEyesB, 10);
		
	fSkinR = GetRGBVariant(fSkinR, 3);
	fSkinG = GetRGBVariant(fSkinG, 3);
	fSkinB = GetRGBVariant(fSkinB, 3);
	//
	//	APPLY COLORATION
	//
	XPObjectAttributesSetHairTint(oCreature, 
		CreateXPObjectAttributes_TintSet(
			CreateXPObjectAttributes_Color(fAccessoryR, fAccessoryG, fAccessoryB, 1.0), 	//Accessory
			CreateXPObjectAttributes_Color(fHair1R, fHair1G, fHair1B, 1.0),				 	//Hair Color
			CreateXPObjectAttributes_Color(fHair2R, fHair2G, fHair2B, 1.0)				 	//Hair Highlight
		)
	);

	XPObjectAttributesSetHeadTint(oCreature, 
		CreateXPObjectAttributes_TintSet(
			CreateXPObjectAttributes_Color(fSkinR, fSkinG, fSkinB, 1.0),				 	//Head
			CreateXPObjectAttributes_Color(fEyesR, fEyesG, fEyesB, 1.0),				 	//Eyes
			CreateXPObjectAttributes_Color(fHair1R, fHair1G, fHair1B, 1.0)				 	//Eyebrows
		)
	);
	XPObjectAttributesSetBodyTint(oCreature, 
		CreateXPObjectAttributes_TintSet(
			CreateXPObjectAttributes_Color(fSkinR, fSkinG, fSkinB, 1.0),				 	//Body
			CreateXPObjectAttributes_Color(fHair1R, fHair1G, fHair1B, 1.0),				 	//Eyebrows
			CreateXPObjectAttributes_Color(fEyesR, fEyesG, fEyesB, 1.0)					 	//Eyes
		)
	);
}

//
//	ADJUSTS fCOLOR BY +/- 1 TO nPERCENT [EX. -50% to +50%]
//	RETURNS THE ADJUSTED COLOR AS A PERCENTAGE OF 255
//	AS REQUIRED BY CreateXPObjectAttributes_Color
//
float GetRGBVariant(float fColor, int nPercent)
{
	float fRGBVariant;
	float fFactor;
	
	if (nPercent > 0)
	{
		fFactor = (Random(nPercent) + 1) / 100.0;
		if (Random(2) == 1)
		{
			fFactor = 1 + fFactor;
		}
		else
		{
			fFactor = 1 - fFactor;
		}
	}
	else
	{
		fFactor = 1.0;
	}
		
	fRGBVariant = fColor * fFactor;
	
	if (fRGBVariant > 255.0) fRGBVariant = 255.0;
	if (fRGBVariant < 0.0) fRGBVariant = 0.0;
	
	if (fRGBVariant > 0.0) fRGBVariant = fRGBVariant / 255.0;
	
return fRGBVariant;	
}

//
//	CAUSES oCREATURE TO EQUIP ITEMS IN INVENTORY
//
void EquipInventory(object oCreature)
{
	object oItem;
	
	oItem = GetFirstItemInInventory(oCreature);
	while(GetIsObjectValid(oItem))
	{
		if (GetBaseItemType(oItem) == BASE_ITEM_AMULET) AssignCommand(oCreature, ActionEquipItem(oItem, INVENTORY_SLOT_NECK));

		if (GetBaseItemType(oItem) == BASE_ITEM_ARMOR) AssignCommand(oCreature, ActionEquipItem(oItem, INVENTORY_SLOT_CHEST));
		
		if (GetBaseItemType(oItem) == BASE_ITEM_ARROW) AssignCommand(oCreature, ActionEquipItem(oItem, INVENTORY_SLOT_ARROWS));

		if (GetBaseItemType(oItem) == BASE_ITEM_BELT) AssignCommand(oCreature, ActionEquipItem(oItem, INVENTORY_SLOT_BELT));
		
		if (GetBaseItemType(oItem) == BASE_ITEM_BOLT) AssignCommand(oCreature, ActionEquipItem(oItem, INVENTORY_SLOT_BOLTS));

		if (GetBaseItemType(oItem) == BASE_ITEM_BOOTS) AssignCommand(oCreature, ActionEquipItem(oItem, INVENTORY_SLOT_BOOTS));
		
		if (GetBaseItemType(oItem) == BASE_ITEM_BULLET) AssignCommand(oCreature, ActionEquipItem(oItem, INVENTORY_SLOT_BULLETS));
		
		if (GetBaseItemType(oItem) == BASE_ITEM_CLOAK) AssignCommand(oCreature, ActionEquipItem(oItem, INVENTORY_SLOT_CLOAK));
		
		if (GetBaseItemType(oItem) == BASE_ITEM_HELMET) AssignCommand(oCreature, ActionEquipItem(oItem, INVENTORY_SLOT_HEAD));

		if (GetBaseItemType(oItem) == BASE_ITEM_RING)
		{
			if (GetLocalInt(oCreature, "bRingEquipped"))
			{
				AssignCommand(oCreature, ActionEquipItem(oItem, INVENTORY_SLOT_LEFTRING));
			}
			else
			{
				AssignCommand(oCreature, ActionEquipItem(oItem, INVENTORY_SLOT_RIGHTRING));
				SetLocalInt(oCreature, "bRingEquipped", TRUE);
			}
		}
		
		if ((GetBaseItemType(oItem) == BASE_ITEM_SMALLSHIELD) || (GetBaseItemType(oItem) == BASE_ITEM_LARGESHIELD) || (GetBaseItemType(oItem) == BASE_ITEM_TOWERSHIELD)) AssignCommand(oCreature, ActionEquipItem(oItem, INVENTORY_SLOT_LEFTHAND));

		if (GetWeaponType(oItem) != WEAPON_TYPE_NONE && !GetWeaponRanged(oItem))
		{
			if (GetLocalInt(oCreature, "bWeaponEquipped"))
			{
				AssignCommand(oCreature, ActionEquipItem(oItem, INVENTORY_SLOT_LEFTHAND));
			}
			else
			{
				AssignCommand(oCreature, ActionEquipItem(oItem, INVENTORY_SLOT_RIGHTHAND));
				SetLocalInt(oCreature, "bWeaponEquipped", TRUE);
			}
		}
		oItem = GetNextItemInInventory(oCreature);
	}
	DeleteLocalInt(oCreature, "bRingEquipped");
	DeleteLocalInt(oCreature, "bWeaponEquipped");
}

//
//	GIVES oCREATURE'S ITEMS LEVEL APPROPRIATE ENCHANTMENTS
//
void EnchantInventory(object oCreature)
{
	int nBonus;
	int nLevel;
	object oItem;
	
	nLevel = GetHitDice(oCreature);
	oItem = GetFirstItemInInventory(oCreature);
	while(GetIsObjectValid(oItem))
	{
		if (GetBaseItemType(oItem) == BASE_ITEM_AMULET)
		{
			nBonus = 0;
			if (nLevel >= 1)	nBonus = 1;
			if (nLevel >= 6)	nBonus = 2;
			if (nLevel >= 11)	nBonus = 3;
			if (nLevel >= 16)	nBonus = 4;
			
			if (nBonus > 0)
			{
				IPSafeAddItemProperty(oItem, ItemPropertyACBonus(nBonus));
			}
		}

		if (GetBaseItemType(oItem) == BASE_ITEM_ARMOR)
		{
			nBonus = 0;
			if (nLevel >= 4)	nBonus = 1;
			if (nLevel >= 9)	nBonus = 2;
			if (nLevel >= 14)	nBonus = 3;
			if (nLevel >= 19)	nBonus = 4;
			
			if (nBonus > 0)
			{
				IPSafeAddItemProperty(oItem, ItemPropertyACBonus(nBonus));
			}
		}
		
		if ((GetBaseItemType(oItem) == BASE_ITEM_ARROW) || (GetBaseItemType(oItem) == BASE_ITEM_BOLT) || (GetBaseItemType(oItem) == BASE_ITEM_BULLET))
		{
			nBonus = 0;
			if (nLevel >= 3)	nBonus = 1;
			if (nLevel >= 8)	nBonus = 2;
			if (nLevel >= 13)	nBonus = 3;
			if (nLevel >= 18)	nBonus = 4;

			if (nBonus > 0)
			{
				IPSafeAddItemProperty(oItem, ItemPropertyDamageBonus(IP_CONST_DAMAGETYPE_PIERCING, nBonus));
			}
		}
		
		if (GetBaseItemType(oItem) == BASE_ITEM_BULLET)
		{
			nBonus = 0;
			if (nLevel >= 3)	nBonus = 1;
			if (nLevel >= 8)	nBonus = 2;
			if (nLevel >= 13)	nBonus = 3;
			if (nLevel >= 18)	nBonus = 4;

			if (nBonus > 0)
			{
				IPSafeAddItemProperty(oItem, ItemPropertyDamageBonus(IP_CONST_DAMAGETYPE_BLUDGEONING, nBonus));
			}
		}

//		if (GetBaseItemType(oItem) == BASE_ITEM_BELT)

//		if (GetBaseItemType(oItem) == BASE_ITEM_BOOTS)
		
		if (GetBaseItemType(oItem) == BASE_ITEM_CLOAK)
		{
			nBonus = 0;
			if (nLevel >= 2)	nBonus = 1;
			if (nLevel >= 7)	nBonus = 2;
			if (nLevel >= 12)	nBonus = 3;
			if (nLevel >= 17)	nBonus = 4;
			
			if (nBonus > 0)
			{
				IPSafeAddItemProperty(oItem, ItemPropertyACBonus(nBonus));
			}
		}
		
//		if (GetBaseItemType(oItem) == BASE_ITEM_HELMET)

		if (GetBaseItemType(oItem) == BASE_ITEM_RING)
		{
			nBonus = 0;
			if (nLevel >= 5)	nBonus = 1;
			if (nLevel >= 10)	nBonus = 2;
			if (nLevel >= 15)	nBonus = 3;
			if (nLevel >= 20)	nBonus = 4;
			
			if (nBonus > 0)
			{
				IPSafeAddItemProperty(oItem, ItemPropertyRegeneration(nBonus));
			}
		}

		if ((GetBaseItemType(oItem) == BASE_ITEM_SMALLSHIELD) || (GetBaseItemType(oItem) == BASE_ITEM_LARGESHIELD) || (GetBaseItemType(oItem) == BASE_ITEM_TOWERSHIELD))
		{
			nBonus = 0;
			if (nLevel >= 4)	nBonus = 1;
			if (nLevel >= 9)	nBonus = 2;
			if (nLevel >= 14)	nBonus = 3;
			if (nLevel >= 19)	nBonus = 4;
			
			if (nBonus > 0)
			{
				IPSafeAddItemProperty(oItem, ItemPropertyACBonus(nBonus));
			}
		}
		
		if (GetWeaponType(oItem) != WEAPON_TYPE_NONE)
		{
			nBonus = 0;
			if (nLevel >= 3)	nBonus = 1;
			if (nLevel >= 8)	nBonus = 2;
			if (nLevel >= 13)	nBonus = 3;
			if (nLevel >= 18)	nBonus = 4;

			if (nBonus > 0)
			{
				IPSafeAddItemProperty(oItem, ItemPropertyEnhancementBonus(nBonus));
			}
		}

		oItem = GetNextItemInInventory(oCreature);
	}
}

//
//	CALCULATES oPC'S LEADERSHIP SCORE
//
int GetLeadershipScore(object oPC)
{
	int nLeadershipScore;
	string sSQL;
	
	//
	//	LEADERSHIP SCORE IS LEVEL PLUS CHARISMA MODIFIER
	//
	nLeadershipScore = GetHitDice(oPC);
	nLeadershipScore = nLeadershipScore + GetAbilityScore(oPC, ABILITY_CHARISMA, TRUE) / 2 - 5;

	//
	//	+2 IF THE LEADER HAS GREAT RENOWN
	//
	SQLExecDirect("SELECT renown FROM pc_data WHERE pcid = " + getPCid(oPC));
	if ((SQLFetch() == SQL_SUCCESS) && (StringToInt (SQLGetData (1)) > 0))
	{
		nLeadershipScore = nLeadershipScore + 2;
	}

	//
	//	-2 IF THE LEADER HAS A FAMILIAR, SPECIAL MOUNT, OR ANIMAL COMPANION
	//
	if (GetHasFeat(FEAT_SUMMON_FAMILIAR, oPC) || GetHasFeat(FEAT_ANIMAL_COMPANION, oPC) || GetHasFeat(FEAT_PALADIN_MOUNT, oPC))
	{
		nLeadershipScore = nLeadershipScore - 2;
	}

	//
	//	-2 IF THE LEADER HAS CAUSED THE DEATH OF A COHORT (I THINK THIS RULE IS TOO HARD CORE FOR A VIDEO GAME)
	//
	//SQLExecDirect("SELECT leader_id FROM cohort WHERE leader_id = " + getPCid(oPC) + " AND cohort_status = " + COHORT_STATUS_DEAD);
	//if (SQLFetch())
	//{
	//	nLeadershipScore = nLeadershipScore - 2;
	//}

	return nLeadershipScore;
}

//
//	CONVERTS EXPERIENCE TO LEVEL
//
int ExpToLevel(int nExperience)
{
	int nLevel;

	if (nExperience >= 0) 		nLevel = 1;
	if (nExperience >= 1000) 	nLevel = 2;
	if (nExperience >= 3000) 	nLevel = 3;
	if (nExperience >= 6000) 	nLevel = 4;
	if (nExperience >= 10000) 	nLevel = 5;
	if (nExperience >= 15000) 	nLevel = 6;
	if (nExperience >= 21000) 	nLevel = 7;
	if (nExperience >= 28000) 	nLevel = 8;
	if (nExperience >= 36000) 	nLevel = 9;
	if (nExperience >= 45000) 	nLevel = 10;
	if (nExperience >= 55000) 	nLevel = 11;
	if (nExperience >= 66000) 	nLevel = 12;
	if (nExperience >= 78000) 	nLevel = 13;
	if (nExperience >= 91000) 	nLevel = 14;
	if (nExperience >= 105000) 	nLevel = 15;
	if (nExperience >= 120000) 	nLevel = 16;
	if (nExperience >= 136000) 	nLevel = 17;
	if (nExperience >= 153000) 	nLevel = 18;
	if (nExperience >= 171000) 	nLevel = 19;
	if (nExperience >= 190000) 	nLevel = 20;

	return nLevel;
}

//
//	CONVERTS LEVEL TO EXPERIENCE
//
int LevelToExp(int nLevel)
{
	int nExperience;
	
	nExperience = nLevel * (nLevel-1) * 500;

	return nExperience;
}

//
//	GIVES oCREATURE APPROPRIATE ITEMS
//
void CreateInventory(object oCreature)
{
	int nCount;
	object oItem;
	
	oItem = GetItemInSlot(INVENTORY_SLOT_CLOAK, oCreature);
	if (GetIsObjectValid(oItem))
	{
		//
		//	I DON'T WANT YOU TO CHANGE CLOAKS ON ME
		//
		CreateItemsOnObject(GetBestArmor(oCreature) + "," + GetBestShield(oCreature) + "," + GetBestWeapons(oCreature, TRUE) + "," + GetBestWeapons(oCreature, FALSE), oCreature);
	}
	else
	{
		//
		//	BUT CHANGES IN DEX AND FEATS MAY CAUSE ARMOR AND WEAPON CHANGES
		//
		CreateItemsOnObject(GetBestArmor(oCreature) + "," + GetBestShield(oCreature) + "," + GetBestWeapons(oCreature, TRUE) + "," + GetBestWeapons(oCreature, FALSE) + "," + GetBestGear(oCreature), oCreature);
	}
	
	//
	//	HACK TO HANDLE AMMO
	//
	for (nCount = 0; nCount < 5; nCount++)
	{
		oItem = CreateItemOnObject("nw_wamar001", oCreature, 99);		//	ARROWS
		SetIdentified(oItem, TRUE);
		SetDroppableFlag(oItem, FALSE);
	}
	for (nCount = 0; nCount < 5; nCount++)
	{
		oItem = CreateItemOnObject("nw_wambo001", oCreature, 99);		//	BOLTS
		SetIdentified(oItem, TRUE);
		SetDroppableFlag(oItem, FALSE);
	}
	for (nCount = 0; nCount < 5; nCount++)
	{
		oItem = CreateItemOnObject("nw_wambu001", oCreature, 99);		//	BULLETS
		SetIdentified(oItem, TRUE);
		SetDroppableFlag(oItem, FALSE);
	}
}

//
//	SAVES COHORT OBJECT TO THE DATABASE
//
void SaveCohort(object oCreature, string sStatus = COHORT_STATUS_ALIVE)
{
	string cohort_id;
	string sSQL;
	object oPC;
	
	oPC  = GetLocalObject(oCreature, "oPC");
	cohort_id = GetLocalString(oCreature, "cohort_id");

	if (cohort_id == "")
	{
		sSQL = "INSERT INTO cohort (cohort_object, cohort_status, leader_id) VALUES (%s, " + COHORT_STATUS_ALIVE + ", " + getPCid(oPC) + ")";
		SQLSCORCOExec(sSQL);
		SQLStoreObject(oCreature);
		if (SQLGetAffectedRows() > 0)
		{
			SQLExecDirect("SELECT LAST_INSERT_ID()");
			if (SQLFetch() == SQL_SUCCESS) SetLocalString(oCreature, "cohort_id", SQLGetData(1));
		}
		else
		{
			SendMessageToPC(oPC, "ERROR: " + GetName(oCreature) + " not saved.");
		}
	}
	else
	{
		sSQL = "UPDATE cohort SET cohort_object = %s, cohort_status = '" + sStatus + "' WHERE cohort_id = " + cohort_id;
		SQLSCORCOExec(sSQL);
		SQLStoreObject(oCreature);
		if (SQLGetAffectedRows() == 0)
		{
			SendMessageToPC(oPC, "ERROR: " + GetName(oCreature) + " with ID " + cohort_id + " not saved.");
		}
		
	}
}

//
//	INITIALIZATION OF COHORT AT SUMMONING
//
void SummonCohort(object oCreature)
{
	object oPC;
	
	oPC = GetLocalObject(oCreature, "oPC");
	
	DelayCommand(0.0,	SetPackage(oCreature, GetLevelUpPackage(oCreature)));
	DelayCommand(1.0,	DestroyInventory(oCreature));
	DelayCommand(2.0,	CreateInventory(oCreature));
	DelayCommand(3.0,	EnchantInventory(oCreature));
	DelayCommand(4.0,	EquipInventory(oCreature));
	DelayCommand(5.0,	SaveCohort(oCreature));
	DelayCommand(6.0,	SetVariables(oCreature));
	DelayCommand(7.0,	JumpCohort(oCreature));
}

//
//	JUMP COHORT TO LEADER'S POSITION
//
void JumpCohort(object oCreature)
{
	object oPC;
	
	oPC = GetLocalObject(oCreature, "oPC");
	
	AssignCommand(oCreature, ActionJumpToObject(oPC));
}

//
//	SET COHORT A.I. VARIABLES
//
void SetVariables(object oCreature)
{
	object oPC;
	
	oPC = GetLocalObject(oCreature, "oPC");
	
	SetCreatureScriptsToSet(oCreature, SCRIPTSET_PLAYER_DEFAULT);
	SetLocalInt(oCreature, "nLeaderPreviousXP", GetXP(oPC));
	SetLocalString(oCreature, "SpawnScript", "gb_cohort_sp");
	SetLocalString(oCreature, "DeathScript", "gb_cohort_de");
	SetLocalString(oCreature, "hb_script", "gb_cohort_hb");
	SetLocalString(oCreature, "sLastStatus", COHORT_STATUS_ALIVE);
	SetIsDestroyable(TRUE, TRUE, TRUE);
}
//
//	DESTROY COHORTS - COHORTS LEAVE CORPSES SO EXTRA STEPS ARE REQUIRED TO DESTROY THEM
//
void DestroyCohort(object oCreature)
{
	AssignCommand(oCreature, SetIsDestroyable(TRUE, FALSE, FALSE));
	DestroyObject(oCreature);
}