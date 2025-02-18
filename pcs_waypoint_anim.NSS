#include "ginc_wp"
 
void main()
{
object oTarget;
int iCurrentWP = GetCurrentWaypoint();
int iNextWP;
switch (iCurrentWP)
	{
	case 1 : ActionPlayAnimation(ANIMATION_LOOPING_SIT_CROSS, 1.0, 7.0); break;
	case 2 : ActionPlayAnimation(ANIMATION_LOOPING_GET_LOW, 1.0, 4.0); break;
	case 3 : ActionPlayAnimation(ANIMATION_FIREFORGET_GREETING, 1.0, 4.0); break;
	case 4 : ActionPlayAnimation(ANIMATION_FIREFORGET_PAUSE_BORED, 1.0, 4.0); break;
	case 5 : ActionPlayAnimation(ANIMATION_FIREFORGET_PAUSE_SCRATCH_HEAD, 1.0, 4.0); break;
	case 6 : ActionPlayAnimation(ANIMATION_FIREFORGET_SEARCH, 1.0, 4.0); break;
	case 7 : ActionPlayAnimation(ANIMATION_FIREFORGET_TAUNT, 1.0, 4.0); break;
	case 8 : ActionPlayAnimation(ANIMATION_LOOPING_LISTEN, 1.0, 4.0); break;
	case 9 : ActionPlayAnimation(ANIMATION_LOOPING_LOOK_FAR, 1.0, 4.0); break;
	case 10 : ActionPlayAnimation(ANIMATION_LOOPING_TALK_NORMAL, 1.0, 4.0); break;
	}
	
iNextWP = Random(GetNumWaypoints()-1) + 2;
SetNextWaypoint(iNextWP);
}