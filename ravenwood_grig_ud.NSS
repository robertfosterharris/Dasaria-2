// ravenwood_grig_ud
#include "x0_i0_position"

void DoGrigJump(object oTarget)
{

	PlayCustomAnimation(OBJECT_SELF,"jumpback",0);
	//ActionUseFeat(FEAT_HIDE_IN_PLAIN_SIGHT, OBJECT_SELF);
	
	effect eInvis = EffectInvisibility(INVISIBILITY_TYPE_NORMAL);
	effect eVis = EffectVisualEffect(VFX_HIT_SPELL_TRANSMUTATION);
	ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, OBJECT_SELF);
	ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eInvis, OBJECT_SELF,3.0f);
	location lBehind = GetBehindLocation(oTarget,DISTANCE_SHORT);
	JumpToLocation(lBehind);
	//ActionAttack(oTarget);
}

void main()
{
    int nUser = GetUserDefinedEventNumber();
	object oTarget = GetLastHostileActor(OBJECT_SELF);
	
    if(nUser == EVENT_DAMAGED) // DAMAGED
    {
		//50% jump when hit
		if (d2()==1) DoGrigJump(oTarget);
    }
    else if(nUser == EVENT_END_COMBAT_ROUND)
    {
		// 12.5% at end of combat round
		if (d8()==1) DoGrigJump(oTarget);
	}		
}