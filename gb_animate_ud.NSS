//	ON USER DEFINED - 	PERCEPTION SCRIPT
//						WE HAVE PERCEIVED A PC WHO IS NOT OUR ENEMY
//						WE ARE NOT IN COMBAT OR IN CONVERSATION
//
//						PLAY ANIMATION
//
//	SEE GB_ANIMATE_SP
//
//	07/30/08	ROBERT HARRIS	ROBERTHARRIS@ROBERTHARRIS.COM

#include "x0_i0_anims"
void main()
{
	object oObject;

	oObject = GetLastPerceived();

	if (GetUserDefinedEventNumber() == EVENT_PERCEIVE && GetIsPC(oObject) && !GetIsEnemy(oObject) && !GetIsInCombat(OBJECT_SELF) && !IsInConversation(OBJECT_SELF))
	{
		SetAnimationCondition(NW_ANIM_FLAG_IS_ACTIVE, TRUE);
		PlayCustomAnimation(OBJECT_SELF, GetLocalString(OBJECT_SELF, "sAnimation"), 1);
	}
}