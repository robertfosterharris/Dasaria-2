// ph_ga_plc_rotate

#include "ginc_playerhousing"
#include "d2_sql"


void main(float fDist)
{	
	object oPC = GetPCSpeaker();
	object oPlc = OBJECT_SELF;
	
	RotateDecor(oPC,oPlc,fDist);
	
}