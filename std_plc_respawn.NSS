/*
	Respawn a placeable.
	
	Put this script in the OnDeath event.
		
	If no respawn time is given, it will use a module-wide
	default (currently 5 min).
	
	
	
	
	2006/11/24		jhr4n
		Initial revision
	
*/



string kRespawn = "cfg_plc_respawn";

// this older method is used on some instances still
// TODO: remove them
string kRespawn_old = "config_respawn";



void	do_respawn( string resref, location loc)
	{
	CreateObject(OBJECT_TYPE_PLACEABLE, resref, loc);
	}


void	main()
	{
	object oPLC = OBJECT_SELF;
	string resref = GetResRef( oPLC );
	location loc = GetLocation( oPLC );

	float fDelay = GetLocalFloat( oPLC, kRespawn );
	if ( fDelay < 1.0 )
		{
		// Try loading the old variable
		fDelay = GetLocalFloat( oPLC, kRespawn_old );
		
		// Still nothing?  Default = 300.0
		if ( fDelay < 1.0 )
           fDelay = 300.0;
		}
		
	

	
	AssignCommand( GetArea(oPLC), 
		DelayCommand( fDelay, 
			do_respawn(resref, loc)
			)
		);
	}



/*
*/