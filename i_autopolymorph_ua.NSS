// i_autopolymorph_ua
// DM Asylum 18 February 2010
void main()
{
    // * This code runs when the item is unacquired
    object oPC      = GetModuleItemLostBy();
    object oItem    = GetModuleItemLost();

 	effect eEffect = GetFirstEffect(oPC);
	while (GetIsEffectValid(eEffect))
	{
		if(GetEffectType(eEffect)==EFFECT_TYPE_POLYMORPH) RemoveEffect(oPC, eEffect);
		eEffect=GetNextEffect(oPC);
	}
}