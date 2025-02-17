// ga_effectnwn2a
/*This script applies a nwn2 .sef visual effect on the target (sTag)
//This one's for non-creature (ie locations) effects 
//See "ga_effectnwn2" for creature effects
*///by fractal

#include "ginc_param_const"
void main(string sTag, string sEffect)
{
object oTarget = GetTarget(sTag, TARGET_OBJECT_SELF);
location lTarget = GetLocation(oTarget);

ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectNWN2SpecialEffectFile(sEffect, oTarget), lTarget);

}