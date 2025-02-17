// ga_faction_rep
/*
    This script makes sTarget be viewed differently by a faction.
	sTarget - The target who will be viewed differently (see Target's note).
	sTargetFaction - Either one of the 4 standard factions $COMMONER, $DEFENDER, $HOSTILE, $MERCHANT or
				a target who belongs to the faction (may or may not need to be a creature)
	sChange - the amount to change the faction reputation by.  (May later be ammended to allow setting).
					
*/
//  ChazM 2/25/05

// wired 10/28/2010 made PC_LEADER multi-player-friendly in  "ginc_param_const"


#include "ginc_param_const"
#include "nw_i0_generic" 


void main(string sTarget, string sTargetFaction, string sChange)
{
	object oTarget = GetTarget(sTarget);
	object oMember;
	int iChange	= StringToInt(sChange);
    if(!GetIsObjectValid(oTarget))
    {
 		PrintString ("Invalid Target");
		return;
    }

	int iFaction = GetStandardFaction(sTargetFaction);
	
	if (iFaction == -1) {
		object oTargetFaction = GetTarget(sTargetFaction);
	    if(GetIsObjectValid(oTargetFaction))
		{
	 		AdjustReputation(oTarget, oTargetFaction, iChange);
	 		PrintString ("adjust faction reputation for " + GetName(oTarget) + " with faction of " + sTargetFaction + " by " + IntToString(iChange));
			// this may be guy in completely different area, use nearest enemy instead in all cases			
			//AssignCommand(oTargetFaction, DetermineCombatRound());
		}
		
			oMember = GetFirstFactionMember(oTarget,TRUE);
	while (GetIsObjectValid(oMember))
	{
		AdjustReputation(oMember, oTargetFaction, iChange);
		AdjustReputation(oMember, oTargetFaction, iChange);
		
		oMember = GetNextFactionMember(oTarget,TRUE);
	}
					
	}		
	else {
		int iNewReputation = GetStandardFactionReputation(iFaction, oTarget) + iChange;
		SetStandardFactionReputation(iFaction, iNewReputation, oTarget);
	 	PrintString ("adjust faction reputation for " + GetName(oTarget) + " with " + sTargetFaction + " by " + IntToString(iChange));
		// need to find closest and set to Determine Combat Round.		
	}		
	
	object oNearestEnemy = (GetNearestCreature(CREATURE_TYPE_REPUTATION, REPUTATION_TYPE_ENEMY, oTarget));
	AssignCommand(oNearestEnemy, DetermineCombatRound());
}