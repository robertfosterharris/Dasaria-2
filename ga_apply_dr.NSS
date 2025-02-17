// ga_apply_dr
// wired 05/11/09
// this should be standard in ga_effect but its not

// Cold Iron = 10,2,0,4

void main(int nAmount = 10, int nGMATERIAL = GMATERIAL_METAL_ADAMANTINE, int nLimit = 0, int nDRType = DR_TYPE_GMATERIAL )
{
	effect eDR = EffectDamageReduction(nAmount, nGMATERIAL, nLimit, nDRType);
	ApplyEffectToObject(DURATION_TYPE_PERMANENT,eDR,OBJECT_SELF);

}