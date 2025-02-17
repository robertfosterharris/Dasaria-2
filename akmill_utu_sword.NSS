
void main()
{
	object oPC = GetLastHostileActor();
	if (GetIsPossessedFamiliar(oPC))
	{
		oPC = GetMaster(oPC);
	}
	FloatingTextStringOnCreature("bad idea",oPC);
	effect eVis = EffectVisualEffect(VFX_IMP_DIVINE_STRIKE_HOLY);	
	ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oPC);	
	effect eFX = EffectDeath();
	ApplyEffectToObject( DURATION_TYPE_INSTANT,eFX,oPC );
	
	effect Dam=EffectDamage(d8(4),DAMAGE_TYPE_MAGICAL,DAMAGE_POWER_NORMAL,TRUE);
DelayCommand(0.1,ApplyEffectToObject(DURATION_TYPE_INSTANT,Dam,oPC));
DelayCommand(0.105,ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectCutsceneParalyze(),oPC, 6.0));
DelayCommand(0.11,ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectKnockdown(),oPC, 6.0));
}