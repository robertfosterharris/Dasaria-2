void main()
{
	object oPC = GetPCSpeaker();

	effect Efx;
Efx = EffectPolymorph(POLYMORPH_TYPE_ZOMBIE);

Efx = SupernaturalEffect(Efx);

ApplyEffectToObject(DURATION_TYPE_PERMANENT, Efx, oPC);

}