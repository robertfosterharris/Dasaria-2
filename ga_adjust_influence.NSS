// ga_adjust_influence( string sTag, int nChange )
// wired 10/28/2008
/* This adjusts the influence rating of an NPC to the PC
   The influence rating is based on a scale between 1 and 100
   sTag defaults to OBJECT_SELF
*/
#include "ginc_influence"
void main( string sTag, int nChange )
{
	object oPC = ( GetPCSpeaker()==OBJECT_INVALID?OBJECT_SELF:GetPCSpeaker() );
	if (sTag == "") sTag = GetTag(OBJECT_SELF);
	d2ChangeInfluence( sTag, nChange, oPC );
}