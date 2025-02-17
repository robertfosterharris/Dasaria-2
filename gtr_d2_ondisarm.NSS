//	GLOBAL ON DISARM SCRIPT - AWARDS XP ON TRAP DISARM
//
//	ROBERT HARRIS	04/31/07	ROBERTHARRIS@ROBERTHARRIS.COM
//
//	03/02/09	ROBERT HARRIS	PARTY MEMBERS MUST BE WITHIN 30 METERS TO RECIEVE XP
//

void main()
{
	int nDC;
	int nSkill;
	int nXP;
	object oPC;
	object oPartyMember;
	
	oPC = GetLastDisarmed();
	nDC = GetTrapDisarmDC(OBJECT_SELF);
	nSkill = GetSkillRank(SKILL_DISABLE_TRAP, oPC);
	
	nXP = nDC - nSkill;
	if (nXP < 0) nXP = 0;
	nXP *= 2;
	
	oPartyMember = GetFirstFactionMember(oPC, TRUE);
	while (GetIsObjectValid(oPartyMember))
	{
		if (GetDistanceBetween(oPC, oPartyMember) <= 30.0 || oPC == oPartyMember)
		{
			GiveXPToCreature(oPartyMember, nXP);
		}
		oPartyMember = GetNextFactionMember(oPC, TRUE);
	}
}