//	INCLUDE FILE - FUNCTIONS USED TO CREATE DASARIAN CRAFTING RECIPES
//
//	ROBERT HARRIS	ROBERTHARRIS@ROBERTHARRIS.COM
//
#include "ginc_crafting"
//
//	ARMOR TYPE CONSTAINTS
//
const int ARMOR_TYPE_CLOTHING = 0;
const int ARMOR_TYPE_PADDED = 1;
const int ARMOR_TYPE_LEATHER = 2;
const int ARMOR_TYPE_HIDE = 3;
const int ARMOR_TYPE_STUDDED_LEATHER = 4;
const int ARMOR_TYPE_SCALE_MAIL = 5;
const int ARMOR_TYPE_CHAIN_SHIRT = 6;
const int ARMOR_TYPE_CHAINMAIL = 7;
const int ARMOR_TYPE_BREASTPLATE = 8;
const int ARMOR_TYPE_BANDED_MAIL = 9;
const int ARMOR_TYPE_HALF_PLATE = 10;
const int ARMOR_TYPE_FULL_PLATE = 11;
//
//	GIVEN RESREFS RETURNS ITEM NAMES
//
string GetResrefName (string sResrefList)
{
	int nNth;
	object oItem;
	string sName;
	string sResref;
	string sResrefName;
	
	nNth = 0;
	sResref = GetTokenByPosition(sResrefList, ",", nNth);
	
	while (sResref != "")
	{
		oItem = CreateObject(OBJECT_TYPE_ITEM, sResref, GetStartingLocation());
		if (GetIsObjectValid(oItem))
		{
			sName = GetName(oItem);
			DestroyObject(oItem);
		}
		else
		{
			sName = "Unknown";
		}
		if (nNth == 0)
		{
			sResrefName = sName;
		}
		else
		{
			sResrefName += "," + sName;
		}
		nNth++;
		sResref = GetTokenByPosition(sResrefList, ",", nNth);
	}
	
	return sResrefName;
}
//
//	RETURN'S SPELL LABEL FROM SPELLS.2DA
//
string GetSpellName(int iSpell)
{
	int nNth;
	string sLabel;
	string sSpellName;
	string sWord;
	
	sLabel = Get2DAString("spells", "Label", iSpell);
	
	nNth = 0;
	sWord = GetTokenByPosition(sLabel, "_", nNth);
	
	while (sWord != "")
	{
		if (nNth == 0)
		{
			sSpellName = sWord;
		}
		else
		{
			sSpellName += " " + sWord;
		}
		nNth++;
		sWord = GetTokenByPosition(sLabel, "_", nNth);
	}
	
	return sSpellName;
}
//
//	GET BASE ARMOR BASED ON UNIDENTIFIED COST.  MITHRIAL HAS SEPERATE COST.
//
int GetArmorType(object oItem)
{
	int iBaseArmor;
	int bIdentified;
	
	if (GetBaseItemType(oItem) == BASE_ITEM_ARMOR)
	{
			bIdentified = GetIdentified(oItem);
		    SetIdentified(oItem,FALSE);
			
		    switch (GetGoldPieceValue(oItem))
		    {
        		case 1:
					iBaseArmor = ARMOR_TYPE_CLOTHING;
					 break;
        		case 5:
					iBaseArmor = ARMOR_TYPE_PADDED;
					break;
        		case 10:
					iBaseArmor = ARMOR_TYPE_LEATHER;
					break;
        		case 15:
					iBaseArmor = ARMOR_TYPE_HIDE;
					break;
        		case 25:
					iBaseArmor = ARMOR_TYPE_STUDDED_LEATHER;
					break;
        		case 50:
				case 4050:
					iBaseArmor = ARMOR_TYPE_SCALE_MAIL;
					break;
        		case 100:
				case 1100:
					iBaseArmor = ARMOR_TYPE_CHAIN_SHIRT;
					break;
        		case 150:
				case 4150:
					iBaseArmor = ARMOR_TYPE_CHAINMAIL;
					break;
        		case 200:
				case 4200:
					iBaseArmor = ARMOR_TYPE_BREASTPLATE;
					break;
        		case 250:
				case 9250:
					iBaseArmor = ARMOR_TYPE_BANDED_MAIL;
					break;
        		case 600:
				case 9600:
					iBaseArmor = ARMOR_TYPE_HALF_PLATE;
					break;
        		case 1500:
				case 10500:
					iBaseArmor = ARMOR_TYPE_FULL_PLATE;
					break;
				default:
					iBaseArmor = -1;
					break;
		    }
			
			SetIdentified(oItem,bIdentified);	
	}
	else
	{
		iBaseArmor = -1;
	}
	return iBaseArmor;
}
//
//	GET CRAFTING MOLD BASED ON THE ITEMS BASE TYPE
//
string GetMold(object oItem)
{
	string sMold;
	
	switch (GetBaseItemType(oItem))
	{
		case BASE_ITEM_ARMOR:
		    switch (GetArmorType(oItem))
		    {
        		case ARMOR_TYPE_PADDED:
					sMold = "n2_crft_mold_ltpd";		//  PADDED ARMOR MOLD
					break;
        		case ARMOR_TYPE_LEATHER:
					sMold = "n2_crft_mold_ltlt";		//  LEATHER ARMOR MOLD
					break;
        		case ARMOR_TYPE_HIDE:
					sMold = "n2_crft_mold_mdhd";		//  HIDE ARMOR MOLD				
					break;
        		case ARMOR_TYPE_STUDDED_LEATHER:
					sMold = "n2_crft_mold_ltsl";		//  STUDDED LEATHER ARMOR MOLD				
					break;
        		case ARMOR_TYPE_SCALE_MAIL:
					sMold = "n2_crft_mold_mdsm";		//  SCALE MAIL MOLD
					break;
        		case ARMOR_TYPE_CHAIN_SHIRT:
					sMold = "n2_crft_mold_ltcs";		//  CHAIN SHIRT MOLD
					break;
        		case ARMOR_TYPE_CHAINMAIL:
					sMold = "n2_crft_mold_mdcm";		//  CHAINMAIL MOLD				
					break;
        		case ARMOR_TYPE_BREASTPLATE:
					sMold = "n2_crft_mold_mdbp";		//  BREASTPLATE MOLD				
					break;
        		case ARMOR_TYPE_BANDED_MAIL:
					sMold = "n2_crft_mold_hvbm";		//  BANDED MAIL MOLD
					break;
        		case ARMOR_TYPE_HALF_PLATE:
					sMold = "n2_crft_mold_hvhp";		//  HALF PLATE MOLD
					break;
        		case ARMOR_TYPE_FULL_PLATE:
					sMold = "n2_crft_mold_hvfp";		//  FULL PLATE MOLD
					break;
				default:
					sMold = "ERROR - UNEXPECTED ARMOR TYPE";
					break;
		    }
			break;
		case BASE_ITEM_ARROW:
			sMold = "n2_crft_mold_arro";		//  ARROW MOLD
			break;
		case BASE_ITEM_BASTARDSWORD:
			sMold = "n2_crft_mold_swbs";		//  BASTARD SWORD MOLD
			break;
		case BASE_ITEM_BATTLEAXE:
			sMold = "n2_crft_mold_axbt";		//  BATTLEAXE MOLD
			break;
		case BASE_ITEM_BOLT:
			sMold = "n2_crft_mold_bolt";		//  BOLT MOLD
			break;
		case BASE_ITEM_BULLET:
			sMold = "n2_crft_mold_bult";		//  BULLET MOLD
			break;
		case BASE_ITEM_CLUB:
			sMold = "n2_crft_mold_blcl";		//  CLUB MOLD
			break;
		case BASE_ITEM_DAGGER:
			sMold = "n2_crft_mold_swdg";		//  DAGGER MOLD
			break;
		case BASE_ITEM_DART:
			sMold = "n2_crft_mold_dart";		//  DART MOLD
			break;
		case BASE_ITEM_DWARVENWARAXE:
			sMold = "n2_crft_mold_axdv";		//  DWARVEN WARAXE MOLD
			break;
		case BASE_ITEM_FALCHION:
			sMold = "n2_crft_mold_swfl";		//  FALCHION MOLD
			break;
		case BASE_ITEM_GREATAXE:
			sMold = "n2_crft_mold_axgr";		//  GREATAXE MOLD
			break;
		case BASE_ITEM_GREATSWORD:
			sMold = "n2_crft_mold_swgs";		//  GREATSWORD MOLD
			break;
		case BASE_ITEM_HALBERD:
			sMold = "n2_crft_mold_plhb";		//  HALBERD MOLD
			break;
		case BASE_ITEM_HANDAXE:
			sMold = "n2_crft_mold_axhn";		//  HANDAXE MOLD
			break;
		case BASE_ITEM_HEAVYCROSSBOW:
			sMold = "n2_crft_mold_bwxh";		//  HEAVY CROSSBOW MOLD
			break;
		case BASE_ITEM_HEAVYFLAIL:
			sMold = "n2_crft_mold_blfl";		//  HEAVY FLAIL MOLD (NOT IN NWN2)
			break;
		case BASE_ITEM_HELMET:
			sMold = "n2_crft_mold_helm";		//  HELMET
			break;
		case BASE_ITEM_KAMA:
			sMold = "n2_crft_mold_spka";		//  KAMA MOLD
			break;
		case BASE_ITEM_KATANA:
			sMold = "n2_crft_mold_swka";		//  KATANA MOLD
			break;
		case BASE_ITEM_KUKRI:
			sMold = "n2_crft_mold_spku";		//  KUKRI MOLD
			break;
		case BASE_ITEM_LARGESHIELD:
			sMold = "n2_crft_mold_shhv";		//  HEAVY SHIELD MOLD
			break;
		case BASE_ITEM_LIGHTCROSSBOW:
			sMold = "n2_crft_mold_bwxl";		//  LIGHT CROSSBOW MOLD
			break;
		case BASE_ITEM_LIGHTFLAIL:
			sMold = "n2_crft_mold_blfl";		//  LIGHT FLAIL MOLD
			break;
		case BASE_ITEM_LIGHTHAMMER:
			sMold = "n2_crft_mold_blhl";		//  LIGHT HAMMER MOLD
			break;
		case BASE_ITEM_LIGHTMACE:
			sMold = "n2_crft_mold_blml";		//  MACE MOLD
			break;
		case BASE_ITEM_LONGBOW:
			sMold = "n2_crft_mold_bwln";		//  LONGBOW MOLD
			break;
		case BASE_ITEM_LONGSWORD:
			sMold = "n2_crft_mold_swls";		//  LONGSWORD MOLD
			break;
		case BASE_ITEM_MORNINGSTAR:
			sMold = "n2_crft_mold_blms";		//  MORNINGSTAR MOLD
			break;
		case BASE_ITEM_QUARTERSTAFF:
			sMold = "n2_crft_mold_dbqs";		//  QUARTERSTAFF MOLD
			break;
		case BASE_ITEM_RAPIER:
			sMold = "n2_crft_mold_swrp";		//  RAPIER MOLD
			break;
		case BASE_ITEM_SCIMITAR:
			sMold = "n2_crft_mold_swsc";		//  SCIMITAR MOLD
			break;
		case BASE_ITEM_SCYTHE:
			sMold = "n2_crft_mold_plsc";		//  SCYTHE MOLD
			break;
		case BASE_ITEM_SHORTBOW:
			sMold = "n2_crft_mold_bwsh";		//  SHORTBOW MOLD
			break;
		case BASE_ITEM_SHORTSWORD:
			sMold = "n2_crft_mold_swss";		//  SHORT SWORD MOLD
			break;
		case BASE_ITEM_SHURIKEN:
			sMold = "n2_crft_mold_shur";		//  SHURIKEN
			break;
		case BASE_ITEM_SICKLE:
			sMold = "n2_crft_mold_spsc";		//  SICKLE MOLD
			break;
		case BASE_ITEM_SLING:
			sMold = "n2_crft_mold_slng";		//  SLING MOLD
			break;
		case BASE_ITEM_SMALLSHIELD:
			sMold = "n2_crft_mold_shlt";		//  LIGHT SHIELD MOLD
			break;
		case BASE_ITEM_SPEAR:
			sMold = "n2_crft_mold_plss";		//  SPEAR MOLD
			break;
		case BASE_ITEM_THROWINGAXE:
			sMold = "n2_crft_mold_taxe";		//  THROWING AXE MOLD
			break;
		case BASE_ITEM_TOWERSHIELD:
			sMold = "n2_crft_mold_shtw";		//  TOWER SHIELD MOLD
			break;
		case BASE_ITEM_TRAPKIT:
			sMold = "n2_crft_mold_trap";		//  TRAP KIT MOLD
			break;
		case BASE_ITEM_WARHAMMER:
			sMold = "n2_crft_mold_blhw";		//  WARHAMMER MOLD
			break;
		case BASE_ITEM_WARMACE:
			sMold = "n2_crft_mold_bldm";		//  WARMACE MOLD
			break;
		default:
			sMold = "ERROR - UNEXPECTED BASE TYPE: " + IntToString(GetBaseItemType(oItem));
			break;
	}
	output("Mold: "	+ GetResrefName(sMold));
	return sMold;
}
//
//	GET THE SKILL REQUIRED TO CRAFT THE ITEM BASED ON THE ITEMS BASE TYPE
//
int GetSkill(object oItem)
{
	int iSkill;
		
	switch (GetBaseItemType(oItem))
	{
		case BASE_ITEM_ARROW:
		case BASE_ITEM_BOLT:
		case BASE_ITEM_BULLET: iSkill = SKILL_CRAFT_ALCHEMY; break;

		case BASE_ITEM_SMALLSHIELD:
		case BASE_ITEM_LARGESHIELD:
		case BASE_ITEM_TOWERSHIELD:
		case BASE_ITEM_ARMOR: iSkill = SKILL_CRAFT_ARMOR; break;
	
		case BASE_ITEM_BASTARDSWORD:
		case BASE_ITEM_BATTLEAXE:
		case BASE_ITEM_CLUB:
		case BASE_ITEM_DAGGER:
		case BASE_ITEM_DART:
		case BASE_ITEM_DWARVENWARAXE:
		case BASE_ITEM_FALCHION:
		case BASE_ITEM_GREATAXE:
		case BASE_ITEM_GREATSWORD:
		case BASE_ITEM_HALBERD:
		case BASE_ITEM_HANDAXE:
		case BASE_ITEM_HEAVYCROSSBOW:
		case BASE_ITEM_HEAVYFLAIL:
		case BASE_ITEM_HELMET:
		case BASE_ITEM_KAMA:
		case BASE_ITEM_KATANA:
		case BASE_ITEM_KUKRI:
		case BASE_ITEM_LIGHTCROSSBOW:
		case BASE_ITEM_LIGHTFLAIL:
		case BASE_ITEM_LIGHTHAMMER:
		case BASE_ITEM_LIGHTMACE:
		case BASE_ITEM_LONGBOW:
		case BASE_ITEM_LONGSWORD:
		case BASE_ITEM_MORNINGSTAR:
		case BASE_ITEM_QUARTERSTAFF:
		case BASE_ITEM_RAPIER:
		case BASE_ITEM_SCIMITAR:
		case BASE_ITEM_SCYTHE:
		case BASE_ITEM_SHORTBOW:
		case BASE_ITEM_SHORTSWORD:
		case BASE_ITEM_SHURIKEN:
		case BASE_ITEM_SICKLE:
		case BASE_ITEM_SLING:
		case BASE_ITEM_SPEAR:
		case BASE_ITEM_THROWINGAXE:
		case BASE_ITEM_WARHAMMER:
		case BASE_ITEM_WARMACE:	iSkill = SKILL_CRAFT_WEAPON; break;
		
		case BASE_ITEM_TRAPKIT:	iSkill = SKILL_CRAFT_TRAP; break;
		
		default: iSkill = -1; break;			
		}
	if (iSkill > 0)
	{
		output("Crafting Skill ID: " + IntToString(iSkill));
	}		
	else
	{
		output("Crafting skill ID: ERROR - UNEXPECTED BASE TYPE: " + IntToString(GetBaseItemType(oItem)));
	}		
	
	return iSkill;
}
//
//	GET THE CRAFTING DC BASED ON THE ITEMS COST (ITEM LEVEL RESTRICTION)
//
//	ASSUMES A SKILL OF 35 IS CLOSE TO THE MAX FOR DASARIA
//	THESE DCS ARE DESIGNED TO CORRELATE TO ITEM LEVEL RESTRICTIONS
//
int GetDC(object oItem)
{
	int bIdentified;
	int iDC;
	int iValue;

	bIdentified = GetIdentified(oItem);
    SetIdentified(oItem, TRUE);
	
	iValue = GetGoldPieceValue(oItem);
	iDC = 99;
	if (iValue < 135000)	iDC = 35;
	if (iValue < 120000) 	iDC = 34;
	if (iValue < 110000) 	iDC = 33;
	if (iValue < 98333) 	iDC = 32;
	if (iValue < 86666) 	iDC = 31;
	if (iValue < 75000) 	iDC = 30;
	if (iValue < 66666) 	iDC = 29;
	if (iValue < 58333) 	iDC = 28;
	if (iValue < 50000) 	iDC = 27;
	if (iValue < 45000) 	iDC = 26;
	if (iValue < 40000) 	iDC = 25;
	if (iValue < 35000) 	iDC = 24;
	if (iValue < 31666) 	iDC = 23;
	if (iValue < 28333) 	iDC = 22;
	if (iValue < 25000) 	iDC = 21;
	if (iValue < 21666) 	iDC = 20;
	if (iValue < 18333) 	iDC = 19;
	if (iValue < 15000) 	iDC = 18;
	if (iValue < 13000) 	iDC = 17;
	if (iValue < 11000) 	iDC = 16;
	if (iValue < 9000) 		iDC = 15;
	if (iValue < 7666) 		iDC = 14;
	if (iValue < 6333) 		iDC = 13;
	if (iValue < 5000) 		iDC = 12;
	if (iValue < 4166) 		iDC = 11;
	if (iValue < 3333) 		iDC = 10;
	if (iValue < 2500) 		iDC = 9;
	if (iValue < 2000) 		iDC = 8;
	if (iValue < 1500) 		iDC = 7;
	if (iValue < 1000) 		iDC = 6;
	if (iValue < 880) 		iDC = 5;
	if (iValue < 700) 		iDC = 4;
	if (iValue < 540) 		iDC = 3;
	if (iValue < 360) 		iDC = 2;
	if (iValue < 180)		iDC = 1;
	
    SetIdentified(oItem,bIdentified);

	output("Crafting DC: " + IntToString(iDC));	
	output("Gold Value: " + IntToString(iValue));
	
	return iDC;
}
//
//	GET THE ITEM LEVEL RESTRICTION
//
int GetILR(object oItem)
{
	int bIdentified;
	int iILR;
	int iValue;

	bIdentified = GetIdentified(oItem);
    SetIdentified(oItem, TRUE);
	
	iValue = GetGoldPieceValue(oItem);
	iILR = 99;
	if (iValue <= 130000) iILR = 20;
	if (iValue <= 110000) iILR = 19;
	if (iValue <= 90000) iILR = 18;
	if (iValue <= 75000) iILR = 17;
	if (iValue <= 65000) iILR = 16;
	if (iValue <= 50000) iILR = 15;
	if (iValue <= 40000) iILR = 14;
	if (iValue <= 35000) iILR = 13;
	if (iValue <= 30000) iILR = 12;
	if (iValue <= 25000) iILR = 11;
	if (iValue <= 19500) iILR = 10;
	if (iValue <= 15000) iILR = 9;
	if (iValue <= 12000) iILR = 8;
	if (iValue <= 9000) iILR = 7;
	if (iValue <= 6500) iILR = 6;
	if (iValue <= 5000) iILR = 5;
	if (iValue <= 3500) iILR = 4;
	if (iValue <= 2500) iILR = 3;
	if (iValue <= 1500) iILR = 2;
	if (iValue <= 1000) iILR = 1;
    
	output("Gold Value: " + IntToString(iValue));    

	return iILR;
}
//
//  GET REQUIRED CASTER LEVEL BASED ON THE ITEMS COST
//
int GetRequiredCasterLevel(object oItem)
{
    int iRequiredCasterLevel;
    
    iRequiredCasterLevel = FloatToInt(IntToFloat(GetILR(oItem)) * 1.25);
   	output("Required Caster Level: " + IntToString(iRequiredCasterLevel));
        
    return iRequiredCasterLevel;
}    
//
//	GET THE FOCUS GEM
//
string GetGem(object oItem)
{
	int bIdentified;
	int iValue;
	string sGem;

	bIdentified = GetIdentified(oItem);
    SetIdentified(oItem, TRUE);
	
	iValue = GetGoldPieceValue(oItem);
	sGem = "cft_gem_13";
	if (iValue <= 130000) sGem = "cft_gem_13";
	if (iValue <= 110000) sGem = "cft_gem_12";
	if (iValue <= 90000) sGem = "cft_gem_15";
	if (iValue <= 75000) sGem = "cft_gem_10";
	if (iValue <= 65000) sGem = "cft_gem_14";
	if (iValue <= 50000) sGem = "cft_gem_09";
	if (iValue <= 40000) sGem = "cft_gem_11";
	if (iValue <= 35000) sGem = "NW_IT_GEM005";
	if (iValue <= 30000) sGem = "NW_IT_GEM008";
	if (iValue <= 25000) sGem = "NW_IT_GEM012";
	if (iValue <= 19500) sGem = "NW_IT_GEM009";
	if (iValue <= 15000) sGem = "NW_IT_GEM006";
	if (iValue <= 12000) sGem = "NW_IT_GEM010";
	if (iValue <= 9000) sGem = "NW_IT_GEM013";
	if (iValue <= 6500) sGem = "NW_IT_GEM011";
	if (iValue <= 5000) sGem = "NW_IT_GEM001";
	if (iValue <= 3500) sGem = "NW_IT_GEM004";
	if (iValue <= 2500) sGem = "NW_IT_GEM014";
	if (iValue <= 1500) sGem = "NW_IT_GEM003";
	if (iValue <= 1000) sGem = "NW_IT_GEM002";
	
	return sGem;
}
//
//	GET BASE MATERIAL AND QUANTITY AS SPECIFIED IN THE MOLDS DESCRIPTION.
//
string GetBaseMaterialList(object oItem)
{
	int iSub;
	int iQuantity;
	string sBaseMaterial;
	string sBaseMaterialList;
	string sTag;

	switch (GetBaseItemType(oItem))
	{
		case BASE_ITEM_AMULET:
			sBaseMaterial = "n2_crft_mold_amul";
			iQuantity = 1;
			break;
		case BASE_ITEM_ARMOR:
			switch (GetArmorType(oItem))
		    {
				case ARMOR_TYPE_CLOTHING:
					sBaseMaterial = "n2_crft_mold_robe";
					iQuantity = 0;
					break;
        		case ARMOR_TYPE_PADDED:
					sBaseMaterial = "";
					iQuantity = 0;
					break;
        		case ARMOR_TYPE_LEATHER:
					sBaseMaterial = "n2_crft_hideleather";
					iQuantity = 3;
					break;
        		case ARMOR_TYPE_STUDDED_LEATHER:
					sBaseMaterial = "n2_crft_hideleather";
					iQuantity = 3;
					break;
        		case ARMOR_TYPE_HIDE:
					sBaseMaterial = "n2_crft_hideleather";
					iQuantity = 2;
					break;
        		case ARMOR_TYPE_CHAIN_SHIRT:
					sBaseMaterial = "n2_crft_ingiron";
					iQuantity = 2;
					break;
        		case ARMOR_TYPE_CHAINMAIL:
					sBaseMaterial = "n2_crft_ingiron";
					iQuantity = 3;
					break;
        		case ARMOR_TYPE_BREASTPLATE:
					sBaseMaterial = "n2_crft_ingiron";
					iQuantity = 3;
					break;
        		case ARMOR_TYPE_BANDED_MAIL:
					sBaseMaterial = "n2_crft_ingiron";
					iQuantity = 2;
					break;
        		case ARMOR_TYPE_SCALE_MAIL:
					sBaseMaterial = "n2_crft_ingiron";
					iQuantity = 3;
					break;
        		case ARMOR_TYPE_HALF_PLATE:
					sBaseMaterial = "n2_crft_ingiron";
					iQuantity = 3;
					break;
        		case ARMOR_TYPE_FULL_PLATE:
					sBaseMaterial = "n2_crft_ingiron";
					iQuantity = 3;
					break;
				default:
					sBaseMaterial = "ERROR - UNEXPECTED ARMOR TYPE: " + IntToString(GetArmorType(oItem));
					iQuantity = 0;
					break;
		    }
			break;
		case BASE_ITEM_ARROW:
			sBaseMaterial = "n2_crft_mold_arro";
			iQuantity = 1;
			break;
		case BASE_ITEM_BASTARDSWORD:
			sBaseMaterial = "n2_crft_ingiron";
			iQuantity = 2;
			break;
		case BASE_ITEM_BATTLEAXE:
			sBaseMaterial = "n2_crft_ingiron";
			iQuantity = 1;
			break;
		case BASE_ITEM_BOLT:
			sBaseMaterial = "n2_crft_mold_bolt";
			iQuantity = 1;
			break;
		case BASE_ITEM_BRACER:
			sBaseMaterial = "n2_crft_mold_brac";
			iQuantity = 1;
			break;
		case BASE_ITEM_BULLET:
			sBaseMaterial = "n2_crft_mold_bult";
			iQuantity = 1;
			break;
		case BASE_ITEM_CLUB:
			sBaseMaterial = "n2_crft_plkwood";
			iQuantity = 1;
			break;
		case BASE_ITEM_CLOAK:
			sBaseMaterial = "n2_crft_mold_cloa";
			iQuantity = 1;
			break;
		case BASE_ITEM_DAGGER:
			sBaseMaterial = "n2_crft_ingiron";
			iQuantity = 1;
			break;
		case BASE_ITEM_DART:
			sBaseMaterial = "n2_crft_ingiron";
			iQuantity = 1;
			break;
		case BASE_ITEM_DWARVENWARAXE:
			sBaseMaterial = "n2_crft_ingiron";
			iQuantity = 2;
			break;
		case BASE_ITEM_FALCHION:
			sBaseMaterial = "n2_crft_ingiron";
			iQuantity = 2;
			break;
		case BASE_ITEM_GREATAXE:
			sBaseMaterial = "n2_crft_ingiron";
			iQuantity = 2;
			break;
		case BASE_ITEM_GLOVES:
			sBaseMaterial = "n2_crft_mold_glov";
			iQuantity = 1;
			break;
		case BASE_ITEM_GREATSWORD:
			sBaseMaterial = "n2_crft_ingiron";
			iQuantity = 2;
			break;
		case BASE_ITEM_HALBERD:
			sBaseMaterial = "n2_crft_ingiron";
			iQuantity = 2;
			break;
		case BASE_ITEM_HANDAXE:
			sBaseMaterial = "n2_crft_ingiron";
			iQuantity = 1;
			break;
		case BASE_ITEM_HEAVYCROSSBOW:
			sBaseMaterial = "n2_crft_plkwood";
			iQuantity = 2;
			break;
		case BASE_ITEM_HEAVYFLAIL:
			sBaseMaterial = "n2_crft_ingiron";
			iQuantity = 2;
			break;
		case BASE_ITEM_HELMET:
			sBaseMaterial = "n2_crft_ingiron";
			iQuantity = 2;
			break;
		case BASE_ITEM_KAMA:
			sBaseMaterial = "n2_crft_ingiron";
			iQuantity = 1;
			break;
		case BASE_ITEM_KATANA:
			sBaseMaterial = "n2_crft_ingiron";
			iQuantity = 2;
			break;
		case BASE_ITEM_KUKRI:
			sBaseMaterial = "n2_crft_ingiron";
			iQuantity = 1;
			break;
		case BASE_ITEM_LARGESHIELD:
			sBaseMaterial = "n2_crft_ingiron";
			iQuantity = 2;
			break;
		case BASE_ITEM_LIGHTCROSSBOW:
			sBaseMaterial = "n2_crft_plkwood";
			iQuantity = 2;
			break;
		case BASE_ITEM_LIGHTFLAIL:
			sBaseMaterial = "n2_crft_ingiron";
			iQuantity = 1;
			break;
		case BASE_ITEM_LIGHTHAMMER:
			sBaseMaterial = "n2_crft_ingiron";
			iQuantity = 1;
			break;
		case BASE_ITEM_LIGHTMACE:
			sBaseMaterial = "n2_crft_ingiron";
			iQuantity = 1;
			break;
		case BASE_ITEM_LONGBOW:
			sBaseMaterial = "n2_crft_plkwood";
			if (FindSubString(GetName(oItem), "Composite") != -1) iQuantity = 1;
			else iQuantity = 2;
			break;
		case BASE_ITEM_LONGSWORD:
			sBaseMaterial = "n2_crft_ingiron";
			iQuantity = 2;
			break;
		case BASE_ITEM_MORNINGSTAR:
			sBaseMaterial = "n2_crft_ingiron";
			iQuantity = 2;
			break;
		case BASE_ITEM_QUARTERSTAFF:
			sBaseMaterial = "n2_crft_plkwood";
			iQuantity = 1;
			break;
		case BASE_ITEM_RAPIER:
			sBaseMaterial = "n2_crft_ingiron";
			iQuantity = 1;
			break;
		case BASE_ITEM_RING:
			sBaseMaterial = "n2_crft_mold_ring";
			iQuantity = 1;
			break;
		case BASE_ITEM_SCIMITAR:
			sBaseMaterial = "n2_crft_ingiron";
			iQuantity = 1;
			break;
		case BASE_ITEM_SCYTHE:
			sBaseMaterial = "n2_crft_ingiron";
			iQuantity = 2;
			break;
		case BASE_ITEM_SHORTBOW:
			sBaseMaterial = "n2_crft_plkwood";
			if (FindSubString(GetName(oItem), "Composite") != -1) iQuantity = 1;
			else iQuantity = 2;
			break;
		case BASE_ITEM_SHORTSWORD:
			sBaseMaterial = "n2_crft_ingiron";
			iQuantity = 1;
			break;
		case BASE_ITEM_SHURIKEN:
			sBaseMaterial = "n2_crft_ingiron";
			iQuantity = 1;
			break;
		case BASE_ITEM_SICKLE:
			sBaseMaterial = "n2_crft_ingiron";
			iQuantity = 1;
			break;
		case BASE_ITEM_SLING:
			sBaseMaterial = "n2_crft_hideleather";
			iQuantity = 1;
			break;
		case BASE_ITEM_SMALLSHIELD:
			sBaseMaterial = "n2_crft_ingiron";
			iQuantity = 2;
			break;
		case BASE_ITEM_SPEAR:
			sBaseMaterial = "n2_crft_plkwood";
			iQuantity = 1;
			break;
		case BASE_ITEM_THROWINGAXE:
			sBaseMaterial = "n2_crft_ingiron";
			iQuantity = 2;
			break;
		case BASE_ITEM_TOWERSHIELD:
			sBaseMaterial = "n2_crft_ingiron";
			iQuantity = 3;
			break;
		case BASE_ITEM_TRAPKIT:
			sBaseMaterial = "";
			iQuantity = 0;
			break;
		case BASE_ITEM_WARHAMMER:
			sBaseMaterial = "n2_crft_ingiron";
			iQuantity = 1;
			break;
		case BASE_ITEM_WARMACE:
			sBaseMaterial = "n2_crft_ingiron";
			iQuantity = 1;
			break;
		case BASE_ITEM_MISCSMALL:
			sTag = GetTag(oItem);
			if (sTag == "d2_ammo_arrow_acid" ||
				sTag == "d2_ammo_arrow_fire" ||
				sTag == "d2_ammo_arrow_ice" ||
				sTag == "d2_ammo_arrow_ligh") sBaseMaterial = "n2_crft_mold_arro";
			if (sTag == "d2_ammo_bolt_acid" ||
				sTag == "d2_ammo_bolt_fire" ||
				sTag == "d2_ammo_bolt_ice" ||
				sTag == "d2_ammo_bolt_ligh") sBaseMaterial = "n2_crft_mold_bolt";
			if (sTag == "d2_ammo_bullet_acid" ||
				sTag == "d2_ammo_bullet_fire" ||
				sTag == "d2_ammo_bullet_ice" ||
				sTag == "d2_ammo_bullet_ligh") sBaseMaterial = "n2_crft_mold_bult";
			iQuantity = 1;
			break;			
		default:
			sBaseMaterial = "UNEXPECTED BASE TYPE: " + IntToString(GetBaseItemType(oItem));
			iQuantity = 0;
			break;			
	}
	if (FindSubString(GetName(oItem), "Adamantine") != -1) sBaseMaterial = "n2_crft_ingadamant";
	if (FindSubString(GetName(oItem), "Alchemical Silver") != -1) sBaseMaterial = "n2_crft_ingsilver";
	if (FindSubString(GetName(oItem), "Cold Iron") != -1) sBaseMaterial = "n2_crft_ingcldiron";
	if (FindSubString(GetName(oItem), "Darksteel") != -1) sBaseMaterial = "n2_crft_ingdrksteel";	
	if (FindSubString(GetName(oItem), "Duskwood") != -1) sBaseMaterial = "n2_crft_plkdskwood";
	if (FindSubString(GetName(oItem), "Ironwood") != -1) sBaseMaterial = "NW_IT_MSMLMISC18";
	if (FindSubString(GetName(oItem), "Mithral") != -1) sBaseMaterial = "n2_crft_ingmithral";
	if (FindSubString(GetName(oItem), "Red Dragon Hide") != -1) sBaseMaterial = "n2_crft_hidedragon";
	if (FindSubString(GetName(oItem), "Salamander Hide") != -1) sBaseMaterial = "n2_crft_hidesalam";
	if (FindSubString(GetName(oItem), "Shederran") != -1) sBaseMaterial = "n2_crft_plkshed";	
	if (FindSubString(GetName(oItem), "Umber Hulk Hide") != -1) sBaseMaterial = "n2_crft_hideumber";
	if (FindSubString(GetName(oItem), "Wyvern Hide") != -1) sBaseMaterial = "n2_crft_hidewyvern";
	if (FindSubString(GetName(oItem), "Zalantar") != -1) sBaseMaterial = "n2_crft_plkzalantar";

	sBaseMaterialList = sBaseMaterial;

	for (iSub = 1; iSub < iQuantity; iSub++)
	{
		sBaseMaterialList += "," + sBaseMaterial;
	}

	return sBaseMaterialList;
}
//
//  GET THE ENCHANTMENT SPELL BASED ON ITEM PROPERTY
//
int GetEnchantmentSpell(itemproperty ipProperty)
{
	int iEnchantmentSpell;
	
	switch (GetItemPropertyType(ipProperty))
	{
		case ITEM_PROPERTY_AC_BONUS:
            iEnchantmentSpell = SPELL_MAGE_ARMOR;
        break;
            
		case ITEM_PROPERTY_ATTACK_BONUS:
		case ITEM_PROPERTY_ENHANCEMENT_BONUS:
            iEnchantmentSpell = SPELL_GREATER_MAGIC_WEAPON;
        break;
		case ITEM_PROPERTY_DAMAGE_BONUS:
   			switch (GetItemPropertySubType(ipProperty))
            {
				case IP_CONST_DAMAGETYPE_ACID:
                    iEnchantmentSpell = SPELL_MELFS_ACID_ARROW;
                break; 
				case IP_CONST_DAMAGETYPE_COLD:
                    iEnchantmentSpell = SPELL_ICE_STORM;
                break; 
				case IP_CONST_DAMAGETYPE_ELECTRICAL:
                    iEnchantmentSpell = SPELL_CALL_LIGHTNING;
                break; 
				case IP_CONST_DAMAGETYPE_FIRE:
                    iEnchantmentSpell = SPELL_FLAME_STRIKE;
                break; 
				case IP_CONST_DAMAGETYPE_NEGATIVE:
                    iEnchantmentSpell = SPELL_INFLICT_MODERATE_WOUNDS;
                break; 
				case IP_CONST_DAMAGETYPE_POSITIVE:
                    iEnchantmentSpell = SPELL_CURE_MODERATE_WOUNDS;
                break; 
				case IP_CONST_DAMAGETYPE_SONIC:
                    iEnchantmentSpell = SPELL_SOUND_BURST;
                break; 
//				case IP_CONST_DAMAGETYPE_BLUDGEONING:
//				case IP_CONST_DAMAGETYPE_DIVINE:
//				case IP_CONST_DAMAGETYPE_MAGICAL:
//				case IP_CONST_DAMAGETYPE_PIERCING:
//				case IP_CONST_DAMAGETYPE_SLASHING:
			}
		break;        

        case ITEM_PROPERTY_DAMAGE_RESISTANCE:
			switch (GetItemPropertySubType(ipProperty))
			{
				case IP_CONST_DAMAGETYPE_ACID:
				case IP_CONST_DAMAGETYPE_COLD:
				case IP_CONST_DAMAGETYPE_ELECTRICAL:
				case IP_CONST_DAMAGETYPE_FIRE:
				case IP_CONST_DAMAGETYPE_SONIC:
                    iEnchantmentSpell = SPELL_RESIST_ENERGY;
                break; 
				case IP_CONST_DAMAGETYPE_NEGATIVE:
                    iEnchantmentSpell = SPELL_PROTECTION_FROM_EVIL;
                break; 
				case IP_CONST_DAMAGETYPE_POSITIVE:
                    iEnchantmentSpell = SPELL_PROTECTION_FROM_GOOD;
                break; 
//				case IP_CONST_DAMAGETYPE_BLUDGEONING:
//				case IP_CONST_DAMAGETYPE_DIVINE:
//				case IP_CONST_DAMAGETYPE_MAGICAL:
//				case IP_CONST_DAMAGETYPE_PIERCING:
//				case IP_CONST_DAMAGETYPE_SLASHING:
			}
        break;
	}
    
    output("Enchantment Spell: " + GetSpellName(iEnchantmentSpell));
	return iEnchantmentSpell;
}
//
//  GET THE ENCHANTMENT REAGENTS BASED ON ITEM PROPERTY
//
string GetEnchantmentReagent(itemproperty ipProperty)
{
	string sEnchantmentReagent;
	
	switch (GetItemPropertyType(ipProperty))
	{
		case ITEM_PROPERTY_AC_BONUS:
		case ITEM_PROPERTY_ATTACK_BONUS:
		case ITEM_PROPERTY_ENHANCEMENT_BONUS:
			switch (GetItemPropertyCostTableValue(ipProperty))
			{
				case 1:
					sEnchantmentReagent = "cft_ess_power1";
					break;
				case 2:
					sEnchantmentReagent = "cft_ess_power2";
					break;
				case 3:
					sEnchantmentReagent = "cft_ess_power3";
					break;
				case 4:
					sEnchantmentReagent = "cft_ess_power4";
					break;
				case 5:
					sEnchantmentReagent = "cft_ess_power5";
					break;
				default:
					sEnchantmentReagent = "ERROR - UNEXPECTED ENHANCEMENT BONUS PROPERTY";
					break;
			}
			break;
			
		case ITEM_PROPERTY_CAST_SPELL:
			break;

   		case ITEM_PROPERTY_MIGHTY:
			sEnchantmentReagent = "n2_crft_plkshed";
			break;

		case ITEM_PROPERTY_DAMAGE_BONUS:
        case ITEM_PROPERTY_DAMAGE_RESISTANCE:        
			switch (GetItemPropertySubType(ipProperty))
			{
				case IP_CONST_DAMAGETYPE_ACID:
					switch (GetItemPropertyCostTableValue(ipProperty))
					{
						case DAMAGE_BONUS_1:
//                      case IP_CONST_DAMAGERESIST_5:
							sEnchantmentReagent = "X1_WMGRENADE001,X1_WMGRENADE001";
							break;
						case DAMAGE_BONUS_2:
//                      case IP_CONST_DAMAGERESIST_10:
							sEnchantmentReagent = "n2_it_acid_2,n2_it_acid_2";
							break;
						case DAMAGE_BONUS_1d4:
                        case IP_CONST_DAMAGERESIST_15:
							sEnchantmentReagent = "n2_it_acid_3,n2_it_acid_3";
							break;
						case DAMAGE_BONUS_1d6:
                        case IP_CONST_DAMAGERESIST_20:
							sEnchantmentReagent = "n2_it_acid_4,n2_it_acid_4";
							break;
					}
					break;
//				case IP_CONST_DAMAGETYPE_BLUDGEONING:
//					break;
				case IP_CONST_DAMAGETYPE_COLD:
					switch (GetItemPropertyCostTableValue(ipProperty))
					{
						case DAMAGE_BONUS_1:
//                      case IP_CONST_DAMAGERESIST_5:
                        sEnchantmentReagent = "d2_it_snow_1,d2_it_snow_1";
							break;
						case DAMAGE_BONUS_2:
//                      case IP_CONST_DAMAGERESIST_10:
							sEnchantmentReagent = "d2_it_snow_2,d2_it_snow_2";
							break;
						case DAMAGE_BONUS_1d4:
                        case IP_CONST_DAMAGERESIST_15:
                        sEnchantmentReagent = "d2_it_snow_3,d2_it_snow_3";
							break;
						case DAMAGE_BONUS_1d6:
                        case IP_CONST_DAMAGERESIST_20:
							sEnchantmentReagent = "d2_it_snow_4,d2_it_snow_4";
							break;
					}
					break;
//				case IP_CONST_DAMAGETYPE_DIVINE:
//					break;
				case IP_CONST_DAMAGETYPE_ELECTRICAL:
					switch (GetItemPropertyCostTableValue(ipProperty))
					{
						case DAMAGE_BONUS_1:
//                      case IP_CONST_DAMAGERESIST_5:
							sEnchantmentReagent = "d2_it_shck_1,d2_it_shck_1";
							break;
						case DAMAGE_BONUS_2:
//                      case IP_CONST_DAMAGERESIST_10:
							sEnchantmentReagent = "d2_it_shck_2,d2_it_shck_2";
							break;
						case DAMAGE_BONUS_1d4:
                        case IP_CONST_DAMAGERESIST_15:
							sEnchantmentReagent = "d2_it_shck_3,d2_it_shck_3";
							break;
						case DAMAGE_BONUS_1d6:
                        case IP_CONST_DAMAGERESIST_20:
							sEnchantmentReagent = "d2_it_shck_4,d2_it_shck_4";
							break;
					}
					break;
				case IP_CONST_DAMAGETYPE_FIRE:
					switch (GetItemPropertyCostTableValue(ipProperty))
					{
						case DAMAGE_BONUS_1:
//                      case IP_CONST_DAMAGERESIST_5:
							sEnchantmentReagent = "X1_WMGRENADE002,X1_WMGRENADE002";
							break;
						case DAMAGE_BONUS_2:
//                      case IP_CONST_DAMAGERESIST_10:
							sEnchantmentReagent = "n2_it_alch_2,n2_it_alch_2";
							break;
						case DAMAGE_BONUS_1d4:
                        case IP_CONST_DAMAGERESIST_15:
							sEnchantmentReagent = "n2_it_alch_3,n2_it_alch_3";
							break;
						case DAMAGE_BONUS_1d6:
                        case IP_CONST_DAMAGERESIST_20:
							sEnchantmentReagent = "n2_it_alch_4,n2_it_alch_4";
							break;
					}
					break;
//				case IP_CONST_DAMAGETYPE_MAGICAL:
//					break;
				case IP_CONST_DAMAGETYPE_NEGATIVE:
					switch (GetItemPropertyCostTableValue(ipProperty))
					{
						case DAMAGE_BONUS_1:
//                      case IP_CONST_DAMAGERESIST_5:
							sEnchantmentReagent = "d2_it_grub_1,d2_it_grub_1";
							break;
						case DAMAGE_BONUS_2:
//                      case IP_CONST_DAMAGERESIST_10:
							sEnchantmentReagent = "d2_it_grub_2,d2_it_grub_2";
							break;
						case DAMAGE_BONUS_1d4:
                        case IP_CONST_DAMAGERESIST_15:
							sEnchantmentReagent = "d2_it_grub_3,d2_it_grub_3";
							break;
						case DAMAGE_BONUS_1d6:
                        case IP_CONST_DAMAGERESIST_20:
							sEnchantmentReagent = "d2_it_grub_4,d2_it_grub_4";
							break;
					}
					break;
//				case IP_CONST_DAMAGETYPE_PIERCING:
//					break;
				case IP_CONST_DAMAGETYPE_POSITIVE:
					switch (GetItemPropertyCostTableValue(ipProperty))
					{
						case DAMAGE_BONUS_1:
//                      case IP_CONST_DAMAGERESIST_5:
							sEnchantmentReagent = "X1_WMGRENADE005,X1_WMGRENADE005";
							break;
						case DAMAGE_BONUS_2:
//                      case IP_CONST_DAMAGERESIST_10:
							sEnchantmentReagent = "n2_it_holy_2,n2_it_holy_2";
							break;
						case DAMAGE_BONUS_1d4:
                        case IP_CONST_DAMAGERESIST_15:
							sEnchantmentReagent = "n2_it_holy_3,n2_it_holy_3";
							break;
						case DAMAGE_BONUS_1d6:
                        case IP_CONST_DAMAGERESIST_20:
							sEnchantmentReagent = "n2_it_holy_4,n2_it_holy_4";
							break;
					}
					break;
//				case IP_CONST_DAMAGETYPE_SLASHING:
//					break;
				case IP_CONST_DAMAGETYPE_SONIC:
					switch (GetItemPropertyCostTableValue(ipProperty))
					{
						case DAMAGE_BONUS_1:
//                      case IP_CONST_DAMAGERESIST_5:
							sEnchantmentReagent = "X1_WMGRENADE007,X1_WMGRENADE007";
							break;
						case DAMAGE_BONUS_2:
//                      case IP_CONST_DAMAGERESIST_10:
							sEnchantmentReagent = "n2_it_thun_2,n2_it_thun_2";
							break;
						case DAMAGE_BONUS_1d4:
                        case IP_CONST_DAMAGERESIST_15:
							sEnchantmentReagent = "n2_it_thun_3,n2_it_thun_3";
							break;
						case DAMAGE_BONUS_1d6:
                        case IP_CONST_DAMAGERESIST_20:
							sEnchantmentReagent = "n2_it_thun_4,n2_it_thun_4";
							break;
					}
					break;
				default:
					sEnchantmentReagent = "ERROR - UNEXPECTED DAMAGE BONUS PROPERTY";
					break;
			}
			break;

		case ITEM_PROPERTY_TRAP:
			switch (GetItemPropertyCostTableValue(ipProperty))
			{
				case IP_CONST_TRAPTYPE_ACID_SPLASH:
					switch (GetItemPropertySubType(ipProperty))
					{
						case IP_CONST_TRAPSTRENGTH_MINOR:
							sEnchantmentReagent = "X1_WMGRENADE001";
							break;
						case IP_CONST_TRAPSTRENGTH_AVERAGE:
							sEnchantmentReagent = "n2_it_acid_2";
							break;
						case IP_CONST_TRAPSTRENGTH_STRONG:
							sEnchantmentReagent = "n2_it_acid_3";
							break;
						case IP_CONST_TRAPSTRENGTH_DEADLY:
							sEnchantmentReagent = "n2_it_acid_4";
							break;
						default:
							sEnchantmentReagent = "ERROR - UNEXPECTED TRAP STRENGTH";
							break;
					}
					break;
				case IP_CONST_TRAPTYPE_BLOBOFACID:
					switch (GetItemPropertySubType(ipProperty))
					{
						case IP_CONST_TRAPSTRENGTH_MINOR:
							sEnchantmentReagent = "X1_WMGRENADE006,X1_WMGRENADE001";
							break;
						case IP_CONST_TRAPSTRENGTH_AVERAGE:
							sEnchantmentReagent = "X1_WMGRENADE006,n2_it_acid_2";
							break;
						case IP_CONST_TRAPSTRENGTH_STRONG:
							sEnchantmentReagent = "X1_WMGRENADE006,n2_it_acid_3";
							break;
						case IP_CONST_TRAPSTRENGTH_DEADLY:
							sEnchantmentReagent = "X1_WMGRENADE006,n2_it_acid_4";
							break;
						default:
							sEnchantmentReagent = "ERROR - UNEXPECTED TRAP STRENGTH";
							break;
					}
					break;
				case IP_CONST_TRAPTYPE_ELECTRICAL:
					switch (GetItemPropertySubType(ipProperty))
					{
						case IP_CONST_TRAPSTRENGTH_MINOR:
							sEnchantmentReagent = "d2_it_shck_1";
							break;
						case IP_CONST_TRAPSTRENGTH_AVERAGE:
							sEnchantmentReagent = "d2_it_shck_2";
							break;
						case IP_CONST_TRAPSTRENGTH_STRONG:
							sEnchantmentReagent = "d2_it_shck_3";
							break;
						case IP_CONST_TRAPSTRENGTH_DEADLY:
							sEnchantmentReagent = "d2_it_shck_4";
							break;
						default:
							sEnchantmentReagent = "ERROR - UNEXPECTED TRAP STRENGTH";
							break;
					}
					break;
				case IP_CONST_TRAPTYPE_FIRE:
					switch (GetItemPropertySubType(ipProperty))
					{
						case IP_CONST_TRAPSTRENGTH_MINOR:
							sEnchantmentReagent = "X1_WMGRENADE002";
							break;
						case IP_CONST_TRAPSTRENGTH_AVERAGE:
							sEnchantmentReagent = "n2_it_alch_2";
							break;
						case IP_CONST_TRAPSTRENGTH_STRONG:
							sEnchantmentReagent = "n2_it_alch_3";
							break;
						case IP_CONST_TRAPSTRENGTH_DEADLY:
							sEnchantmentReagent = "n2_it_alch_4";
							break;
						default:
							sEnchantmentReagent = "ERROR - UNEXPECTED TRAP STRENGTH";
							break;
					}
					break;
				case IP_CONST_TRAPTYPE_FROST:
					switch (GetItemPropertySubType(ipProperty))
					{
						case IP_CONST_TRAPSTRENGTH_MINOR:
							sEnchantmentReagent = "d2_it_snow_1";
							break;
						case IP_CONST_TRAPSTRENGTH_AVERAGE:
							sEnchantmentReagent = "d2_it_snow_2";
							break;
						case IP_CONST_TRAPSTRENGTH_STRONG:
							sEnchantmentReagent = "d2_it_snow_3";
							break;
						case IP_CONST_TRAPSTRENGTH_DEADLY:
							sEnchantmentReagent = "d2_it_snow_4";
							break;
						default:
							sEnchantmentReagent = "ERROR - UNEXPECTED TRAP STRENGTH";
							break;
					}
					break;
				case IP_CONST_TRAPTYPE_GAS:
					switch (GetItemPropertySubType(ipProperty))
					{
						case IP_CONST_TRAPSTRENGTH_MINOR:
							sEnchantmentReagent = "X1_WMGRENADE004";
							break;
						case IP_CONST_TRAPSTRENGTH_AVERAGE:
							sEnchantmentReagent = "n2_it_chok_2";
							break;
						case IP_CONST_TRAPSTRENGTH_STRONG:
							sEnchantmentReagent = "n2_it_chok_3";
							break;
						case IP_CONST_TRAPSTRENGTH_DEADLY:
							sEnchantmentReagent = "n2_it_chok_4";
							break;
						default:
							sEnchantmentReagent = "ERROR - UNEXPECTED TRAP STRENGTH";
							break;
					}
					break;
				case IP_CONST_TRAPTYPE_HOLY:
					switch (GetItemPropertySubType(ipProperty))
					{
						case IP_CONST_TRAPSTRENGTH_MINOR:
							sEnchantmentReagent = "X1_WMGRENADE005";
							break;
						case IP_CONST_TRAPSTRENGTH_AVERAGE:
							sEnchantmentReagent = "n2_it_holy_2";
							break;
						case IP_CONST_TRAPSTRENGTH_STRONG:
							sEnchantmentReagent = "n2_it_holy_3";
							break;
						case IP_CONST_TRAPSTRENGTH_DEADLY:
							sEnchantmentReagent = "n2_it_holy_4";
							break;
						default:
							sEnchantmentReagent = "ERROR - UNEXPECTED TRAP STRENGTH";
							break;
					}
					break;
				case IP_CONST_TRAPTYPE_NEGATIVE:
					switch (GetItemPropertySubType(ipProperty))
					{
						case IP_CONST_TRAPSTRENGTH_MINOR:
							sEnchantmentReagent = "d2_it_grub_1";
							break;
						case IP_CONST_TRAPSTRENGTH_AVERAGE:
							sEnchantmentReagent = "d2_it_grub_2";
							break;
						case IP_CONST_TRAPSTRENGTH_STRONG:
							sEnchantmentReagent = "d2_it_grub_3";
							break;
						case IP_CONST_TRAPSTRENGTH_DEADLY:
							sEnchantmentReagent = "d2_it_grub_4";
							break;
						default:
							sEnchantmentReagent = "ERROR - UNEXPECTED TRAP STRENGTH";
							break;
					}
					break;
				case IP_CONST_TRAPTYPE_SONIC:
					switch (GetItemPropertySubType(ipProperty))
					{
						case IP_CONST_TRAPSTRENGTH_MINOR:
							sEnchantmentReagent = "X1_WMGRENADE007";
							break;
						case IP_CONST_TRAPSTRENGTH_AVERAGE:
							sEnchantmentReagent = "n2_it_thun_2";
							break;
						case IP_CONST_TRAPSTRENGTH_STRONG:
							sEnchantmentReagent = "n2_it_thun_3";
							break;
						case IP_CONST_TRAPSTRENGTH_DEADLY:
							sEnchantmentReagent = "n2_it_thun_4";
							break;
						default:
							sEnchantmentReagent = "ERROR - UNEXPECTED TRAP STRENGTH";
							break;
					}
					break;
				case IP_CONST_TRAPTYPE_SPIKE:
					switch (GetItemPropertySubType(ipProperty))
					{
						case IP_CONST_TRAPSTRENGTH_MINOR:
							sEnchantmentReagent = "NW_WTHDT001";
							break;
						case IP_CONST_TRAPSTRENGTH_AVERAGE:
							sEnchantmentReagent = "NW_WTHMDT002";
							break;
						case IP_CONST_TRAPSTRENGTH_STRONG:
							sEnchantmentReagent = "NW_WTHMDT008";
							break;
						case IP_CONST_TRAPSTRENGTH_DEADLY:
							sEnchantmentReagent = "NW_WTHMDT009";
							break;
						default:
							sEnchantmentReagent = "ERROR - UNEXPECTED TRAP STRENGTH";
							break;
					}
					break;
				case IP_CONST_TRAPTYPE_TANGLE:
					switch (GetItemPropertySubType(ipProperty))
					{
						case IP_CONST_TRAPSTRENGTH_MINOR:
							sEnchantmentReagent = "X1_WMGRENADE006";
							break;
						case IP_CONST_TRAPSTRENGTH_AVERAGE:
							sEnchantmentReagent = "n2_it_tang_2";
							break;
						case IP_CONST_TRAPSTRENGTH_STRONG:
							sEnchantmentReagent = "n2_it_tang_3";
							break;
						case IP_CONST_TRAPSTRENGTH_DEADLY:
							sEnchantmentReagent = "n2_it_tang_4";
							break;
						default:
							sEnchantmentReagent = "ERROR - UNEXPECTED TRAP STRENGTH";
							break;
					}
					break;
				default:
					sEnchantmentReagent = "ERROR - UNEXPECTED TRAP TYPE";
					break;
			}
			break;
		case ITEM_PROPERTY_USE_LIMITATION_CLASS:
			sEnchantmentReagent = "";
			break;
		default:
			sEnchantmentReagent = "ERROR - UNEXPECTED ITEM PROPERTY: " + IntToString(GetItemPropertyType(ipProperty));
			break;
	}
	return sEnchantmentReagent;
}

//
//	GET THE MUNDANE INGREDIENTS BASED ON THE ITEM
//

string GetMundaneIngredients(object oItem)
{
	int iUniqueMaterial;
	itemproperty ipProperty;
	string sIngredient;
	string sIngredients;
	
	sIngredients = GetBaseMaterialList(oItem);
	
	iUniqueMaterial = FALSE;
	if (FindSubString(GetName(oItem), "Adamantine") != -1) iUniqueMaterial = TRUE;
	if (FindSubString(GetName(oItem), "Alchemical Silver") != -1) iUniqueMaterial = TRUE;
	if (FindSubString(GetName(oItem), "Cold Iron") != -1) iUniqueMaterial = TRUE;
	if (FindSubString(GetName(oItem), "Darksteel") != -1) iUniqueMaterial = TRUE;
	if (FindSubString(GetName(oItem), "Duskwood") != -1) iUniqueMaterial = TRUE;
	if (FindSubString(GetName(oItem), "Ironwood") != -1) iUniqueMaterial = TRUE;
	if (FindSubString(GetName(oItem), "Mithral") != -1) iUniqueMaterial = TRUE;
	if (FindSubString(GetName(oItem), "Red Dragon Hide") != -1) iUniqueMaterial = TRUE;
	if (FindSubString(GetName(oItem), "Salamander Hide") != -1) iUniqueMaterial = TRUE;
	if (FindSubString(GetName(oItem), "Shederran") != -1) iUniqueMaterial = TRUE;
	if (FindSubString(GetName(oItem), "Umber Hulk Hide") != -1) iUniqueMaterial = TRUE;
	if (FindSubString(GetName(oItem), "Wyvern Hide") != -1) iUniqueMaterial = TRUE;
	if (FindSubString(GetName(oItem), "Zalantar") != -1) iUniqueMaterial = TRUE;
	
	ipProperty = GetFirstItemProperty(oItem);
	while (GetIsItemPropertyValid(ipProperty) && !iUniqueMaterial)
	{
		sIngredient = GetEnchantmentReagent(ipProperty);
		if (sIngredient != "")
		{
			if (sIngredients == "")
			{
				sIngredients += sIngredient;
			}
			else
			{
				sIngredients += "," + sIngredient;
			}
		}
		ipProperty = GetNextItemProperty(oItem);	
	}

	output ("Ingredients: " + GetResrefName(sIngredients));
	
	return sIngredients;
}    
//
//	GET THE MAGICAL INGREDIENTS BASED ON THE ITEM
//
string GetMagicalIngredients(object oItem)
{
	itemproperty ipProperty;
	string sIngredients;
	
	sIngredients = GetGem(oItem);

   	ipProperty = GetFirstItemProperty(oItem);
	while (GetIsItemPropertyValid(ipProperty))
	{
		if (sIngredients == "")
		{
			sIngredients += GetEnchantmentReagent(ipProperty);
		}
		else
		{
			sIngredients += "," + GetEnchantmentReagent(ipProperty);
		}
		ipProperty = GetNextItemProperty(oItem);	
	}

	output ("Ingredients: " + GetResrefName(sIngredients));
	
	return sIngredients;
}