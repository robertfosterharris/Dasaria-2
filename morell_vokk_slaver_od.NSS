// wired 8/25/09
// run for the hills, torinvhorks!

#include "ginc_actions"
void DoFlee(object oDwarf)
{
	if (GetIsObjectValid(oDwarf))
	{
		SetCreatureScriptsToSet(oDwarf, 0);
		AssignCommand(oDwarf, SpeakString("Huzzah! We're free!"));
		DelayCommand(1.0,AssignCommand(oDwarf, ActionForceExit("WP_EXIT", TRUE)));
		DelayCommand(2.0,SetCommandable(FALSE,oDwarf));
	}
}

void main()
{
	DoFlee(GetNearestObjectByTag("vokk_torinvhork_01"));
	DoFlee(GetNearestObjectByTag("vokk_torinvhork_02"));	
	DoFlee(GetNearestObjectByTag("vokk_torinvhork_04"));	
}