// gp_forgemagic_ca
/*
    forge magic weapons on spell cast
*/
// ChazM 12/15/05
// ChazM 3/28/06 Crafting call interface change
//
//	RFH		12/01/06		PRE-CHECK ITEMS TO ENSURE THEY DON'T HAVE TOO MANY ENCHANTMENTS
//  RFH     05/23/07        LOG USER AND TARGET

#include "ginc_crafting"

const int DASARIA_MAX_ENCHANTMENTS = 2;		//	THE MAXIMUM NUMBER OF ENCHANTMENTS WE ALLOW

void main()
{
	int iItemPropCount;
	object oItem;
	object oPC;

	oItem = GetFirstItemInInventory(OBJECT_SELF);
	oPC = GetLastSpellCaster();

    output("oPC = " + GetName(oPC));
    output("oTarget = " + GetName(OBJECT_SELF));
    
	while ((GetIsObjectValid(oItem) == TRUE) && (iItemPropCount < DASARIA_MAX_ENCHANTMENTS))
	{
		iItemPropCount = GetNumberItemProperties(oItem);
		if (iItemPropCount >= DASARIA_MAX_ENCHANTMENTS) ErrorNotify(oPC, ERROR_TARGET_HAS_MAX_ENCHANTMENTS);
		oItem = GetNextItemInInventory(OBJECT_SELF);
	}		

	if (iItemPropCount < DASARIA_MAX_ENCHANTMENTS)
	{
		int iSpellID = GetLastSpell();
    	object oCaster = GetLastSpellCaster();
    	output ("iSpellID = " + IntToString(iSpellID), oCaster);
    	DoMagicCrafting(iSpellID, oCaster);
	}		
}