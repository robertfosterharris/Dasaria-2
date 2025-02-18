void main()
{

object oPC = GetPCSpeaker();

object oTarget;
oTarget = OBJECT_SELF;

effect eEffect;
eEffect = EffectPolymorph(POLYMORPH_TYPE_ZOMBIE);

eEffect = SupernaturalEffect(eEffect);

ApplyEffectToObject(DURATION_TYPE_PERMANENT, eEffect, oTarget);

}