//	d2_p1_remorhaz_sting

/*
	Secondary effect of remorhaz_sting: 2d4 points of damage.
*/
//	JSH-OEI 03/27/08

void main()
{
	object oTarget	= OBJECT_SELF;
	int nDamage		= d4(2);
	effect eDamage	= EffectDamage(nDamage, DAMAGE_TYPE_COLD);
	effect eVisual	= EffectVisualEffect(VFX_IMP_HEAD_COLD);
	ApplyEffectToObject(DURATION_TYPE_INSTANT, eDamage, OBJECT_SELF);
}