void main()
{
	effect eExplode = EffectNWN2SpecialEffectFile("fx_wooden_explosion_big");
	ApplyEffectAtLocation(DURATION_TYPE_INSTANT,eExplode,GetLocation(GetNearestObjectByTag("plc_mincer_trap")));
	PlaySound("al_en_expbarrel05");
	
	ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectDeath(),GetNearestObjectByTag("plc_mincer_trap"));
	ExecuteScript("go_xp_trap",OBJECT_SELF);
}