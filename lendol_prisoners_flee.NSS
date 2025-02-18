// wired 09/18/08
#include "ginc_actions"
void main()
{
	//run!
	object oPrisoner1 = GetNearestObjectByTag("lndol_Prisoner_01");
	object oPrisoner2 = GetNearestObjectByTag("lndol_Prisoner_02");
	object oPrisoner3 = GetNearestObjectByTag("lndol_Prisoner_03");
	object oPrisoner4 = GetNearestObjectByTag("lndol_Prisoner_04");
	
	SetCreatureScriptsToSet(oPrisoner1, 0);
	AssignCommand(oPrisoner1, ActionForceExit("WP_EXIT", TRUE));
	SetCreatureScriptsToSet(oPrisoner2, 0);
	AssignCommand(oPrisoner2, ActionForceExit("WP_EXIT", TRUE));
	SetCreatureScriptsToSet(oPrisoner3, 0);
	AssignCommand(oPrisoner3, ActionForceExit("WP_EXIT", TRUE));
	SetCreatureScriptsToSet(oPrisoner4, 0);
	AssignCommand(oPrisoner4, ActionForceExit("WP_EXIT", TRUE));
}