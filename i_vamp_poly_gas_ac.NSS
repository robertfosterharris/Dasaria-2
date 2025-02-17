// i_vamp_poly_gas_ac

void main()
{
	object oPC = GetItemActivator();
	
	if (GetHasSpellEffect(6666,oPC) || GetIsAreaInterior(GetArea(oPC)))
	{		
		effect ePoly = EffectPolymorph(187,TRUE);
		effect eGhost = EffectCutsceneGhost();
		float fDur = 60.0 * IntToFloat(GetHitDice(oPC));
		ApplyEffectToObject(DURATION_TYPE_TEMPORARY,ePoly,oPC,fDur);
		ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eGhost,oPC,fDur);
	}
	else
	{
		SendMessageToPC(oPC,"A vampire's powers are ineffective beneath the sun.");
	}
}