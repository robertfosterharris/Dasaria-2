void main()
{
	object oPC = GetPCSpeaker();
	effect eFX = EffectKnockdown();
	ApplyEffectToObject( DURATION_TYPE_INSTANT,eFX,oPC );
}