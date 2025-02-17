// i_ear_ring_ac
// wired 04/03/2010

void main()
{
	object oPC = GetItemActivator();
	object oItem = GetItemActivated();
	//SendMessageToPC(oPC,"Running!");
	effect eFirst = GetFirstEffect(oPC);
	effect eVis = SupernaturalEffect(SetEffectSpellId(EffectNWN2SpecialEffectFile(GetResRef(oItem)), -997));
	
	// if we've already got any earring effect
	// treat script as a 'toggle off' 	
	   
   	while (GetIsEffectValid(eFirst))
	{
	   	if (GetEffectSpellId(eFirst) == -997)
		{
			RemoveEffect(oPC, eFirst);
		  	return;
		}
		eFirst = GetNextEffect(oPC);	  
	}	
	ApplyEffectToObject(DURATION_TYPE_PERMANENT, eVis, oPC, 0.0); 
}