//	ONCLOSE SCRIPT FOR PVP DEATH DROP CONTAINER
//	RETURN LEFT ITEMS TO PVP LOSER
//
//	ROBERT HARRIS	ROBERTHARRIS@ROBERTHARRIS.COM	03/06/2007
//
//	RFH	03/13/2007	MAKE SURE ITS ONE OF THE PVP COMBATANTS CLOSING THE CONTAINER
//
void main()
{
	object oItem;
	object oPC;
	
	oPC = GetLastClosedBy();
	if ((oPC == GetLocalObject(OBJECT_SELF, "oKiller") || (oPC == GetLocalObject(OBJECT_SELF, "oPC"))))
	{
		oItem = GetFirstItemInInventory(OBJECT_SELF);
		while (GetIsObjectValid(oItem))
		{
			DeleteLocalInt(oItem, "bStolenDrop");
			CopyItem(oItem, oPC, TRUE);
			DestroyObject(oItem);
			oItem = GetNextItemInInventory(OBJECT_SELF);
		}
		DestroyObject(OBJECT_SELF);
	}		
}