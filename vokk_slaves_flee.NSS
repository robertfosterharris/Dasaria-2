//	ACTION SCRIPT - CAUSE NEARBY NPC TO RUN FOR NEAREST EXIT (WP_EXIT)
//
//	08/07/08	ROBERT HARRIS	ROBERTHARRIS@ROBERTHARRIS.COM
//
#include "ginc_param_const"
#include "ginc_actions"

void main()
{
	location lPC;
	object oNPC;
	object oPC;
	
	oPC = (GetPCSpeaker()==OBJECT_INVALID?OBJECT_SELF:GetPCSpeaker());
	lPC = GetLocation(oPC);

	oNPC = GetFirstObjectInShape(SHAPE_SPHERE, 30.0, lPC);
	while (GetIsObjectValid(oNPC))
	{
		if (GetSubString(GetTag(oNPC), 0, 5) == "vokk_")
		{
			SetCreatureScriptsToSet(oNPC, 0);
			AssignCommand(oNPC, ActionForceExit("WP_EXIT", TRUE));
		}			
		oNPC = GetNextObjectInShape(SHAPE_SPHERE, 30.0, lPC);
	}
}