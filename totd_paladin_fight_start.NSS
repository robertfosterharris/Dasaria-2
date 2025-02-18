//	ACTION - 	SAVES THE PC DOING THE TALKING
//				SETS RAVAEL'S PARTY TO HOSTILE
//				SET INVENTORY ITEMS TO DROPABLE
//				SET EQUIPED ITEMS TO DROPABLE
//
//	07/22/08	ROBERT HARRIS	ROBERTHARRIS@ROBERTHARRIS.COM

void main()
{
	int bMatch;
	int nItem;
	location lPC;
	object oArea;
	object oItem;
	object oNPC;
	object oPC;
	string sTag;
	
	oArea = GetObjectByTag("thayadmount");	
	oPC = (GetPCSpeaker()==OBJECT_INVALID?OBJECT_SELF:GetPCSpeaker());
	lPC = GetLocation(oPC);
	SetLocalObject(oArea, "totd_PC", oPC);

	oNPC = GetFirstObjectInShape(SHAPE_SPHERE, 30.0, lPC);
	while (GetIsObjectValid(oNPC))
	{
		sTag = GetTag(oNPC);
		bMatch = FALSE;
		if (sTag == "totd_party_cleric") bMatch = TRUE;
		if (sTag == "totd_party_fighter") bMatch = TRUE;
		if (sTag == "totd_party_paladin") bMatch = TRUE;
		if (sTag == "totd_party_ranger") bMatch = TRUE;
		if (sTag == "totd_party_rogue") bMatch = TRUE;
		if (sTag == "totd_party_wizard") bMatch = TRUE;
		if (bMatch)
		{
			oItem = GetFirstItemInInventory(oNPC);
			while (GetIsObjectValid(oItem))
			{
				SetDroppableFlag(oItem, TRUE);
				oItem = GetNextItemInInventory(oNPC);
			}
			
			for (nItem = 0; nItem < NUM_INVENTORY_SLOTS; nItem++)
			{
				oItem = GetItemInSlot(nItem, oNPC);
				if (GetIsObjectValid(oItem))
				{
					SetDroppableFlag(oItem, TRUE);
				}
			}
			
			
			ChangeToStandardFaction(oNPC, STANDARD_FACTION_HOSTILE);
		}
		oNPC = GetNextObjectInShape(SHAPE_SPHERE, 30.0, lPC);
	}
}