// i_giant_boulderproxy_hc
// wired 09/18/2004
// boulder smash effect from a thrown weapon
void main()
{
	location lImpact = GetSpellTargetLocation();
	object oTarget = GetFirstObjectInShape( SHAPE_SPHERE, RADIUS_SIZE_SMALL, lImpact, TRUE, OBJECT_TYPE_CREATURE);
	effect eImpact	 = EffectNWN2SpecialEffectFile ("fx_wooden_explosion_big");
	effect eRock	 = EffectNWN2SpecialEffectFile("boulder_toss_a.sef");	
	effect eQuake	= EffectVisualEffect(VFX_SPELL_HIT_EARTHQUAKE);
	int iAttackMod 	= GetAbilityModifier (ABILITY_STRENGTH);	
	int iDamageAmount	= d6(2)+iAttackMod; //Base Damage for boulders	
	int nRand = Random(3);
	effect eDamage		= EffectDamage( iDamageAmount, DAMAGE_TYPE_BLUDGEONING, DAMAGE_POWER_NORMAL);
	string sPlc = "plc_nt_rocks12";
	int iDamage = GetReflexAdjustedDamage (iDamageAmount, oTarget, 18, SAVING_THROW_TYPE_NONE, OBJECT_SELF);
	eDamage = EffectDamage (iDamage, DAMAGE_TYPE_BLUDGEONING, DAMAGE_POWER_NORMAL);

	object oPlc;
		
	ApplyEffectAtLocation (DURATION_TYPE_INSTANT, eImpact, lImpact);
	ApplyEffectAtLocation (DURATION_TYPE_INSTANT, eQuake, lImpact);	
	
	while (GetIsObjectValid (oTarget))
	{		
		ApplyEffectToObject (DURATION_TYPE_INSTANT, eDamage,oTarget);
		PlayCustomAnimation (oTarget, "*damage01",0,1.0);
		PlayVoiceChat (VOICE_CHAT_PAIN1,oTarget);
		oTarget = GetNextObjectInShape (SHAPE_SPHERE, RADIUS_SIZE_SMALL, lImpact, TRUE, OBJECT_TYPE_CREATURE);
	}
	oPlc = CreateObject(OBJECT_TYPE_PLACEABLE, sPlc, lImpact, FALSE);
	AssignCommand(oPlc,DestroyObject(OBJECT_SELF,10.0f));
}