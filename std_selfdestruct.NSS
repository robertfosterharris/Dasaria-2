// wired 09/18/08 self-destruct
void main()
{
	effect eExplosion = EffectVisualEffect(VFX_COM_HIT_FIRE);
	ApplyEffectToObject(DURATION_TYPE_INSTANT,eExplosion,OBJECT_SELF);
	DestroyObject(OBJECT_SELF);
}