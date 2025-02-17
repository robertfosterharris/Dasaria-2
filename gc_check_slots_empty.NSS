// gc_slots_empty
// wired 01.14.2010
// return TRUE if all PC inventory slots are empty

int StartingConditional()
{
	object oPC = GetPCSpeaker();
	object oItem;
	int nSlot = 0;

	while (nSlot < NUM_INVENTORY_SLOTS)
	{
		if (	GetIsObjectValid(GetItemInSlot(nSlot, oPC))	)
		{
			return FALSE;
		}
		nSlot++;
	}	
	return TRUE;
}