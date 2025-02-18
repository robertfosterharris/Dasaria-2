/*
	
	Destroy all inventory items

	

	11/13/2006		jhr4n		Written
*/

void main()
	{
	object oItem = GetFirstItemInInventory();
	while ( GetIsObjectValid(oItem) )
		{
		DestroyObject( oItem );
		
		oItem = GetNextItemInInventory();
		}
	}
	
	
/*
*/