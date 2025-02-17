void main()
{
	object oPC = GetPCSpeaker();
	effect eFX = EffectDeath();
	ApplyEffectToObject( DURATION_TYPE_INSTANT,eFX,oPC );
}