//
// SGK 2007/08/05
//
// Based on a script found on the forum.
//
void main()
{
	object oPC = GetExitingObject();
	
	float fMoveRate = GetLocalFloat(GetArea(oPC),"MoveRate");
	if (fMoveRate == 0.0) { fMoveRate = 1.0; }
	SetMovementRateFactor(oPC, fMoveRate);
}