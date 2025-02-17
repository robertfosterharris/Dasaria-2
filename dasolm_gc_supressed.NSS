
int StartingConditional(int bVal)
{
	object oPC = GetPCSpeaker();
	object oArea = GetArea(oPC);
	if  ( GetLocalInt(oArea,"bSupress") == bVal) return TRUE;
	else return FALSE;
}