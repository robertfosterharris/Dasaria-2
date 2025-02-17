/* 	i_ravenswatch_guardsword_hc
	wired 09/20/08
	automate some basic guard functions
	===========

#include "ginc_das_jail"

void main()
{
	object oSpellTarget;
	object oGuard;
	int nLegalStatus;
	
    oSpellTarget = GetSpellTargetObject();
	//SendMessageToPC(GetFirstPC(),"Target is " + GetName(oSpellTarget));  // remove debug
	if (GetIsPC(oSpellTarget))
	{
		// tag PC with warrant and set respawn destination to ravenswatch
		SetLocalString(oSpellTarget,"sDistrict","RW_");
		issueWarrant(oSpellTarget, OBJECT_SELF);
	}
}
*/