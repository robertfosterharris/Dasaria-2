
void main()
{
    int nDuration;
    effect eSummon;
    effect eVis;
    location lTarget;
	
	nDuration = GetHitDice(OBJECT_SELF);
	eVis = EffectVisualEffect(VFX_FNF_SUMMON_EPIC_UNDEAD);
    eSummon = EffectSummonCreature("daris_marlee");
	lTarget = GetLocalLocation(OBJECT_SELF, "lDarisMarleeOath");
	DeleteLocalLocation(OBJECT_SELF, "lDarisMarleeOath");
	
    ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, eVis, lTarget);
    ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, eSummon, lTarget, TurnsToSeconds(nDuration));
}