//	ON OPEN - USED TO EXAMINE PROPERTIES OF ITEMS IN A CONTAINER
//
//	ROBERT HARRIS	ROBERTHARRIS@ROBERTHARRIS.COM
//
#include "ginc_das_crafting"
//
//	MAIN
//
void main()
{
	object oItem;
	itemproperty ipProperty;
		
	oItem = GetFirstItemInInventory();
	while (GetIsObjectValid(oItem))
	{
		SetIdentified(oItem, TRUE);
		output("");
		output(GetName(oItem) + " - " + GetResRef(oItem));
		GetDC(oItem);
		ipProperty = GetFirstItemProperty(oItem);
		while (GetIsItemPropertyValid(ipProperty))
		{
			output("Cost Table: " + IntToString(GetItemPropertyCostTable(ipProperty)));
			output("Cost Value: " + IntToString(GetItemPropertyCostTableValue(ipProperty)));
			output("Duration: " + IntToString(GetItemPropertyDurationType(ipProperty)));
			output("Parameter: " + IntToString(GetItemPropertyParam1(ipProperty)));
			output("Parameter Value: " + IntToString(GetItemPropertyParam1Value(ipProperty)));
			output("Type: " + IntToString(GetItemPropertyType(ipProperty)));
			output("Sub Type: " + IntToString(GetItemPropertySubType(ipProperty)));
			ipProperty = GetNextItemProperty(oItem);	
		}
		oItem = GetNextItemInInventory();
	}
}