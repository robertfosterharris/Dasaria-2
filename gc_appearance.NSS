// gc_appearance
/*This script checks for the 2da appearance # of the designated creature (sTag)
If the creature's appearance equals nApp (your input), returns TRUE
*///by fractal

#include "ginc_param_const"
int StartingConditional(int nApp, string sTarget)
{
object oTarget = GetTarget(sTarget, TARGET_OBJECT_SELF);
int nAppear = GetAppearanceType(oTarget);

if (nApp == nAppear)
{ return TRUE; }
return FALSE;
}