// lendol_ol_gap_n
// wired 05/13/2011
//
// this is a group death script
//

#include "dasolm_inc"
#include "hench_i0_ai"

void main()
{
	string sEnemyGroupName = GetLocalString(OBJECT_SELF,"MyGroup");
	object oArea = GetArea(OBJECT_SELF);
	object oPC;
	object oMember;
	object oDragon;
	string sGroup;
	int nMetaFac;
	int nEnemy = 3;
	
	// If all group members are dead or invalid
	if ( GetIsGroupValid( sEnemyGroupName, TRUE ) == FALSE )
	{	
		oPC = GetLocalObject(oArea,"oPartyLeader");
		nMetaFac = getMetaFaction(oPC);
		if (nMetaFac == 3) nEnemy = 2;
		
		// this group should already exist but let's re-do it anyway
		sGroup = ObjectToString(GetFactionLeader(oPC));
		GroupAddFaction(sGroup, oPC, GROUP_LEADER_FIRST, TRUE);
		//FactionToGroup(oPC,sGroup, GROUP_LEADER_FIRST, TRUE);	
		
		// END WAVE ONE
		if (GetJournalEntry("lendose_ol_gap",oPC) == 1)
		{
			AddJournalQuestEntry("lendose_ol_gap",2,oPC,TRUE);
			RewardPartyQuestXP(oPC, "lendose_ol_gap");
		}
	
		// START WAVE TWO
		if (GetJournalEntry("lendose_ol_gap2",oPC) == 0)
		{	
			DelayCommand(3.0f,GroupSetLocalInt(sGroup,"bVictory",FALSE));			
			DelayCommand(3.0f,AddJournalQuestEntry("lendose_ol_gap2",1,oPC,TRUE));
			
			PlaySound("as_pl_horngood1");			
			DasOL_Enc_SpawnEnemies(oArea,nMetaFac,oPC);
			DestroyObject(GetNearestObjectByTag("gap_commander"));			
			GroupSetLocalString ( sEnemyGroupName, "DeathScript", sEnemyGroupName );

			oMember = GetFirstInGroup(sEnemyGroupName);
			while (GetIsObjectValid(oMember))
			{
				AssignCommand(oMember,HenchMoveAndDetermineCombatRound(oPC));
				//AssignCommand(oMember,ActionForceMoveToLocation(GetLocation(oPC),TRUE));		
				oMember = GetNextInGroup(sEnemyGroupName);
			}	
			return;			
		}
		
		// END WAVE 2		
		if (GetJournalEntry("lendose_ol_gap2",oPC) == 1)
		{
			AddJournalQuestEntry("lendose_ol_gap2",2,oPC,TRUE);
			RewardPartyQuestXP(oPC, "lendose_ol_gap2");
			changePCMetaFactionRenown(oPC, 1);
		}		
		
		// START WAVE 3
		if (GetJournalEntry("lendose_ol_gap3",oPC) == 0)
		{		
			DelayCommand(3.0f,GroupSetLocalInt(sGroup,"bVictory",FALSE));			
			DelayCommand(3.0f,AddJournalQuestEntry("lendose_ol_gap3",1,oPC,TRUE));
		
			PlaySound("as_pl_horngood1");			
			DasOL_Enc_SpawnEnemies(oArea,nMetaFac,oPC);
			DestroyObject(GetNearestObjectByTag("gap_commander"));
			
			oDragon = CreateObject(OBJECT_TYPE_CREATURE,"lendol_"+IntToString(nEnemy)+"_dragon",GetLocation(GetNearestObjectByTag("wp_dragon_sp")));
			AddToGroup(sEnemyGroupName,oDragon);
			GroupSetLocalString ( sEnemyGroupName, "DeathScript", sEnemyGroupName );

			oMember = GetFirstInGroup(sEnemyGroupName);
			while (GetIsObjectValid(oMember))
			{
				AssignCommand(oMember,HenchMoveAndDetermineCombatRound(oPC));
				//AssignCommand(oMember,ActionForceMoveToLocation(GetLocation(oPC),TRUE));		
				oMember = GetNextInGroup(sEnemyGroupName);
			}	
			return;
		}
		
		// END WAVE 3		
		if (GetJournalEntry("lendose_ol_gap3",oPC) == 1)
		{
			AddJournalQuestEntry("lendose_ol_gap3",2,oPC,TRUE);
			RewardPartyQuestXP(oPC, "lendose_ol_gap3");
			changePCMetaFactionRenown(oPC, 1);
		}
	}
}