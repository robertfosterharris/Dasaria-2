//	ON USED - CREATES RECIPES FOR THE ITEMS FOUND IN D2_CRAFT_ENCHANTMENTS.2DA
//
//	ROBERT HARRIS	ROBERTHARRIS@ROBERTHARRIS.COM	04/10/2007
//
//const int ITEM_CATEGORY_NONE    		= 0;
//const int ITEM_CATEGORY_WEAPON  		= 1;
//const int ITEM_CATEGORY_ARMOR_SHIELD  = 2;
//const int ITEM_CATEGORY_OTHER   		= 4;
//const int ITEM_CATEGORY_ALL   		= 7;
#include "ginc_das_crafting"

void main()
{
	int nRow;
	int nCount;
	location locLocation;
	object oItem;
	string sItem;

    int iCategory;
    int iType;
    int iSubType;
    int iValue;
    string sDescription;
    string sEncodedEffect;

	
	ExecuteScript("x2_plc_used_act", OBJECT_SELF);
	
	nCount = 0;
	nRow = GetLocalInt(OBJECT_SELF, "nRow");
	locLocation = GetLocation(GetLastUsedBy());
	   

    iCategory = StringToInt(Get2DAString("d2_craft_enchantments", "ITEM", nRow));
	iType = StringToInt(Get2DAString("d2_craft_enchantments", "TYPE", nRow));
    iSubType = StringToInt(Get2DAString("d2_craft_enchantments", "SUBTYPE", nRow));
    iValue = StringToInt(Get2DAString("d2_craft_enchantments", "VALUE", nRow));
    sDescription = Get2DAString("d2_craft_enchantments", "DESCRIPTION", nRow);
    
	if (nRow == 0)
	{
		SendMessageToPC(GetLastUsedBy(), "ENCHANTMENTS...");	
		output("");
		output("----");
		output("ENCHANTMENTS");
		output("----");	
	}
	while ((iType > 0) && (nCount < 15))
	{
		output("");
		output(GetStringUpperCase(sDescription));

        switch (iCategory)
        {
            case ITEM_CATEGORY_ARMOR_SHIELD:
                oItem = CreateObject(OBJECT_TYPE_ITEM, "nw_aarcl007", locLocation);
                break;
            case  ITEM_CATEGORY_WEAPON:
                oItem = CreateObject(OBJECT_TYPE_ITEM, "nw_wswgs001", locLocation);            
                break;
        }
        SetFirstName(oItem, sDescription);

        sEncodedEffect = MakeEncodedEffect(iType, iSubType, iValue);
        ApplyEncodedEffectToItem(oItem, sEncodedEffect, 60.0);

		CreateMagicalRecipe(GetEnchantmentSpell(GetFirstItemProperty(oItem)), sEncodedEffect, iCategory, GetMagicalIngredients(oItem), GetRequiredCasterLevel(oItem));
		
        DestroyObject(oItem);

		nCount++;
		nRow++;
        iCategory = StringToInt(Get2DAString("d2_craft_enchantments", "ITEM", nRow));        
	  	iType = StringToInt(Get2DAString("d2_craft_enchantments", "TYPE", nRow));
	    iSubType = StringToInt(Get2DAString("d2_craft_enchantments", "SUBTYPE", nRow));
	    iValue = StringToInt(Get2DAString("d2_craft_enchantments", "VALUE", nRow));
	    sDescription = Get2DAString("d2_craft_enchantments", "DESCRIPTION", nRow);
	}
	SetLocalInt(OBJECT_SELF, "nRow", nRow);
	if (iType == 0) SendMessageToPC(GetLastUsedBy(), "DONE!");
	ExecuteScript("x2_plc_used_act", OBJECT_SELF);
}