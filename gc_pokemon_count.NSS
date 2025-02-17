// gc_pokemon_count
// wired 2010-11-19

/* 
   Compares the number of items with tag sItemTag the speaker/party possesses to condition sCheck.

   Parameters:
     string sItemTag  = Tag of the item to count.
     string sCheck    = Condition and value to check, for example:
						"<5" Less than 5
						">1" Greater than 1
						"=9" Equal to 9
						"!0" Not equal to 0
     int bParty      = If =1 then check party's inventory, else check speaker inventory only
*/

#include "ginc_var_ops"

int GetNumPokemonItems(object oTarget,string sItem, string sCreature)
{
    int nNumItems = 0;
    object oItem = GetFirstItemInInventory(oTarget);

    while (GetIsObjectValid(oItem) == TRUE)
    {
        if (	GetTag(oItem) == sItem && GetLocalString(oItem, "sCreature") == sCreature	)
        {
            nNumItems = nNumItems + GetNumStackedItems(oItem);
        }
        oItem = GetNextItemInInventory(oTarget);
    }

   return nNumItems;
}

int StartingConditional(string sCreature, string sCheck, int bParty)
{
	object oPC = GetPCSpeaker();
	object oMember;
	int nItems = 0;
	string sItemTag = "rfh_pokemon";
	
	if (bParty == 0)
	{
		nItems = GetNumPokemonItems(oPC, sItemTag, sCreature);
	}
	else
	{
		oMember = GetFirstFactionMember(oPC, FALSE);
		while (GetIsObjectValid(oMember))
		{
			nItems = nItems +  GetNumPokemonItems(oMember, sItemTag, sCreature);
			oMember = GetNextFactionMember(oPC, FALSE);
		}
	}
	
	return CompareInts(nItems, sCheck);
}