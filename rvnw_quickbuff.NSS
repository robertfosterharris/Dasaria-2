#include "ginc_param_const"

void WoodsQuickBuffMe(string sTag)
{
	object oBuffee = GetTarget(sTag, TARGET_OWNER);
	effect eSRInc = EffectSpellResistanceIncrease(30);
	ApplyEffectToObject(DURATION_TYPE_INSTANT, eSRInc, oBuffee);
	effect eImmuneKD = EffectImmunity(IMMUNITY_TYPE_KNOCKDOWN);
	effect eImmuneCrit = EffectImmunity(IMMUNITY_TYPE_CRITICAL_HIT);
	ApplyEffectToObject(DURATION_TYPE_INSTANT, eImmuneKD, oBuffee);
	ApplyEffectToObject(DURATION_TYPE_INSTANT, eImmuneCrit, oBuffee);
	ActionCastSpellAtObject(SPELL_GREATER_STONESKIN, oBuffee,METAMAGIC_ANY,TRUE,0,PROJECTILE_PATH_TYPE_DEFAULT,TRUE);
	ActionCastSpellAtObject(SPELL_BARKSKIN, oBuffee,METAMAGIC_ANY,TRUE,0,PROJECTILE_PATH_TYPE_DEFAULT,TRUE);
	ActionCastSpellAtObject(SPELL_GREATER_SPELL_MANTLE, oBuffee,METAMAGIC_ANY,TRUE,0,PROJECTILE_PATH_TYPE_DEFAULT,TRUE);
	ActionCastSpellAtObject(SPELL_DEATH_WARD, oBuffee,METAMAGIC_ANY,TRUE,0,PROJECTILE_PATH_TYPE_DEFAULT,TRUE);
}

void main(string sTag)
{
	DelayCommand(2.0f,WoodsQuickBuffMe(sTag));
}