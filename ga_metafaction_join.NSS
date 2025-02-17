// ga_join_metafaction

#include "ginc_renown"

void main(int nMetaFac)
{
	object oPC = GetPCSpeaker();
	setMetaFaction(oPC, nMetaFac);
}