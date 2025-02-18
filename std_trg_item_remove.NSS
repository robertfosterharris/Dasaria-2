/*

	Remove an item from a player entering the trigger


	2007/1/27		jhr4n		
		initial revision

*/


string	kCfgResref = "cfg_item_tag";


void	main()
	{
	
	object oTrg = OBJECT_SELF;
	object oPC = GetEnteringObject();
	
	string tag = GetLocalString( oTrg, kCfgResref );
	if ( tag == "" )
		{
		//panic		
		return;
		}
	
	object oItem = GetItemPossessedBy( oPC, tag );	
	DestroyObject( oItem );
	
	}



/*
*/