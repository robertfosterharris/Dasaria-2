//	ACTION SCRIPT - CAUSE NPC TO CAST INVISIBLITY SPELL AND RUN FOR NEAREST EXIT (WP_EXIT)
//
//	07/21/08	ROBERT HARRIS	ROBERTHARRIS@ROBERTHARRIS.COM
//
#include "ginc_param_const"
#include "ginc_actions"

void main()
{
	object oNPC;
	
	oNPC = GetTarget("$OWNER", TARGET_OWNER);
	AssignCommand(oNPC, ActionCastSpellAtObject(SPELL_INVISIBILITY, oNPC, METAMAGIC_NONE, TRUE, 20, PROJECTILE_PATH_TYPE_DEFAULT, FALSE));
	AssignCommand(oNPC, ActionForceExit("WP_EXIT", TRUE));
}