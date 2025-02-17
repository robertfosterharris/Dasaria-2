//
//	ON HEARTBEAT - ATTACK NEAREST OBJECT WITH TAG NW_TARGET
//
//	ROBERT HARRIS	04/30/2015	ROBERTHARRIS@ROBERTHARRIS.COM
//
#include "hench_i0_ai"

void main()
{
    if (GetAILevel() != AI_LEVEL_VERY_LOW)
	{
    	if ((IsInConversation(OBJECT_SELF) == FALSE) && (GetIsInCombat(OBJECT_SELF) == FALSE))
    	{
        	ClearAllActions();
        	ActionAttack(GetNearestObjectByTag("NW_TARGET"));
    	}

	    if(GetSpawnInCondition(NW_FLAG_HEARTBEAT_EVENT))
    	{
        	SignalEvent(OBJECT_SELF, EventUserDefined(EVENT_HEARTBEAT));
    	}
	}
}