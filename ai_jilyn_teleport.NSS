
//:://////////////////////////////////////////////
//:: Created By:  RW
//:: Created On:  March 2011
//:: Based on nw_c2_dimdoor
//:://////////////////////////////////////////////

#include "x0_i0_position"

void JumpToWeakestEnemy_JiLyn(object oJiLyn, object oTarget, string sWhereTo)
{

	
	

	effect ePortOut  = EffectVisualEffect(VFX_FNF_IMPLOSION);
	effect ePortIn1 = EffectVisualEffect(VFX_FNF_SUMMON_MONSTER_1);
	effect ePortIn2 = EffectVisualEffect(VFX_IMP_FLAME_M);
	effect ePortIn = EffectLinkEffects(ePortIn1, ePortIn2 );
	effect eInvis = EffectInvisibility(INVISIBILITY_TYPE_NORMAL);
	
	if(sWhereTo=="weakenemy")
	{
		object oCurrentTarget = oTarget;
	    object oTargetVictim = GetFactionMostDamagedMember(oTarget);
		location lBehind = GetBehindLocation(oTarget,DISTANCE_SHORT);

		if(oCurrentTarget != oTargetVictim)
		{
		    AssignCommand(oJiLyn , ClearAllActions());
	        DelayCommand(0.1, ApplyEffectToObject(DURATION_TYPE_INSTANT, ePortOut, oJiLyn));
			ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eInvis, OBJECT_SELF,3.0f);
	        DelayCommand(0.2, AssignCommand(oJiLyn, JumpToLocation(lBehind)));
			DelayCommand(0.3, ApplyEffectToObject(DURATION_TYPE_INSTANT, ePortIn, oJiLyn, 0.0));
			DelayCommand(0.4,ActionAttack(oTargetVictim));
		}
	    
	}
	
		if(sWhereTo=="Limbo")
	{
			AssignCommand(oJiLyn , ClearAllActions());
	        ApplyEffectToObject(DURATION_TYPE_INSTANT, ePortOut, oJiLyn);
			DelayCommand(0.1, SendCreatureToLimbo(oJiLyn));
	    
	}
	
	
}
void main()
{
	object oJiLyn = OBJECT_SELF;

	string sWhereTo;
	float fHP;
	
    // * During Combat try teleporting around
    if (GetUserDefinedEventNumber() == 1003)
    {
        // * if random OR heavily wounded then teleport to next enemy
		fHP = ( ( 100.00 / IntToFloat(GetMaxHitPoints(oJiLyn)) ) * IntToFloat(GetCurrentHitPoints(oJiLyn)));

		if(fHP < 50.00)
		{
			if(Random(100) <= 65)
			{
				JumpToWeakestEnemy_JiLyn(oJiLyn , GetNearestCreature(CREATURE_TYPE_REPUTATION, REPUTATION_TYPE_ENEMY), "Limbo");
				return;
			}
		}
        else if ((Random(100) < 85))  
        {
		
           	JumpToWeakestEnemy_JiLyn(oJiLyn , GetNearestCreature(CREATURE_TYPE_REPUTATION, REPUTATION_TYPE_ENEMY), "weakenemy");
       		return; 
		 }
		
    }
}