// ginc_effect_util

// remove all effects that no longer have a valid creator
void RemoveOrphanedEffects( object oTarget )
{
	int bRemove = FALSE;
	effect eEffect = GetFirstEffect(oTarget);
	while ( GetIsEffectValid(eEffect) && GetEffectType (eEffect) != EFFECT_TYPE_BARDSONG_SINGING )
	{
		int bRestart = FALSE;
		if ( !GetIsObjectValid( GetEffectCreator(eEffect) ) )
		{
			RemoveEffect(oTarget, eEffect);
			bRemove = TRUE;
			bRestart = TRUE;
		}
		if (bRestart)
		{
			eEffect = GetFirstEffect(oTarget);
		}
		else
		{
			eEffect = GetNextEffect(oTarget);
		}
	}
}