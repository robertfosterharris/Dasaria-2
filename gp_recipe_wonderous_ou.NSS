//	ON USED - CREATES RECIPES FOR THE ITEMS FOUND IN D2_CRAFT_ENCHANTMENTS.2DA
//
//	ROBERT HARRIS	ROBERTHARRIS@ROBERTHARRIS.COM	10/23/2007
//
//	ON USED - CREATES RECIPES FOR THE ITEMS FOUND IN d2_craft_wonderous.2DA
//
//	ROBERT HARRIS	ROBERTHARRIS@ROBERTHARRIS.COM	03/02/2007
//
#include "ginc_das_crafting"

void main()
{
	int nRow;
	int nCount;
	location locLocation;
	object oItem;
	string sItem;

	
	ExecuteScript("x2_plc_used_act", OBJECT_SELF);
	
	nCount = 0;
	nRow = GetLocalInt(OBJECT_SELF, "nRow");
	locLocation = GetLocation(OBJECT_SELF);
	sItem = Get2DAString("d2_craft_wonderous", "RESREF", nRow);
	if (nRow == 0)
	{
		SendMessageToPC(GetLastUsedBy(), "WONDEROUS ITEMS...");
		output("");
		output("----");
		output("WONDEROUS ITEMS");
		output("----");	
	}
	while ((sItem != "") && (nCount < 10))
	{
		oItem = CreateObject(OBJECT_TYPE_ITEM, sItem, locLocation);
		if (GetIsObjectValid(oItem))
		{
			SetIdentified(oItem, TRUE);
			output("");
			output(GetStringUpperCase(GetName(oItem)) + " - " + GetStringUpperCase(sItem));
			CreateWondrousRecipe(GetEnchantmentSpell(GetFirstItemProperty(oItem)), GetMundaneIngredients(oItem), sItem, GetRequiredCasterLevel(oItem)); 
//			CreateMundaneRecipe(GetMold(oItem), GetSkill(oItem), GetDC(oItem), GetMundaneIngredients(oItem), sItem);
//			CreateMagicalRecipe(GetEnchantmentSpell(GetFirstItemProperty(oItem)), sEncodedEffect, iCategory, GetMagicalIngredients(oItem), GetRequiredCasterLevel(oItem));CreateMagicalRecipe(GetEnchantmentSpell(GetFirstItemProperty(oItem)), sEncodedEffect, iCategory, GetMagicalIngredients(oItem), GetRequiredCasterLevel(oItem));
			DestroyObject(oItem);
		}
		else
		{
			output("ERROR: " + GetStringUpperCase(sItem));
		}
		nCount++;
		nRow++;
		sItem = Get2DAString("d2_craft_wonderous", "RESREF", nRow);
	}
	SetLocalInt(OBJECT_SELF, "nRow", nRow);
	if (sItem == "") SendMessageToPC(GetLastUsedBy(), "DONE!");
	
	ExecuteScript("x2_plc_used_act", OBJECT_SELF);
}