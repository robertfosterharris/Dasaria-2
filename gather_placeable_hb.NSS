/*
	Heartbeat of the harvestable "herb node"
	
	The purpose is to clean up after ourselves.
		Check to see if the finder has wandered off.  If he has, 
		delete myself and my contents.
		
		If we are empty, delete ourselves.  This could be done
		OnDicturbed, but it works here too and we need this 
		script anyway.		
		

	2006/11/??		jhr4n
		Initial revision
	
	2006/11/25		jhr4n
		Changed distance from 10 to 20
*/


void	Wipe( object obj )
	{
	object oItem = GetFirstItemInInventory();
	while ( GetIsObjectValid( oItem ) )
		{
		DestroyObject( oItem );
		oItem = GetNextItemInInventory();
		}
	DestroyObject( obj );
	
	}

void main()
	{
	
	object oHerb = OBJECT_SELF;
	
	string herb_ownerpc = "herb_ownerpc";
	
	object oPC = GetLocalObject( oHerb, herb_ownerpc );
	
	float dist = GetDistanceBetween( oPC, oHerb);
	
	//SendMessageToPC(oPC, "I'm here: " + FloatToString(dist) );
	
	if ( !GetIsObjectValid( GetFirstItemInInventory() ) )
		{
		//SendMessageToPC(oPC, "I'm empty" );
		Wipe( oHerb );
		}
		
	if ( dist > 20.0 )
		{
		//SendMessageToPC(oPC, "You're pretty far away" );
		Wipe( oHerb );
		}	
		
		
	}
	
/*
*/