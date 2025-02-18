// ga_buy_home
//

#include "ginc_playerhousing"

void main(string sDoorTag, int class)
{
	object oPC = GetPCSpeaker();
	BuyHome(oPC, sDoorTag,class);
}