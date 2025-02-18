// ga_decor_pack
// pack it up!

#include "ginc_playerhousing"

void main()
{
	object oPC = GetPCSpeaker();
	object oDecor = OBJECT_SELF;
	PackDecor(oPC,oDecor);
}