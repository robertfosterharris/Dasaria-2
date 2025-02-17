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
		
	2008/12/28		wired
		Forge Version
		Changed distance from 20 to 30
		Do not destroy on empty, destroyed automatically on harvest		
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

	int debug			= FALSE;	
	object oHerb 		= OBJECT_SELF;	
	string herb_ownerpc = "herb_ownerpc";	
	object oPC 			= GetLocalObject( oHerb, herb_ownerpc );
	float dist 			= GetDistanceBetween( oPC, oHerb);
	
	if (debug) SendMessageToPC(oPC, "I'm here: " + FloatToString(dist) );
	
	if ( dist > 40.0 )
	{
		if (debug) SendMessageToPC(oPC, "You're pretty far away" );
		Wipe( oHerb );
	}	
		
		
	}
	
/*
*/