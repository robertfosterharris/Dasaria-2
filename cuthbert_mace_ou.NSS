// wired 2010/04/04

void main()
{
	object oPC = GetLastUsedBy();
	object oMace = CreateItemOnObject("wiredevent_cuthbert_mace",oPC);
	ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectDeath(),OBJECT_SELF);
	ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_AOE_WEB_OF_PURITY),oPC);	
}