// ga_destroy pokemon
// destroy pokemon
// same as ga_destroy_item with additional parameter for creature tag
/*
    This takes an item from a player
        sItemTag    = This is the string name of the item's tag
        nQuantity   = The number of items to destroy. -1 is all of the Player's items of that tag.
        nPCFaction  = Take from the whole PC faction
		// wired 10/23/2008 sCreature = tag of the Pokeman object
*/
// FAB 9/30
// DBR 8/10/6

#include "nw_i0_plot"

void DestroyPKMItems(object oTarget,string sItem,int nNumItems, string sCreature)
{
    int nCount = 0;
    object oItem = GetFirstItemInInventory(oTarget);

    while (GetIsObjectValid(oItem) == TRUE && nCount < nNumItems)
    {
        if (	(GetTag(oItem) == sItem) &&
				(GetLocalString(oItem, "sCreature") == sCreature)
			)
        {
            //ActionTakeItem(oItem,oTarget);
			DestroyObject(oItem,0.1f);
            nCount++;
        }
        oItem = GetNextItemInInventory(oTarget);
    }

   return;
}

void main(string sItemTag,int nQuantity,int bPCFaction, string sCreature)
{
    int nTotalItem;
    object oPCF,oPC = (GetPCSpeaker()==OBJECT_INVALID?GetFirstPC():GetPCSpeaker());
    object oItem;       // Items in inventory

    if ( bPCFaction == 0 )
    {
        if ( nQuantity < 0 )    // Destroy all instances of the item
        {
            nTotalItem = GetNumItems( oPC,sItemTag );
            DestroyPKMItems( oPC,sItemTag,nTotalItem,sCreature );
        }
        else
        {
            DestroyPKMItems( oPC,sItemTag,nQuantity,sCreature );
        }
    }
    else    // For multiple players
    {
        oPCF = GetFirstFactionMember(oPC,FALSE);
        while (( GetIsObjectValid(oPCF) )&&(nQuantity!=0))
        {
            if ( nQuantity < 0 )    // Destroy all instances of the item
            {
                nTotalItem = GetNumItems( oPCF,sItemTag );
                DestroyPKMItems( oPCF,sItemTag,nTotalItem,sCreature );
            }
            else
            {
				nTotalItem = GetNumItems( oPCF,sItemTag );
				nQuantity -= nTotalItem;
				if (nQuantity<0)
				{
					nTotalItem+=nQuantity;
					nQuantity=0;
				}
                DestroyPKMItems( oPCF,sItemTag,nTotalItem,sCreature );
            }
            oPCF = GetNextFactionMember(oPC,FALSE);
        }
    }
}