// gc_influence( string sTag, string sCheck )
// wired 10/28/2008
/* This checks the influence rating between the NPC and PC, comparing it with sCheck.
   
   Parameters:
     string sTag  = Tage of the NPC (defaults to OBJECT_SELF)
     string sCheck   = The operation to check on the influence rating.
	                   You can specify =, <, >, or !
					   e.g. sCheck of "=50" returns TRUE if influence is equal to 50.
					   sCheck of "<-80" returns TRUE if influence is less than -80.
					   sCheck of "!0" returns TRUE if influence is not equal to 0.
*/
#include "ginc_influence"
#include "ginc_var_ops"

int StartingConditional( string sTag, string sCheck )
{
	object oPC = GetPCSpeaker();
	if (sTag == "") sTag = GetTag(OBJECT_SELF);
	int nInfluence = d2GetInfluence( sTag, oPC );
	int nRet = CompareInts( nInfluence, sCheck );
	return ( nRet );
}