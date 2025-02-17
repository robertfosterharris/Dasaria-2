//	ON USED - CREATES RECIPES FOR THE ITEMS FOUND IN D2_CRAFT_ALCHEMY.2DA
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
	sItem = Get2DAString("d2_craft_alchemy", "RESREF", nRow);
	if (nRow == 0)
	{
		SendMessageToPC(GetLastUsedBy(), "ALCHEMY...");	
		output("");
		output("----");
		output("ALCHEMY");
		output("----");	
	}
	while ((sItem != "") && (nCount < 15))
	{
		oItem = CreateObject(OBJECT_TYPE_ITEM, sItem, locLocation);
		if (GetIsObjectValid(oItem))
		{
			SetIdentified(oItem, TRUE);
			output("");
			output(GetStringUpperCase(GetName(oItem)) + " - " + GetStringUpperCase(sItem));
	        CreateAlchemyRecipe(GetDC(oItem), GetMundaneIngredients(oItem), GetResRef(oItem));
			DestroyObject(oItem);
		}
		else
		{
			output("ERROR: " + GetStringUpperCase(sItem));
		}
		nCount++;
		nRow++;
		sItem = Get2DAString("d2_craft_alchemy", "RESREF", nRow);
	}
	SetLocalInt(OBJECT_SELF, "nRow", nRow);
	if (sItem == "") SendMessageToPC(GetLastUsedBy(), "DONE!");
	
	ExecuteScript("x2_plc_used_act", OBJECT_SELF);
}