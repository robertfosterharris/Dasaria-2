#include "rh_giant_boulder_throw"

void catapultThrow(object oUser, object oCat, location lImpact)
{
	effect eImpact	 	= EffectNWN2SpecialEffectFile("fx_wooden_explosion_big");
	effect eQuake		= EffectVisualEffect(VFX_SPELL_HIT_EARTHQUAKE);
	float fTime 	 	= TravelTime(lImpact);
	
	//970
	AssignCommand(oCat,ActionCastFakeSpellAtLocation(1504,lImpact,PROJECTILE_PATH_TYPE_BALLISTIC_THROWN));
	
	AssignCommand(oUser,RockThrow(lImpact));
	
	if (GetActionMode(oUser,ACTION_MODE_STEALTH))
	{
		SetActionMode(oUser,ACTION_MODE_STEALTH,0);
	}

	
	DelayCommand(1.7+fTime,ApplyEffectAtLocation(DURATION_TYPE_INSTANT,eImpact,lImpact));
	DelayCommand(1.7+fTime,ApplyEffectAtLocation(DURATION_TYPE_INSTANT,eQuake,lImpact));
	
	DelayCommand(1.7+fTime,DoPlc(lImpact));
	
	DelayCommand(1.7+fTime,PlaySound("c_stonegolembatt_03"));	

}

void attackWithCatapult(object oTarget)
{
	location lTarget 	= GetLocation(oTarget);
	object oEngine		= GetNearestObjectByTag("lendol_engine");

	if (GetIsObjectValid(oEngine))
	{
		ActionMoveToObject(oEngine,TRUE);		
		catapultThrow(OBJECT_SELF,oEngine,lTarget);
	}
	else
	{
		ActionAttack(oTarget);
	}
}