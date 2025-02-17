// gtr_plc_trap_disarm

void main()
{
	string sPlcTag = GetLocalString(OBJECT_SELF,"sPlcTag");
	effect eExplode = EffectNWN2SpecialEffectFile("fx_wooden_explosion_big");
	ApplyEffectAtLocation(DURATION_TYPE_INSTANT,eExplode,GetLocation(GetNearestObjectByTag("plc_mincer_trap")));
	PlaySound("al_en_expbarrel05");
	
	ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectDeath(),GetNearestObjectByTag(sPlcTag));
	ExecuteScript("go_xp_trap",OBJECT_SELF);
}