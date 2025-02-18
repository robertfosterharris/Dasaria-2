
//Shit pool script!
void main()
{

object oPC = GetPCSpeaker();

FloatingTextStringOnCreature("What's wrong with you!? You just plunged head first into a pool of excrement! Honestly.", oPC);

object oTarget;
oTarget = oPC;

effect eEffect;
eEffect = EffectDisease(DISEASE_BLINDING_SICKNESS);

ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eEffect, oTarget, 60.0f);

eEffect = EffectAbilityDecrease(ABILITY_CHARISMA, 4);

ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eEffect, oTarget, 60.0f);

}