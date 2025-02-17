// 2bridges_nightwig_exit
void main()
{
	object oDragon = OBJECT_SELF;
	effect eTeleport = EffectVisualEffect(VFX_HIT_CLEANSING_NOVA);
	ApplyEffectToObject(DURATION_TYPE_INSTANT, eTeleport, oDragon);
	DelayCommand(1.0,JumpToObject(GetNearestObjectByTag("nightwig_home")));
	DelayCommand(5.0, DestroyObject(oDragon));
}