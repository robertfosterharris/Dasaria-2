// ph_ga_plc_move
// wired 04/30/2010
//
// iType			
// 1=forward		
// 2=back			
// 3=left
// 4=right
// 5=up/down


#include "ginc_playerhousing"

void main(int iType, float fDist = 1.0f )
{

	object oTarget = OBJECT_SELF;
	object oPC = GetPCSpeaker();
	MoveDecor(oTarget, oPC, iType, fDist);
}