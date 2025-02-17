//	ON USED - REPORTS NAMES OF CRAFTABLE ITEMS
//
//	ROBERT HARRIS	ROBERTHARRIS@ROBERTHARRIS.COM	03/01/2007
//
#include "ginc_crafting"

void main()
{
	int nRow;
	string sOutput;
	string sSkill;
	object oItem;
	
	nRow = 0;
	sOutput = Get2DAString("crafting", "OUTPUT", nRow);
	sSkill = Get2DAString("crafting", "SKILL", nRow);
	while (sOutput != "")
	{
		oItem = CreateObject(OBJECT_TYPE_ITEM, sOutput, GetLocation(OBJECT_SELF));
		if (GetIsObjectValid(oItem))
		{
			
			output(sSkill + "	" + sOutput + "	" + GetName(oItem));
			DestroyObject(oItem);
		}
		else
		{
			output("ERROR: " + sOutput);
		}
		nRow++;
		sOutput = Get2DAString("crafting", "OUTPUT", nRow);
		sSkill = Get2DAString("crafting", "SKILL", nRow);
	}
}