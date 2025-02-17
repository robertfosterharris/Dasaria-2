void main()
{
    object oTarget = GetItemActivator();

	int nRegenAmt = GetMaxHitPoints(oTarget) / 10;
    if ( nRegenAmt < 1 ) nRegenAmt = 1;

    float fDuration = RoundsToSeconds(15);
    effect eRegen = EffectRegenerate(nRegenAmt, 6.0);
    effect eVis = EffectVisualEffect(VFX_IMP_HEALING_G);
    effect eDur = EffectVisualEffect(VFX_DUR_REGENERATE);
    effect eLink = EffectLinkEffects(eRegen, eDur);
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, fDuration);
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
	
	effect eAbilityDecrease = EffectAbilityDecrease(ABILITY_DEXTERITY, 2);
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eAbilityDecrease, oTarget, fDuration);
	
	SendMessageToPC(oTarget, "As you drain the vial of its contents, you immediately feel a surge of energy through your body.  You blood feels like it boils, and your joints, strangely, seem stiff and rigid.");
}