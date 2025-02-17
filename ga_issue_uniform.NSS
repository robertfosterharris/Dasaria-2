//	ga_issue_uniform(string sUniform)
//	
//	CHANGES THE SPEAKERS EQUIPPED ITEMS TO MATCH UNIFORM APPEARANCE
//	NO CHANGE OCCURS IF THE SOURCE ITEM DOESN'T EXIST OR THE TARGET ITEM ISN'T EQUIPPED
//
//	CREATE UNIFORM ITEMS WITH RESREFS FOLLOWING THIS FORM
//		sUniform_armor
//		sUniform_belt
//		sUniform_boots
//		sUniform_cloak
//		sUniform_gloves
//		sUniform_helmet
//		sUniform_shield_light
//		sUniform_shield_heavy
//		sUniform_shield_tower
//
//	NOTES:
//	THE SETARMORTYPERULES FUNCTION DOES NOT WORK ON SHIELDS, WHICH IS WHY YOU NEED ONE BASE ITEM PER SHIELD TYPE
//	GLOVES OF ARMOR ARE CONVERTED TO GLOVES OF DEFLECTION - USE GLOVES AT YOUR OWN RISK
//	GETDESCRIPTION ONLY WORKS FOR ARMOR

void issue_uniform(object oPC, string sUniform, string sType, int nSlot);

void main(string sUniform)
{
	object oPC;
	
	oPC = GetPCSpeaker();
	if (GetIsObjectValid(oPC))
	{
		 issue_uniform (oPC, sUniform, "armor",  INVENTORY_SLOT_CHEST);
		 issue_uniform (oPC, sUniform, "belt",  INVENTORY_SLOT_BELT);
		 issue_uniform (oPC, sUniform, "boots",  INVENTORY_SLOT_BOOTS);
		 issue_uniform (oPC, sUniform, "cloak",  INVENTORY_SLOT_CLOAK);
		 issue_uniform (oPC, sUniform, "gloves", INVENTORY_SLOT_ARMS);
		 issue_uniform (oPC, sUniform, "helmet", INVENTORY_SLOT_HEAD);
		 issue_uniform (oPC, sUniform, "shield", INVENTORY_SLOT_LEFTHAND);
	}
}

void issue_uniform(object oPC, string sUniform, string sType, int nSlot)
{
	int	nType;
	itemproperty ipProperty;
	object oOld;
	object oNew;
	string sDescription;
		
	oOld = GetItemInSlot(nSlot, oPC);
	if (sType == "shield")
	{
		switch (GetBaseItemType(oOld))
		{
			case BASE_ITEM_SMALLSHIELD: sType = "shield_light"; break;
			case BASE_ITEM_LARGESHIELD: sType = "shield_heavy"; break;
			case BASE_ITEM_TOWERSHIELD: sType = "shield_tower"; break;
			default: oOld = OBJECT_INVALID;
		}
	}
	if (GetIsObjectValid(oOld))
	{
		oNew = CreateItemOnObject(sUniform + "_" + sType, oPC, 1, GetTag(oOld), FALSE);
		if (GetIsObjectValid(oNew))
		{
			SetArmorRulesType(oNew, GetArmorRulesType(oOld));
			SetDescription(oNew, GetDescription(oOld));
			SetFirstName(oNew, GetName(oOld));
			SetIdentified(oNew, TRUE);
			SetItemBaseMaterialType(oNew, GetItemBaseMaterialType(oOld));
			SetItemCursedFlag(oNew, GetItemCursedFlag(oOld));
			SetPlotFlag(oNew, GetPlotFlag(oOld));
			SetStolenFlag(oNew, GetStolenFlag(oOld));
			if (GetItemCharges(oOld) > 0) SetItemCharges(oNew, GetItemCharges(oOld));

			ipProperty = GetFirstItemProperty(oOld);
			while(GetIsItemPropertyValid(ipProperty))
			{
				if (GetItemPropertyDurationType(ipProperty) == DURATION_TYPE_PERMANENT) AddItemProperty(DURATION_TYPE_PERMANENT, ipProperty, oNew);
				ipProperty = GetNextItemProperty(oOld);
			}

			SetPlotFlag(oOld, FALSE);
			DestroyObject(oOld, 0.0, FALSE);
			AssignCommand(oPC, ActionEquipItem(oNew, nSlot));
		}
	}
}