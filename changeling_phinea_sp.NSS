// changeling_phinea_sp

void ActionPhineaSpawn()
{
	object oFana = GetNearestObjectByTag("ravenswatch_changeling_fana");
	if (GetIsObjectValid(oFana)) ActionForceFollowObject(oFana);
	else DestroyObject(OBJECT_SELF);
}

void main()
{
    effect eVis = EffectVisualEffect(VFX_DUR_SLEEP);

	DelayCommand(2.0,ApplyEffectToObject(DURATION_TYPE_PERMANENT, eVis, OBJECT_SELF));
	DelayCommand(2.5,ActionPhineaSpawn());
}