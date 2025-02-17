// ga_give_quest_xp
//
// wired: add a single-user path
// wired 11/9/2009 version that prints to log
// EPF 3/15/06
	
#include "ginc_journal"
#include "d2_sql_log"

void main(string sQuestTag, int bSingle = FALSE)
{
	object oPC = (GetPCSpeaker()==OBJECT_INVALID?OBJECT_SELF:GetPCSpeaker());
	if (bSingle)
	{
		GiveXPToCreature(oPC, GetJournalQuestExperience(sQuestTag));
	}
	else
	{
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
			
			trackEvent(oPartyMem,"QUEST_XP",oPartyMem,GetHitDice(oPartyMem),iQuestXPReward,sQuestTag);
			
			
	        oPartyMem = GetNextFactionMember(oPC, TRUE);
		}
	}	
}