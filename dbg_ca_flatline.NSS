/*
	Flatline the PC - take them to -1 HP
*/

void	main()
	{
	object oPC = GetPCSpeaker();
	
	int hp = GetCurrentHitPoints(oPC);
	effect e = EffectDamage( hp+1 );
	
	ApplyEffectToObject( DURATION_TYPE_INSTANT, e, oPC );
	
	}


/*
*/