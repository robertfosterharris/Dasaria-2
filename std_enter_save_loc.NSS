// ph_showroom_enter
// wired 03/21/2011
//

#include "x0_i0_position"
#include "std_inc_mounts"

void main()
{
	object oPC = GetClickingObject();
	object oTarget = GetTransitionTarget(OBJECT_SELF);
	
	// block mounted transition into interior areas unless so marked
	if (!GetCanTransition(oPC, GetArea(oTarget))) return;		
	
	location lReturnTo = CalcSafeLocation(oPC,GetOppositeLocation(oPC,0.1),1.0f,TRUE,FALSE);
	SetLocalLocation(oPC,"lReturnTo",lReturnTo);
	AssignCommand(oPC, JumpToObject(oTarget));
}