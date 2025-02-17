// get input from text box and execute
void main(string sPolyType)
{
	int	nPoly = StringToInt(sPolyType);	
	object oTarget = GetLocalObject(OBJECT_SELF, "oTarget");
	SendMessageToPC(OBJECT_SELF,"Target Polymorphed to type " + IntToString(nPoly));

	effect eVis = EffectVisualEffect( VFX_DUR_POLYMORPH );
    effect ePoly;
    int nDuration = 10;
    ePoly = EffectPolymorph(nPoly);
	ePoly = EffectLinkEffects( ePoly, eVis );
	
    //Apply the VFX impact and effects
    AssignCommand(oTarget, ClearAllActions()); // prevents an exploit
    //ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, ePoly, oTarget, TurnsToSeconds(nDuration));
}