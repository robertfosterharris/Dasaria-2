void main()
{
	object oPC = GetPCSpeaker();
	effect eFX = EffectVisualEffect(VFX_DUR_LIGHT);
	ApplyEffectToObject( DURATION_TYPE_TEMPORARY,eFX,oPC,900.00 );
}