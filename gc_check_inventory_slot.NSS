//	CHECKS FOR AN ITEM IN A SPECIFIC INVENTORY SLOT
//
//	nInventorySlot = THE INVENTORY SLOT
//	nTag = THE ITEM (BLANK FOR ANY ITEM)
//
//	INVENTORY_SLOT_HEAD			= 0
//	INVENTORY_SLOT_CHEST		= 1
//	INVENTORY_SLOT_BOOTS		= 2
//	INVENTORY_SLOT_ARMS			= 3
//	INVENTORY_SLOT_RIGHTHAND	= 4
//	INVENTORY_SLOT_LEFTHAND		= 5
//	INVENTORY_SLOT_CLOAK		= 6
//	INVENTORY_SLOT_LEFTRING		= 7
//	INVENTORY_SLOT_RIGHTRING	= 8
//	INVENTORY_SLOT_NECK			= 9
//	INVENTORY_SLOT_BELT			= 10
//	INVENTORY_SLOT_ARROWS		= 11
//	INVENTORY_SLOT_BULLETS		= 12
//	INVENTORY_SLOT_BOLTS		= 13
//	INVENTORY_SLOT_CWEAPON_L	= 14
//	INVENTORY_SLOT_CWEAPON_R	= 15
//	INVENTORY_SLOT_CWEAPON_B	= 16
//	INVENTORY_SLOT_CARMOUR		= 17
//
//	01/26/07	ROBERT HARRIS	ROBERTHARRIS@ROBERTHARRIS.COM
//
int StartingConditional(int nInventorySlot, string sTag)
{
	int bFound;
	object oItem;
	object oPC;
	
	bFound = FALSE;
	oPC = GetPCSpeaker();
	oItem = GetItemInSlot(nInventorySlot, oPC);
	
	if (GetIsObjectValid(oItem) && sTag == "") bFound = TRUE;
	if (GetIsObjectValid(oItem) && oItem == GetObjectByTag(sTag)) bFound = TRUE;
	
	return bFound;
}