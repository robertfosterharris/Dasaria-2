// ga_knockdown
// wired 11/16/2007
// sTarget = Tag of Object to KD, else OWNER
//
#include "ginc_param_const"
void main(string sTarget)
{
	object oTarget = GetTarget(sTarget, TARGET_OWNER);
	effect eKD = EffectKnockdown();
	ApplyEffectToObject(DURATION_TYPE_INSTANT, eKD, oTarget);
}