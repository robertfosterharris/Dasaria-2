// i_faction_om_item_ac
// faction item for Ordo Magica
//
// submitted by Alterity, May 2010
// wired 6/3/2010

void main()
{
	object oTarget 	= 	GetItemActivatedTarget();
	object oPC		=	GetItemActivator();
	effect eVis 	= 	SetEffectSpellId(EffectVisualEffect(VFX_DUR_WAUKEEN_HALO),-43);
	effect eTest;
	int nEffectType = (oPC == oTarget) ? DURATION_TYPE_PERMANENT : DURATION_TYPE_TEMPORARY;
	
	if (GetHasSpellEffect(-43,oTarget))
	{	
	 	eTest = GetFirstEffect(oTarget);
		while(GetIsEffectValid(eTest))
		{
		 	if (GetEffectSpellId(eTest) == -43)
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