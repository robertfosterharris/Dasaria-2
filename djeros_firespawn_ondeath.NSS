//Modification of ms_explosive_barrels

//	Put firespawn_ondeath in the creature's OnDeath Event. 
	
	
//	Set up the blast radius and damage dice (how many d6 for EACH type of damage,
//	fire)
	
//	Create two integer variables in the pleaceable.
	
//	BLAST_DICE  The amount of damage dice to use
//	BLAST_RADIUS  From 1 to 6
	
//	1 = Small Radius  	  = 1.524f; // ~5 feet
//	2 = Medium Radius 	  = 3.048f; // ~10 feet
//	3 = Large Radius 	  = 4.572f; // ~15 feet
//	4 = Huge Radius   	  = 6.069f; // ~20 feet (Same as a Fireball)
//	5 = Gargantuan Radius = 7.620f; // ~25 feet
//	6 = Colossal Radius   = 9.144f; // ~30 feet
	
//	Any other number or value will default to Large Radius
	



void main()
{
	object oTarget = OBJECT_SELF; 
	
		if (GetLocalInt(oTarget, "BLAST_EXPLODING")) return;
	SetLocalInt(oTarget, "BLAST_EXPLODING", TRUE);
	
	// Set initial variables
	location lBlastPoint = GetLocation(oTarget); 
	float fRadius;
	float fBangDelay;

	int nDice = GetLocalInt(OBJECT_SELF, "BLAST_DICE");
	
	// Default to 1 Damage Die if none set
	nDice = nDice >= 1 ? nDice : 1;

	effect eFireDam   = EffectDamage(d6(nDice), DAMAGE_TYPE_FIRE);
	
	// Set Knockdown duration based on blast size
	float fDuration = IntToFloat(nDice) * 3.0;;
	
	effect eBlast = EffectKnockdown();

	  
	// Check and set how big the damage radius is
	switch (GetLocalInt(OBJECT_SELF, "BLAST_RADIUS")) 
    { 
		case 1:  fRadius = RADIUS_SIZE_SMALL;      	break; 
		case 2:  fRadius = RADIUS_SIZE_MEDIUM; 	 	break; 
		case 3:  fRadius = RADIUS_SIZE_LARGE;		break; 
		case 4:  fRadius = RADIUS_SIZE_HUGE;		break; 
		case 5:  fRadius = RADIUS_SIZE_GARGANTUAN; 	break; 
		case 6:  fRadius = RADIUS_SIZE_COLOSSAL;	break; 
		default: fRadius = RADIUS_SIZE_LARGE;		break; 
    }
	
	effect eExplosion2 = EffectNWN2SpecialEffectFile( "sp_fire_hit.sef", oTarget);
	
	// If more than 4d6, BIG explosion and debris drops
    if (nDice >= 4)
	{
	    
        eExplosion2 = EffectNWN2SpecialEffectFile( "sp_fireball_hit_aoe.sef", oTarget);

		
	
      
		//Debug("Effect Object= " + ObjectToString(oTarget));
	}
	
	// Fire the blast
	ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eExplosion2, lBlastPoint);

	  
	object oVictim = GetFirstObjectInShape(SHAPE_SPHERE, fRadius, lBlastPoint, TRUE, OBJECT_TYPE_CREATURE); 
	
	while (GetIsObjectValid(oVictim)) 
    { 
		
		if (GetPlotFlag(oVictim) == FALSE)	
        {
			DelayCommand(fBangDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eFireDam , oVictim)); 
			
			
			// If the Victim is a Creature knock em down
			// Blast has to be bigger then 2 to work 
			if (nDice > 2 & GetObjectType(oVictim) == OBJECT_TYPE_CREATURE)
			{
				ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eBlast, oVictim, fDuration); 	   
			}
		  
			// Again if 4d6 or more, BIG bang		  
			if (nDice >= 4)
			{		  
				ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectNWN2SpecialEffectFile("fx_fire_lg"), oVictim, 3.0); 
			}  
			// Again, if 2d6 or less small bang
			else
			{
				ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectNWN2SpecialEffectFile("sfx_fire"), oVictim, 3.0); 	  
			}	 
		}  
		// Get next victim!
		oVictim = GetNextObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_LARGE, lBlastPoint, TRUE, OBJECT_TYPE_CREATURE); 

	} // END WHILE
}
  