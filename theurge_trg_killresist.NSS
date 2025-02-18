void main()
{
	object oPC = GetEnteringObject();
	
	if (!GetIsPC(oPC)) return;
	
	effect eBuff = GetFirstEffect(oPC);
	
    //Search for negative effects
    while(GetIsEffectValid(eBuff))
    {
		if (
		GetEffectSpellId(eBuff)	==	SPELL_RESIST_ENERGY ||
		GetEffectSpellId(eBuff)	==	SPELL_ENERGY_IMMUNITY_COLD //||
		//GetEffectSpellId(eBuff)	==	SPELL_SPELL_RESISTANCE ||
		//GetEffectSpellId(eBuff)	==	SPELL_LEAST_SPELL_MANTLE ||
		//GetEffectSpellId(eBuff)	==	SPELL_LESSER_SPELL_MANTLE||
		//GetEffectSpellId(eBuff)	==	SPELL_SPELL_MANTLE
           )
        {
			RemoveEffect(oPC, eBuff);
			eBuff = GetFirstEffect(oPC);
			SendMessageToPC(oPC,"The chill of ice runs down your spine as your magical wards sputter and fail.");
        }
		else
        	eBuff = GetNextEffect(oPC);
    }
}