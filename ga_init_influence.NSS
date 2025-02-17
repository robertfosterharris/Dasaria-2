// gc_init_influence
// This initializes an influence score between PCSpeaker and OWNER
// wired 10/28/2008
#include "ginc_influence"
void main(int nAdjust=0)
{
	object oPC = GetPCSpeaker();
	string sTag = GetTag(OBJECT_SELF);
	d2InitInfluence(sTag, oPC, nAdjust);
}