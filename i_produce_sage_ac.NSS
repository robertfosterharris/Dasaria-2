// i_produce_sage_ac
// 2 points concentration bonus for 60secs

void main()
{
    object oPC      = GetItemActivator();
    object oItem    = GetItemActivated();
    
	effect eConc = EffectSkillIncrease(SKILL_CONCENTRATION, 4);
	ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eConc, oPC, 60.0);
	
}