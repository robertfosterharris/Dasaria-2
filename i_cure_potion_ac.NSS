//  i_cure_potion_ac
//
//  ITEM ON ACTIVATE SCRIPT - APPLIES REGENERATION EFFECT ON POTION USE
//
//  RFH     05/23/2007      MADE EFFECT SUPERNATURAL SO IT CAN NOT BE DISPELLED
//
void main()
{
	effect eDur;
	effect eLink;
	effect ePCEffect;
	effect eRegen;
	effect eVis;
	float fDuration;
	int bRegenerating;
	int iHealRate;
	object oItem;
	object oPC;
	string sResRef;

	oItem = GetItemActivated();
	oPC = GetItemActivator();
	sResRef = GetResRef(oItem);
	
	ePCEffect = GetFirstEffect(oPC);
	while (GetIsEffectValid(ePCEffect) && (GetEffectType(ePCEffect) != EFFECT_TYPE_REGENERATE))
	{
			ePCEffect = GetNextEffect(oPC);
	}

	if (GetEffectType(ePCEffect) == EFFECT_TYPE_REGENERATE)
	{
		FloatingTextStringOnCreature("One of your effects renders the potion ineffective.", oPC);
	}
	else
	{
		//standard cure moderate potion cures 19hp, so let's round it to 20.
		// we can have three tiers of potions:
		// 1. Short timer, faster healing.
		//		4 rounds, 5 hp/round
		// 2. Medium timer, medium healing.
		//		10 rounds, 2 hp/round
		// 3. Long timer, slower healing.
		//		20 rounds, 1 hp/round
		if (sResRef == "cure_potion_light2_10")		//{10 Stack}Elixir of Light Healing (II)
		{
			fDuration = RoundsToSeconds(10);
			iHealRate = 1;
		}
		if (sResRef == "cure_potion_light3_10")		//{10 Stack}Elixir of Light Healing (III)
		{
			fDuration = RoundsToSeconds(5);
			iHealRate = 2;
		}
		if (sResRef == "cure_potion_mod1_10")		//{10 Stack}Elixir of Moderate Healing (I)
		{
			fDuration = RoundsToSeconds(20);
			iHealRate = 1;
		}
		if (sResRef == "cure_potion_mod2_10")		//{10 Stack}Elixir of Moderate Healing (II)
		{
			fDuration = RoundsToSeconds(10);
			iHealRate = 2;
		}
		if (sResRef == "cure_potion_mod3_10")		//{10 Stack}Elixir of Moderate Healing (III)
		{
			fDuration = RoundsToSeconds(5);
			iHealRate = 4;
		}
		if (sResRef == "cure_potion_serious2_10")	//{10 Stack}Elixir of Serious Healing (II)
		{
			fDuration = RoundsToSeconds(10);
			iHealRate = 3;
		}
		if (sResRef == "cure_potion_serious3_10")	//{10 Stack}Elixir of Serious Healing (III)
		{
			fDuration = RoundsToSeconds(5);
			iHealRate = 6;
		}
		if (sResRef == "cure_potion_crit1_10")		//{10 Stack}Elixir of Critical Healing (I)
		{
			fDuration = RoundsToSeconds(20);
			iHealRate = 2;
		}
		if (sResRef == "cure_potion_crit2_10")		//{10 Stack}Elixir of Critical Healing (II)
		{
			fDuration = RoundsToSeconds(10);
			iHealRate = 4;
		}
		if (sResRef == "cure_potion_crit3_10")		//{10 Stack}Elixir of Critical Healing (III)
		{
			fDuration = RoundsToSeconds(5);
			iHealRate = 8;
		}

		eRegen = EffectRegenerate(iHealRate, RoundsToSeconds(1));
	    eVis = EffectVisualEffect(VFX_IMP_HEALING_G);
	    eDur = EffectVisualEffect(VFX_DUR_REGENERATE);
	    eLink = SupernaturalEffect(EffectLinkEffects(eRegen, eDur));
		
		ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oPC, (fDuration + 1.0));  // +1 is because the effect was expiring before the last heal effect was being applied.
    	ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oPC);
	}		
}