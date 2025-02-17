//default PC MovementRateFactor is 1.0
void main()
{
	object oPC = GetEnteringObject();
	
	if (GetLocalInt(oPC,"nMovModExempt") == 1) return;
	
	float fMod = GetLocalFloat(OBJECT_SELF, "fMod");
	
	int iSurvival = GetSkillRank(SKILL_SURVIVAL,oPC);
	
	float fSurvMod = (IntToFloat(iSurvival) * 0.001);
	fMod = fMod + fSurvMod;

/*	//remove survival ranks from modifier
	//check if survival skill is usable
	if (iSurvival == -1)
		{
			iSurvival = -10; // penalty for not having skill
		}
	if (iSurvival == 0)
		{
			iSurvival = -5; // penalty for skill not trained
		}
*/


	SetMovementRateFactor(oPC, fMod);
}