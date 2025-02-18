// back off my doors, exploiters!
// wired 10/30/07
void main()
{
	object oPC = GetLastHostileActor();
	if (GetIsPossessedFamiliar(oPC))
	{
		oPC = GetMaster(oPC);
	}
	FloatingTextStringOnCreature("You weren't really expecting to smash that, were you?",oPC);
	effect eVis = EffectVisualEffect(VFX_IMP_FLAME_M);	
	ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oPC);	
	effect eFX = EffectDeath();
	ApplyEffectToObject( DURATION_TYPE_INSTANT,eFX,oPC );
}