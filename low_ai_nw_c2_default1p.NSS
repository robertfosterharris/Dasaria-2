// Wired 2011/07/19 Stripped down AI for commoners, domestic animals and such
// heartbeat with post

#include "hench_i0_ai"

void main()
{
	// * if not running normal or better Ai then exit for performance reasons
    if (GetAILevel() == AI_LEVEL_VERY_LOW) return;
	
	if (GetIsInCombat(OBJECT_SELF))
	{ 
		HenchDetermineCombatRound();
	}
	else 
	{
		if (!GetIsPosted(OBJECT_SELF) && !IsInConversation(OBJECT_SELF)  )
		{	
				PlayImmobileAmbientAnimations();
		}
	}
}