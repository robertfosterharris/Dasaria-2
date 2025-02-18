#include "ginc_playerhousing"

void main(string sToken)
{
	object oPC = GetPCSpeaker();
	object oOwner = GetLocalObject(OBJECT_SELF,sToken);
	
	RingOwner(oOwner, oPC);
}