/*
	Apply vfx-implosion and destroy the NPC speaker

	2006/12/10		jhr4n
		Initial revision	
*/


void	main( )
	{
	
	object oNPC = OBJECT_SELF;
	
	object oPC = GetPCSpeaker();

	effect eHit = EffectVisualEffect( VFX_FNF_IMPLOSION );
	ApplyEffectToObject(DURATION_TYPE_INSTANT, eHit, oNPC);		
	
	DestroyObject( oNPC );
	


	
	}


/*
*/