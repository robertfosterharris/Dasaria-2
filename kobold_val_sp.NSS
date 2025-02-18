// kobold_val_sp
//
// val will flee if reduced to 10hp, this is a failsafe
//
void main()
{
		effect eHeal = EffectHealOnZeroHP(OBJECT_SELF, 100 );
		ApplyEffectToObject(DURATION_TYPE_INSTANT,eHeal,OBJECT_SELF);
}