// lendol_fort2_siege_end

#include "ginc_group"

void main()
{
	object oArea 		= GetObjectByTag("lendose_ol_fort");
	object oPC			= GetLocalObject(oArea,"oPartyLeader");
	string sQuestTag	= "lendose_ol_fort2";
	string sGroup;
	
	// if the original leader is invalid, flop around
	// desperately for anybody left in the group
	if (!GetIsObjectValid(oPC))
	{
		sGroup	= ObjectToString(GetFactionLeader(oPC));
		oPC 	= GetFirstInGroup(sGroup);
		
		while (!GetIsObjectValid(oPC))
		{
			oPC = GetNextInGroup(sGroup);
		}
	}
	
	AddJournalQuestEntry(sQuestTag,2,oPC,TRUE);
	
	int iQuestXPReward =  GetJournalQuestExperience(sQuestTag);
	
	object oPartyMem = GetFirstFactionMember(oPC, TRUE);
	while (GetIsObjectValid(oPartyMem)) 
	{		
       	GiveXPToCreature(oPartyMem, iQuestXPReward);
			
			// add a logging parameter here
			WriteTimestampedLogEntry("AWARD: "+
			sQuestTag+" "+
			IntToString(iQuestXPReward)+" ["+
			IntToString(GetHitDice(oPartyMem))+"] "+
			GetName(oPartyMem)+" by "+
			GetPCPlayerName(oPartyMem)+" ("+
			GetPCPublicCDKey(oPartyMem)+")");
	        oPartyMem = GetNextFactionMember(oPC, TRUE);
	}
	
	MusicBattleStop(oArea);
}