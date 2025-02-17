void main()
{
//DeathScript
object oJiLyn = OBJECT_SELF;
effect eFireyDeath;

eFireyDeath = EffectVisualEffect( VFX_DUR_FIRE );

ApplyEffectToObject( DURATION_TYPE_TEMPORARY , eFireyDeath , oJiLyn, 20.0);


}