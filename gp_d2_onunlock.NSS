//	GLOBAL ON UNLOCK SCRIPT - AWARDS XP ON UNLOCK
//
//	ROBERT HARRIS	12/29/08	ROBERTHARRIS@ROBERTHARRIS.COM
//
#include "X0_I0_PARTYWIDE"

void main()
{
	int nDC;
	int nSkill;
	int nXP;
	object oPC;
	object oPartyMember;	
	
	oPC = GetLastUnlocked();
	nDC = GetLockUnlockDC(OBJECT_SELF);
	nSkill = GetSkillRank(SKILL_OPEN_LOCK, oPC);
	
	nXP = nDC - nSkill;
	if (nXP < 0) nXP = 0;
	nXP *= 3;
	
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