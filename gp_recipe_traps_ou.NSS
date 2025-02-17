//	ON USED - CREATES RECIPES FOR THE ITEMS FOUND IN D2_CRAFT_TRAPS.2DA
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
	sItem = Get2DAString("d2_craft_traps", "RESREF", nRow);
	if (nRow == 0)
	{
		SendMessageToPC(GetLastUsedBy(), "TRAPS...");	
		output("");
		output("----");
		output("TRAPS");
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
			CreateMundaneRecipe(GetMold(oItem), GetSkill(oItem), GetDC(oItem), GetMundaneIngredients(oItem), sItem);
			DestroyObject(oItem);
		}
		else
		{
			output("ERROR: " + GetStringUpperCase(sItem));
		}
		nCount++;
		nRow++;
		sItem = Get2DAString("d2_craft_traps", "RESREF", nRow);
	}
	SetLocalInt(OBJECT_SELF, "nRow", nRow);
	if (sItem == "") SendMessageToPC(GetLastUsedBy(), "DONE!");
	
	ExecuteScript("x2_plc_used_act", OBJECT_SELF);
}