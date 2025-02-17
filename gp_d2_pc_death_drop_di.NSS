//	ON INVENTORY DISTURBED SCRIPT FOR PVP DEATH DROP CONTAINER
//	CLEAR STOLEN ITEM FLAG FROM ITEMS CLAIMED BY THE PVP VICTOR
//
//	ROBERT HARRIS	ROBERTHARRIS@ROBERTHARRIS.COM	03/06/2007
//
void main()
{
	object oItem;
	
	oItem = GetInventoryDisturbItem();
	
	if	((GetInventoryDisturbType() == INVENTORY_DISTURB_TYPE_REMOVED) && 
		(GetLastDisturbed() == GetLocalObject(OBJECT_SELF, "oKiller")) &&
		(GetLocalInt(oItem, "bStolenDropDrop")))
		{
			SetStolenFlag(oItem, FALSE);
			DeleteLocalInt(oItem, "bStolenDropDrop");
		}			
}