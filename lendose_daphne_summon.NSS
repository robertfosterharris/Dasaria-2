// wired 02/27/2010

#include "x0_i0_position"

void main()
{
	 object oPC = GetPCSpeaker();
	// 360 degree approach on this tree, i want her to pop up in front of the pc
	//location lSafeFacingLoc = CalcSafeLocation( oPC, GetOppositeLocation(oPC,DISTANCE_TINY), 1.0, TRUE, FALSE );	
	CreateObject(OBJECT_TYPE_CREATURE, "lendose_tyrak_dryad", GetOppositeLocation(oPC,DISTANCE_TINY), TRUE);
}