#include "dasolm_inc"

int StartingConditional(int nCheck)
{
	object oPC = GetPCSpeaker();
	object oLeader = GetFactionLeader(oPC);
	int nGold;
	int nGPNeed;
	
	switch (nCheck)
	{
		case 1:
			if (bDEBUG) SendMessageToPC(oPC,"dasolm_gc_recruit case 1 : you are party leader");
			return DasOL_CheckPartyLeader(oPC); //Are you party leader?
		break;		
		case 2:   //Checks for room in your party
			if (bDEBUG) SendMessageToPC(oPC,"dasolm_gc_recruit case 2 : checking for room in your party");
			if (DasOL_CheckMaxAllies(oPC) > 0) return TRUE;
			else return FALSE;			
		break;		
		case 3: //Enough money for recruiting?
			if (bDEBUG) SendMessageToPC(oPC,"dasolm_gc_recruit case 3 : have you enough money to recruit?");
			return DasOL_CheckRecruits(oPC);
		break;		
		case 4: // Party gathered?
		if (bDEBUG) SendMessageToPC(oPC,"dasolm_gc_recruit case 4 : is your party gathered?");
		if (!DasOL_CheckPartyGathered(oPC)) return FALSE;
		break;
	}
	return FALSE;
}