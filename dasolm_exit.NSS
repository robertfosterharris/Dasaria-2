/*
Removes OL GUI from client
*/
#include "dasolm_inc"

void main()
{
	object oPC = GetExitingObject();
	DasOL_Exit(oPC);
}