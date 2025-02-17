// This is a wand polymorphs the targeted object into a zombie
void main()
{
	object oPC = GetItemActivator();
	object oTarget = GetItemActivatedTarget();
    effect eVis = EffectVisualEffect( VFX_DUR_POLYMORPH );
    effect ePoly;
    int nPoly = POLYMORPH_TYPE_ZOMBIE;
    int nDuration = 10;
    ePoly = EffectPolymorph(nPoly);
	ePoly = EffectLinkEffects( ePoly, eVis );
	
    //Apply the VFX impact and effects
    AssignCommand(oTarget, ClearAllActions()); // prevents an exploit
    //ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, ePoly, oTarget, TurnsToSeconds(nDuration));	
}