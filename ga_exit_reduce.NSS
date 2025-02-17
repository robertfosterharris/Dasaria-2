void main()
{

object oTarget=GetExitingObject();

{
	 (GetLocalInt(oTarget, "pcshrunk") == 1);
	
		effect eff = GetFirstEffect(oTarget);
	    while (GetIsEffectValid(eff))
	    {
	    	if(GetEffectSpellId(eff) == -1066)
	        {
	        	RemoveEffect(oTarget, eff);
	 		}
	         eff=GetNextEffect(oTarget);
		}
		SetMovementRateFactor(oTarget, 1.00f);
		DeleteLocalInt(oTarget, "pcshrunk");
}
}