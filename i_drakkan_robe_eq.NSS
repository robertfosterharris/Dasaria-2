// i_srcs_robe_eq
// wired 2009/10/16
// because this item is a essentially a nude
// with the garment model in the belt slot, 
// requip worn belts to ensure nothing untoward
// happens; _eq runs after equip, _uq runs before
//

void main()
{

	//SendMessageToPC(GetFirstPC(),"Running i_srcs_robe_eq!");
	
	object oPC      = GetPCItemLastEquippedBy();
	object oItem    = GetPCItemLastEquipped();
	
	if (GetGender(oPC) == GENDER_MALE)
	{	
		ActionUnequipItem(oItem);
		SendMessageToPC(oPC,"This item can only be worn by a woman.");
		return;
	}
	
	object oBelt	= GetItemInSlot(INVENTORY_SLOT_BELT,oPC);
	if (!GetIsObjectValid(oBelt)) return;	
	

	object oTemp;
	
	// remove belt
 	AssignCommand(oPC,ActionUnequipItem(oBelt));

	// equip proxy
	oTemp = CreateItemOnObject("NW_CLOTH024",oPC,1,"temp_garment",FALSE);
	ActionEquipItem(oTemp,INVENTORY_SLOT_CHEST);
	
	// equip outfit
	DelayCommand(0.3, ActionEquipItem(oItem,INVENTORY_SLOT_CHEST));	
	// requip belt
	DelayCommand(1.0, ActionEquipItem(oBelt,INVENTORY_SLOT_BELT));
	
	// cleanup proxy
	DestroyObject(oTemp,0.0,FALSE);
}