// lendol_fort_flag_ou

#include "dasolm_inc"
#include "ginc_group"

void main()
{
	object oPC = GetLastUsedBy();
	string sGroupName = "lendose_ol_fort_enemies";
	
	// Group is still around and is still hosile
	if(GetIsGroupValid(sGroupName, TRUE) && IsGroupHostile(sGroupName, oPC))
	{
		FloatingTextStringOnCreature("Hostile forces still hold part of the fortress, you are unable to claim their flag.",oPC);
	}
	// Allow journal advance
	else
	{
		if (GetJournalEntry("lendose_ol_fort",oPC) == 1)
		{
			AddJournalQuestEntry("lendose_ol_fort",2,oPC,TRUE);
			RewardPartyQuestXP(oPC, "lendose_ol_fort");
		}

		if (GetJournalEntry("lendose_ol_fort2",oPC) == 0)
		{
		
			// this group should already exist but let's re-do it anyway
			string sGroup = ObjectToString(GetFactionLeader(oPC));
			//FactionToGroup(oPC,sGroup, GROUP_LEADER_FIRST, TRUE);	
			GroupAddFaction(sGroup, oPC, GROUP_LEADER_FIRST, TRUE);
			GroupSetLocalInt(sGroup,"bVictory",FALSE);
			
			AddJournalQuestEntry("lendose_ol_fort2",1,oPC,TRUE);
			FloatingTextStringOnCreature("No sooner do you secure the fortress when the clarion of enemy battlehorns is heard to ring out over the plains.",oPC);
			PlaySound("as_pl_horngood1");
			
			//AddScriptParameterInt(getMetaFaction(oPC));
			ExecuteScript("lendol_fort2_siege_start",GetArea(OBJECT_SELF));
		}
	}
}