/*
*/

void main()
	{
	object oPC = GetPCSpeaker();

	effect e = EffectVisualEffect( VFX_DUR_CUTSCENE_INVISIBILITY);
	
	ApplyEffectToObject( DURATION_TYPE_PERMANENT, e, oPC );
	
	
	}

/*
*/