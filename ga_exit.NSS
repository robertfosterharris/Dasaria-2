//	ACTION SCRIPT - CAUSE NPC TO FLEE TO EXIT_{NPC TAG}
//
//	05/09/11	ROBERT HARRIS	ROBERTHARRIS@ROBERTHARRIS.COM
//
#include "ginc_param_const"
#include "ginc_actions"

void main(string sTarget = "$OWNER", int bRun = FALSE)
{
	object oNPC;
	
	oNPC = GetTarget(sTarget, TARGET_OWNER);
	AssignCommand(oNPC, ClearAllActions(TRUE));
	AssignCommand(oNPC, ActionForceExit("EXIT_" + GetTag(oNPC), bRun));
}