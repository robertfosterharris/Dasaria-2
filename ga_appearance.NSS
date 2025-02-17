// ga_appearance
/*This script changes the designated creature (sTag) appearance according to 2da #.
*///by fractal

#include "ginc_param_const"
void main(string sTag, int nApp)
{
object oTarget = GetTarget(sTag, TARGET_OBJECT_SELF);
SetCreatureAppearanceType(oTarget, nApp);
}