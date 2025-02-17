//	GC_CHECK_POKEMON
//
//	02/07/2013	ROBERT HARRIS	PLAYER MAY HAVE MORE THAN ONE POKEMON.  CHECK ENTIRE INVENTORY.

int StartingConditional(string sCreature)
{
	int bFound;
    object oPC;
	object oItem;

	bFound = FALSE;
	oPC = GetPCSpeaker();
	
	oItem = GetFirstItemInInventory(oPC);
	if (GetTag(oItem) == "rfh_pokemon" && GetLocalString(oItem, "sCreature") == sCreature) bFound = TRUE;

	while ((GetIsObjectValid(oItem) && !bFound))
	{
		oItem = GetNextItemInInventory(oPC);
		if (GetTag(oItem) == "rfh_pokemon" && GetLocalString(oItem, "sCreature") == sCreature) bFound = TRUE;
	}
	
	return bFound;
}