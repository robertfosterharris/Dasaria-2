/*

// ga_destroy_item

    This takes an item from a player
        sItemTag    = This is the string name of the item's tag
        nQuantity   = The number of items to destroy. -1 is all of the Player's items of that tag.
        nPCFaction  = Take from the whole PC faction

// FAB 9/30
// DBR 8/10/6

// jhr4n - 11/8/2006 - made it actually work.  
//	specifically, with stacked items

*/

#include "nw_i0_plot"

void DestroyItems(object oTarget,string sItem,int nNumItems);


void main( string sItemTag, int quantity, int bParty )
{
    int nTotalItem;
    object oPCF,oPC = (GetPCSpeaker()==OBJECT_INVALID?GetFirstPC():GetPCSpeaker());
    object oItem;       // Items in inventory

    if ( bParty == 0 )
    {
        if ( quantity < 0 )    // Destroy all instances of the item
        {
            nTotalItem = GetNumItems( oPC,sItemTag );
            DestroyItems( oPC,sItemTag,nTotalItem );
        }
        else
        {
            DestroyItems( oPC,sItemTag,quantity );
        }
    }
    else    // For multiple players
    {
        oPCF = GetFirstFactionMember(oPC,FALSE);
        while (( GetIsObjectValid(oPCF) )&&(quantity!=0))
        {
            if ( quantity < 0 )    // Destroy all instances of the item
            {
                nTotalItem = GetNumItems( oPCF,sItemTag );
                DestroyItems( oPCF,sItemTag,nTotalItem );
            }
            else
            {
				nTotalItem = GetNumItems( oPCF,sItemTag );
				quantity -= nTotalItem;
				if (quantity<0)
				{
					nTotalItem+=quantity;
					quantity=0;
				}
                DestroyItems( oPCF,sItemTag,nTotalItem );
            }
            oPCF = GetNextFactionMember(oPC,FALSE);
        }
    }
}




void DestroyItems(object oTarget,string sItem,int nNumItems)
{
    int nCount = 0;
    object oItem = GetFirstItemInInventory(oTarget);

    while (GetIsObjectValid(oItem) == TRUE && nCount < nNumItems)
    {
        if (GetTag(oItem) == sItem)
        {
			int stack_size = GetItemStackSize(oItem);
			if ( stack_size > nNumItems )
				{
				SetItemStackSize( oItem, stack_size-nNumItems);
				return;				
				}
			
			if ( stack_size > 1 )
				{
				DestroyObject(oItem,0.1f);
				nCount += stack_size;
				}
				
            //ActionTakeItem(oItem,oTarget);
			DestroyObject(oItem,0.1f);
            nCount++;
        }
        oItem = GetNextItemInInventory(oTarget);
    }

   return;
}