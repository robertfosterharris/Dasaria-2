// 	wired 02/21/2010
//	temp script, go SRD later
//

#include "x2_inc_switches"

void GenerateWildMagicEffect(object oPC, int nSpellID)
{	
	if (!GetIsSkillSuccessful(oPC,SKILL_SPELLCRAFT,15+GetSpellLevel(nSpellID),TRUE))
	{
		int nWildSpellID	=	Random(1215);
		SendMessageToPC(oPC, "You sense your magic has gone awry somehow" );
		AssignCommand(oPC,ActionCastSpellAtLocation(nWildSpellID,GetSpellTargetLocation(),METAMAGIC_ANY,TRUE));
		SetModuleOverrideSpellScriptFinished();
	}
	// else cast normally
}