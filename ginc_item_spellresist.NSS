// ginc_item_spellresist
// spell resistance doesn't work on items, borked by OEI ResistSpell hardcoded function


void ApplyItemSR(int iSpellResistance, object oTarget)
{
	effect eSR = EffectSpellResistanceIncrease(iSpellResistance, -1);
	effect eDur = EffectVisualEffect( VFX_DUR_SPELL_SPELL_RESISTANCE );
	effect eLink = EffectLinkEffects(eSR, eDur);
	
	eSR = SupernaturalEffect(	SetEffectSpellId(eLink,5555)	);
	ApplyEffectToObject(DURATION_TYPE_PERMANENT, eSR, oTarget);
}

void RemoveItemSR(object oTarget)
{
	effect eEffect;
	
	eEffect	= GetFirstEffect(oTarget);
	while (GetIsEffectValid(eEffect))
	{
		if(GetEffectSpellId(eEffect) == 5555)
		{
			RemoveEffect(oTarget, eEffect);
		}
		eEffect = GetNextEffect(oTarget);
	}
}

