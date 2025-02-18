// wired 09/18/08
#include "ginc_actions"
void main()
{
	// run, timmy, run!
	object oStudent1 = GetNearestObjectByTag("unseen_honors_student_01");
	object oStudent2 = GetNearestObjectByTag("unseen_honors_student_02");
	object oStudent3 = GetNearestObjectByTag("unseen_honors_student_03");
	object oStudent4 = GetNearestObjectByTag("unseen_honors_student_04");
	
	SetCreatureScriptsToSet(oStudent1, 0);
	AssignCommand(oStudent1, ActionForceExit("WP_EXIT", TRUE));
	SetCreatureScriptsToSet(oStudent2, 0);
	AssignCommand(oStudent2, ActionForceExit("WP_EXIT", TRUE));
	SetCreatureScriptsToSet(oStudent3, 0);
	AssignCommand(oStudent3, ActionForceExit("WP_EXIT", TRUE));
	SetCreatureScriptsToSet(oStudent4, 0);
	AssignCommand(oStudent4, ActionForceExit("WP_EXIT", TRUE));
}