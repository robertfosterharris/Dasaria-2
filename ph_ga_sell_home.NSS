// ga_sell_home
//
#include "ginc_playerhousing"

void main(string sDoorTag)
{
	object oPC = GetPCSpeaker();
	SellHome(oPC,sDoorTag);
}