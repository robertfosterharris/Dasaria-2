#include "ginc_debug"

void main()
{
	object oUser = GetLastUsedBy();

	GiveXPToCreature(oUser, 100);
}