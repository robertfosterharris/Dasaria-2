#include "ginc_das_crafting"

void main()
{
	int nRow;
	int nCount;
	string sItem;
	string sSkill;
	object oItem;
	
	nCount = 0;
	nRow = GetLocalInt(OBJECT_SELF, "nRow");
	sItem = Get2DAString("rfhlist", "ITEM", nRow);
	while ((sItem != "") && (nCount < 250))
	{
		oItem = CreateObject(OBJECT_TYPE_ITEM, sItem, GetLocation(OBJECT_SELF));
		if (GetIsObjectValid(oItem))
		{
			output(GetName(oItem) + "	" + GetResRef(oItem) + "	" + IntToString(GetBaseItemType(oItem)) + "	" + IntToString(GetILR(oItem)));
			DestroyObject(oItem);
		}
		else
		{
			output("ERROR: " + sItem);
		}
		nCount++;
		nRow++;
		sItem = Get2DAString("rfhlist", "ITEM", nRow);
	}
	SetLocalInt(OBJECT_SELF, "nRow", nRow);
	if (sItem == "") SendMessageToPC(GetLastUsedBy(), "DONE!");
}