// i_produce_fenn

#include "ginc_statbuff"

void main()
{
    object oTarget      = GetItemActivatedTarget();
	int iStatToBuff		= ABILITY_DEXTERITY;
	int iStatModifier 	= 2;
	float fDuration 	= 60.0;
	int nDurType		= DURATION_TYPE_TEMPORARY;
    
	StatBuff(oTarget,iStatToBuff,iStatModifier,fDuration,nDurType);
}