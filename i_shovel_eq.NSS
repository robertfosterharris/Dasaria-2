// i_shovel_eq
void main()
{
	object oPC = GetPCItemLastEquippedBy();
   	effect eProp = SupernaturalEffect(SetEffectSpellId(EffectNWN2SpecialEffectFile("fx_hss_shovel"), -899));
   	ApplyEffectToObject(DURATION_TYPE_PERMANENT, eProp, oPC);
}
   
   
   