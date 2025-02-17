void main()
{

object oTarget=GetEnteringObject();


	{
		ApplyEffectToObject(DURATION_TYPE_PERMANENT, SetEffectSpellId(SupernaturalEffect(EffectSetScale(0.5, 0.5, 0.5)),-1066),oTarget);
		SetMovementRateFactor(oTarget, 0.6f);
		SetLocalInt(oTarget, "pcshrunk", 1); 
		}
}