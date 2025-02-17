// ga_buy_mount

#include "std_inc_mounts"

void main(int nMountType)
{
	object oPC = GetPCSpeaker();
	BuyMount( oPC,nMountType);
}