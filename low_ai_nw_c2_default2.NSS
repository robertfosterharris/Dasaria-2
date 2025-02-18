// Wired 2011/07/19 Stripped down AI for commoners, domestic animals and such
// perception
//
#include "hench_i0_ai"
#include "ginc_behavior"


void main()
{
    // * if not running normal or better Ai then exit for performance reasons
    if (GetAILevel() == AI_LEVEL_VERY_LOW) return;

    // script hidden object shouldn't react (for cases where AI not turned off)
    if (GetScriptHidden(OBJECT_SELF)) return;

    int iFocused = GetIsFocused();

    object oLastPerceived = GetLastPerceived();
    int bSeen = GetLastPerceptionSeen();
    
	if (iFocused <= FOCUSED_STANDARD)
    {
        //Do not bother checking the last target seen if already fighting
		if (bSeen && !GetIsObjectValid(GetAttemptedAttackTarget()) && !GetIsObjectValid(GetAttemptedSpellTarget()))
        {
            // activate ambient animations or walk waypoints if appropriate
            if (!IsInConversation(OBJECT_SELF))
            {
                if (GetIsPC(oLastPerceived))  
                {
                    SetAnimationCondition(NW_ANIM_FLAG_IS_ACTIVE);
                }
            }
        }
    }
}