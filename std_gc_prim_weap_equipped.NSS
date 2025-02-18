int StartingConditional() {
	object oPC = GetPCSpeaker();
	object oPrimaryWeapon = GetItemInSlot(INVENTORY_SLOT_RIGHTHAND, oPC);
	if (oPrimaryWeapon == OBJECT_INVALID) {
		return FALSE;
	}
	return TRUE;
}