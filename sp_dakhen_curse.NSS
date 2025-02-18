// wired 11/1/12 -- Dakhen Plague has been cured
// sp_dakhen_curse 


void main()
{
    effect eBonus = SupernaturalEffect( EffectSavingThrowIncrease(SAVING_THROW_FORT,1,SAVING_THROW_TYPE_DISEASE));
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, eBonus, OBJECT_SELF );
}


/*
void main()
{
    int bDEBUG = TRUE;
	
	if (bDEBUG == TRUE) {	SendMessageToPC(OBJECT_SELF,"DEBUG: Dakhen Curse"); }

	effect eCon= EffectAbilityDecrease( ABILITY_CONSTITUTION, 2 );
    effect eStr= EffectAbilityDecrease( ABILITY_STRENGTH, 2 );
    effect eDex= EffectAbilityDecrease( ABILITY_DEXTERITY, 2 );
    effect eDur = EffectVisualEffect( VFX_DUR_SICKENED );
    effect eSick1 = EffectLinkEffects( eCon, eStr );
    effect eSick2 = EffectLinkEffects( eSick1, eDex );
    //effect eLink = EffectLinkEffects( eSick2, eDur );  

	effect eLink = SupernaturalEffect( eSick2);	

	// Make the infected person sick
	ApplyEffectToObject(DURATION_TYPE_PERMANENT, eLink, OBJECT_SELF);

    //Declare and apply the AOE
    effect eAOE = SetEffectSpellId ( SupernaturalEffect( EffectAreaOfEffect( AOE_PER_CUSTOM_AOE, "sp_dakhen_curse_en" ) ),1878);
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, eAOE, OBJECT_SELF );
}
*/