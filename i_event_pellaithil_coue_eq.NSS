// i_event_pellaithil_coue_eq

void main()
{
    object oPC      = GetPCItemLastEquippedBy();
    object oItem    = GetPCItemLastEquipped();
	effect eDead	= EffectDeath();
	effect eDrain	= EffectNegativeLevel(10);
    effect eVis = EffectVisualEffect(VFX_HIT_SPELL_NECROMANCY);	
	ActionUnequipItem(oItem);
	ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis,oPC);
	ApplyEffectToObject(DURATION_TYPE_INSTANT, eDead,oPC);
	ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eDrain, oPC, HoursToSeconds(20));
	SendMessageToPC(oPC,"<i>FOOLISH MORTAL! DO YOU THINK YOURSELF A GOD?</i>");
}