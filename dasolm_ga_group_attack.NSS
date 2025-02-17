// dasolm_ga_group_attack
// 
// have the enemy warparty attack the PCs party

#include "ginc_group"
#include "hench_i0_ai"

void main()
{
	object oPC = GetPCSpeaker();
	string sEnemyGroupName = GetTag(GetArea(oPC))+"_N";
	object oMember = GetFirstInGroup(sEnemyGroupName);
	
	GroupSetLocalString ( sEnemyGroupName, "DeathScript", sEnemyGroupName );

	while (GetIsObjectValid(oMember))
	{
		//AssignCommand(oMember,ActionForceMoveToLocation(GetLocation(oPC),TRUE));
		AssignCommand(oMember,ClearAllActions());
		AssignCommand(oMember,HenchMoveAndDetermineCombatRound(oPC));
				
		oMember = GetNextInGroup(sEnemyGroupName);
	}
}