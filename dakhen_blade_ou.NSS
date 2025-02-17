// wired 2010/04/04

void main()
{
	object oPC = GetLastUsedBy();
	object oShovel = CreateItemOnObject("wired_dahken_dagger",oPC);
	ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectDeath(),OBJECT_SELF);	
}