// std_dstry_questitems
// wired 2009-10-16 
// destroy quest items placed in chest


void main()
{
	object oItem = GetFirstItemInInventory();
	while ( GetIsObjectValid(oItem))
	{
	 	if (
			GetPlotFlag(oItem) == TRUE ||
			GetBaseItemType(oItem) == BASE_ITEM_KEY
			)
		{
			SetPlotFlag(oItem,FALSE);
			DestroyObject( oItem );
			
		}
		oItem = GetNextItemInInventory();
	}
}
	
	
/*
*/