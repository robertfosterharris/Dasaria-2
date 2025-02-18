// std_dstry_questitems_id
// wired 2010-04-04 
// destroy quest items placed in chest


void main()
{
	object oItem = GetInventoryDisturbItem();
 	if (GetPlotFlag(oItem) == TRUE || GetBaseItemType(oItem) == BASE_ITEM_KEY)
	{
		SetPlotFlag(oItem,FALSE);
		DestroyObject( oItem );
	}
}