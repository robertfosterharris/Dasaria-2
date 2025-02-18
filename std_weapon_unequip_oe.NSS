
int is_weapon(object oItem);
void main() {
	object oPC = GetEnteringObject();
	int iSpeechStringTriggered = FALSE;
	if (GetIsPC(oPC) == TRUE) {
		object oRightHand = GetItemInSlot(INVENTORY_SLOT_RIGHTHAND, oPC);
		object oLeftHand = GetItemInSlot(INVENTORY_SLOT_LEFTHAND, oPC);
		
		
		if (oLeftHand != OBJECT_INVALID && is_weapon(oLeftHand) == TRUE) {
			iSpeechStringTriggered = TRUE;
			AssignCommand(oPC, ActionUnequipItem(oLeftHand));
			DelayCommand(3.0, FloatingTextStringOnCreature("As you enter through the gates, the guard motions for you to sheath your weapon.  Not wanting to incur a writ, you obligingly do so.", oPC));
		}
		if (oRightHand != OBJECT_INVALID && is_weapon(oRightHand) == TRUE) {
			AssignCommand(oPC, ActionUnequipItem(oRightHand));
			if (iSpeechStringTriggered = FALSE) {
				DelayCommand(3.0, FloatingTextStringOnCreature("As you enter through the gates, the guard motions for you to sheath your weapon.  Not wanting to incur a writ, you obligingly do so.", oPC));
			}
		}
		

	}
}

int is_weapon(object oItem) {
	switch (GetBaseItemType(oItem)) {
		case BASE_ITEM_BASTARDSWORD:
			return TRUE;
		case BASE_ITEM_BATTLEAXE:
			return TRUE;
		case BASE_ITEM_CGIANT_AXE:
			return TRUE;
		case BASE_ITEM_CGIANT_SWORD:
			return TRUE;
		case BASE_ITEM_DIREMACE:
			return TRUE;
		case BASE_ITEM_DOUBLEAXE:
			return TRUE;
		case BASE_ITEM_DWARVENWARAXE:
			return TRUE;
		case BASE_ITEM_FALCHION:
			return TRUE;
		case BASE_ITEM_GREATAXE:
			return TRUE;
		case BASE_ITEM_FLAIL:
			return TRUE;
		case BASE_ITEM_GREATSWORD:
			return TRUE;
		case BASE_ITEM_HALBERD:
			return TRUE;
		case BASE_ITEM_HANDAXE:
			return TRUE;
		case BASE_ITEM_HEAVYCROSSBOW:
			return TRUE;
		case BASE_ITEM_HEAVYFLAIL:
			return TRUE;
		case BASE_ITEM_KAMA:
			return TRUE;
		case BASE_ITEM_KATANA:
			return TRUE;
		case BASE_ITEM_KUKRI:
			return TRUE;
		case BASE_ITEM_LIGHTCROSSBOW:
			return TRUE;
		case BASE_ITEM_LIGHTFLAIL:
			return TRUE;
		case BASE_ITEM_LIGHTHAMMER:
			return TRUE;
		case BASE_ITEM_LIGHTMACE:
			return TRUE;
		case BASE_ITEM_LONGBOW:
			return TRUE;
		case BASE_ITEM_LONGSWORD:
			return TRUE;
		case BASE_ITEM_MACE:
			return TRUE;
		case BASE_ITEM_MAGICSTAFF:
			return TRUE;
		case BASE_ITEM_QUARTERSTAFF:
			return TRUE;
		case BASE_ITEM_MORNINGSTAR:
			return TRUE;
		case BASE_ITEM_RAPIER:
			return TRUE;
		case BASE_ITEM_SCIMITAR:
			return TRUE;
		case BASE_ITEM_SCYTHE:
			return TRUE;
		case BASE_ITEM_SHORTBOW:
			return TRUE;
		case BASE_ITEM_SHORTSPEAR:
			return TRUE;
		case BASE_ITEM_SHORTSWORD:
			return TRUE;
		case BASE_ITEM_SICKLE:
			return TRUE;
		case BASE_ITEM_SLING:
			return TRUE;
		case BASE_ITEM_SPEAR:
			return TRUE;
		case BASE_ITEM_THROWINGAXE:
			return TRUE;
		case BASE_ITEM_TWOBLADEDSWORD:
			return TRUE;
		case BASE_ITEM_WARHAMMER:
			return TRUE;
		case BASE_ITEM_WARMACE:
			return TRUE;
		case BASE_ITEM_WHIP:
			return TRUE;
		default:
			return FALSE;
	}
	return FALSE;
}