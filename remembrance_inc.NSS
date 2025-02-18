void ApplyEffects (object oPC, object oMemory);
void RecallMemory (object oPC, object oMemory);
void SetMemoryName(object oPC, object oMemory);

void RecallMemory (object oPC, object oMemory)
{
	int nCharges;
	
	nCharges = GetItemCharges(oMemory);
	if (nCharges > 1)
	{
		ApplyEffects(oPC, oMemory);
		SetMemoryName(oPC, oMemory);
		SetItemCharges(oMemory, nCharges-1);
	}
	else
	{
		SendMessageToPC(oPC, "Recalling the old man no longer affects you as it once did.  That lonely old man at the Buck Inn has become just another faded memory.");
		SetItemCharges(oMemory, 0);
	}		
}
void SetMemoryName(object oPC, object oMemory)
{
	int nMemoryAlignment;
	int nPCAlignment;
	string sMemoryTag;
	
	nPCAlignment = GetAlignmentGoodEvil(oPC);
	sMemoryTag = GetTag(oMemory);
	
	if (sMemoryTag == "remembrance_memory_good") nMemoryAlignment = ALIGNMENT_GOOD;
	if (sMemoryTag == "remembrance_memory_neutral") nMemoryAlignment = ALIGNMENT_NEUTRAL;
	if (sMemoryTag == "remembrance_memory_evil") nMemoryAlignment = ALIGNMENT_EVIL;
	if (nPCAlignment == nMemoryAlignment)
	{
		SetFirstName(oMemory, "A Fond Memory");
	}
	else
	{
		SetFirstName(oMemory, "A Disturbing Memory");
	}
}

void ApplyEffects (object oPC, object oMemory)
{
	effect eEffect;
	effect ePositiveAttack1;
	effect ePositiveAttack2;
	effect ePositiveSave1;
	effect ePositiveSave2;
	effect eVisual;
	int bPositiveEffect;
	int nOpposedAlignment1;
	int nOpposedAlignment2;
	int nPCAlignment;
	int nShiftDirection;
	string sMemoryMessage;
	string sMemoryName;
	string sMemoryTag;
	
	bPositiveEffect = FALSE;
	nPCAlignment = GetAlignmentGoodEvil(oPC);
	sMemoryTag = GetTag(oMemory);
		
	if (sMemoryTag == "remembrance_memory_good")
	{
		nShiftDirection = ALIGNMENT_GOOD;
		nOpposedAlignment1 = ALIGNMENT_EVIL;
		nOpposedAlignment2 = ALIGNMENT_NEUTRAL;

		switch (nPCAlignment)
		{
			case ALIGNMENT_GOOD:
				sMemoryMessage = "You recall fondly the kindness you showed the lonely old man at the Buck Inn.  Kindness unites others, making the world a better place. The memory inspires you.";
				bPositiveEffect = TRUE;
				break;
			case ALIGNMENT_NEUTRAL:
				sMemoryMessage = "You recall the kindness you showed the old man at the Buck Inn.  Others, especially strangers, may take advantage of your kindness.  The memory leaves you feeling uncertain.";
				break;
			case ALIGNMENT_EVIL:
				sMemoryMessage = "You are haunted by the memory of the kindness you showed that miserable old man at the Buck Inn.  Kindness is a weakness that others will exploit.  The memory disturbes you.";
				break;
		}
	}
	
	if (sMemoryTag == "remembrance_memory_neutral")
	{
		if (nPCAlignment == ALIGNMENT_GOOD) nShiftDirection = ALIGNMENT_EVIL;
		if (nPCAlignment == ALIGNMENT_EVIL) nShiftDirection = ALIGNMENT_GOOD;

		nOpposedAlignment1 = ALIGNMENT_GOOD;
		nOpposedAlignment2 = ALIGNMENT_EVIL;

		switch (nPCAlignment)
		{
			case ALIGNMENT_GOOD:
				sMemoryMessage = "You recall the civility you showed the lonely old man at the Buck Inn.  You can't help but think you could have done more for him.  The memory leaves you feeling uncertain.";
			case ALIGNMENT_NEUTRAL:
				sMemoryMessage = "You recall the civility you showed the lonely old man at the Buck Inn.  All people should be treated fairly.  The memory inspires you.";
				bPositiveEffect = TRUE;
				break;
			case ALIGNMENT_EVIL:
				sMemoryMessage = "You recall the civility you showed the lonely old man at the Buck Inn.  Show too much kindness and others may think you are weak.  The memory leaves you feeling uncertain.";
				break;
		}
	}

	if (sMemoryTag == "remembrance_memory_evil")
	{
		nShiftDirection = ALIGNMENT_EVIL;
		nOpposedAlignment1 = ALIGNMENT_GOOD;
		nOpposedAlignment2 = ALIGNMENT_NEUTRAL;
		
		switch (nPCAlignment)
		{
			case ALIGNMENT_GOOD:
				sMemoryMessage = "You are haunted by the memory of the cruelty you showed the lonely old man at the Buck Inn.  Cruelty turns people against eachother, making the world a miserable place.  The memory disturbes you.";
				break;
			case ALIGNMENT_NEUTRAL:
				sMemoryMessage = "You recall the cruelty you showed the old man at the Buck Inn.  Acting too cruel could leave you without allies.  The memory leaves you feeling uncertain.";
				break;
			case ALIGNMENT_EVIL:
				sMemoryMessage = "You recall fondly the cruelty you showed that miserable old man at the Buck Inn.  Dominion over others is power.  The memory inspires you.";
				bPositiveEffect = TRUE;
				break;
		}
	}
	
	if (bPositiveEffect)
	{
		ePositiveAttack1 = EffectAttackIncrease(1);
		ePositiveAttack2 = EffectAttackIncrease(1);
		ePositiveAttack1 = VersusAlignmentEffect(ePositiveAttack1, ALIGNMENT_ALL, nOpposedAlignment1);
		ePositiveAttack2 = VersusAlignmentEffect(ePositiveAttack2, ALIGNMENT_ALL, nOpposedAlignment2);

		ePositiveSave1 = EffectSavingThrowIncrease(SAVING_THROW_ALL, 1);
		ePositiveSave2 = EffectSavingThrowIncrease(SAVING_THROW_ALL, 1);
		ePositiveSave1 = VersusAlignmentEffect(ePositiveSave1, ALIGNMENT_ALL, nOpposedAlignment1);
		ePositiveSave2 = VersusAlignmentEffect(ePositiveSave2, ALIGNMENT_ALL, nOpposedAlignment2);

	    eEffect = EffectLinkEffects(ePositiveAttack1, ePositiveAttack2);
    	eEffect = EffectLinkEffects(eEffect, ePositiveSave1);
		eEffect = EffectLinkEffects(eEffect, ePositiveSave2);
		
		eVisual = EffectVisualEffect(VFX_IMP_IMPROVE_ABILITY_SCORE);
	}
	else
	{
		eEffect = EffectSavingThrowDecrease(SAVING_THROW_ALL, 1);
		eVisual = EffectVisualEffect(VFX_IMP_REDUCE_ABILITY_SCORE);
	}
	
	SetMemoryName(oPC, oMemory);			
	ApplyEffectToObject(DURATION_TYPE_PERMANENT, eEffect, oPC);
	ApplyEffectToObject(DURATION_TYPE_INSTANT, eVisual, oPC);
	SendMessageToPC(oPC, sMemoryMessage);
	if (nShiftDirection > 0) AdjustAlignment(oPC, nShiftDirection, 1);
}