// Wired 2012/02/11 Stripped down AI for mounts
// heartbeat with special post >> horses will look for wp_hitch
// and move to the nearest one if reasonably close

#include "hench_i0_ai"
#include "std_inc_mounts"

int GetIsMountHitched(object oCreature=OBJECT_SELF)
{
	object oHitch = GetNearestObjectByTag("wp_hitch",oCreature,FALSE);
	float fDist;
	
	if (GetIsObjectValid(oHitch))
	{
		if (bDEBUG_mounts) FloatingTextStringOnCreature("Found a hitch...",oCreature,FALSE,5.0);
	
		fDist = GetDistanceToObject(oHitch);
		
		if (fDist <= 30.0 && fDist != -1.0)
		{
			if (bDEBUG_mounts) FloatingTextStringOnCreature("...and I'm headed over there now.",oCreature,FALSE,5.0);
		   	ActionMoveToObject(oHitch);
	    	//ActionDoCommand(SetFacing(GetFacing(oHitch)));
			return (TRUE);	
		}
		else
		{
			if (bDEBUG_mounts) FloatingTextStringOnCreature("...but it's too far away",oCreature,FALSE,5.0);
		}	
	}
	else
	{
		if (bDEBUG_mounts) FloatingTextStringOnCreature("Found no hitch in this area.",oCreature,FALSE,5.0);
	}
		
	return (FALSE);
}

void main()
{
	// * if not running normal or better Ai then exit for performance reasons
    if (GetAILevel() == AI_LEVEL_VERY_LOW) return;
	
	//if (bDEBUG_mounts) SpeakString("I iz having a hearbeat!");
	
	if (GetIsInCombat(OBJECT_SELF))
	{ 
		HenchDetermineCombatRound();
	}
	else 
	{
		if (!GetIsMountHitched(OBJECT_SELF) && !IsInConversation(OBJECT_SELF)  )
		{	
				if (bDEBUG_mounts) FloatingTextStringOnCreature("I am Parked",OBJECT_SELF,FALSE,5.0);
				
				PlayMobileAmbientAnimations();
		}
	}
}