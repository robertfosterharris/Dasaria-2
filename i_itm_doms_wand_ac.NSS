// i_itm_doms_wand_ac
// faction item for Ordo Magica
//
// submitted by Alterity, May 2010
// wired 6/3/2010

void main()
{
	object oTarget 	= 	GetItemActivatedTarget();
	object oPC		=	GetItemActivator();
	effect eVis 	= 	SetEffectSpellId(EffectVisualEffect(VFX_DUR_SHINING_SHIELD),-44);
	effect eTest;
	int nEffectType = (oPC == oTarget) ? DURATION_TYPE_PERMANENT : DURATION_TYPE_TEMPORARY;
	
	if (GetHasSpellEffect(-44,oTarget))
	{	
	 	eTest = GetFirstEffect(oTarget);
		while(GetIsEffectValid(eTest))
		{
		 	if (GetEffectSpellId(eTest) == -44)
			{
				RemoveEffect(oTarget, eTest);
			}			
			eTest = GetNextEffect(oTarget);  
		}
	 }
	 else
	 {
	 	ApplyEffectToObject(nEffectType,eVis,oTarget,240.0f);
	 }
}