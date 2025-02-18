//std_trg_blindness_exit


void main()
{
	object oPC = GetExitingObject();
	if (!GetIsPC(oPC)) return;
	
	effect eTest;
	
	if (GetHasSpellEffect(-4444,oPC))
	{	
	 	eTest = GetFirstEffect(oPC);
		while(GetIsEffectValid(eTest))
		{
		 	if (GetEffectSpellId(eTest) == -4444)
			{
				RemoveEffect(oPC, eTest);
			}			
			eTest = GetNextEffect(oPC);  
		}
	 }
}