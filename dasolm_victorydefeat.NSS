#include "i_battle_setting"
#include "dasolm_inc"

// wired 08/10/2011 fix up for OLM map quest
// object oBC = OBJECT_SELF;

// Victory/Defeat 
// Edit this script to change victory and defeat conditions
void main()
{
	object oBC = OBJECT_SELF;
	object oArea = GetArea(oBC);
	//object oPC = GetFirstPC(FALSE);
	object oPC = GetLocalObject(oArea,"oPartyLeader");
	string sAreaTag = GetTag(oArea);
	string sGroup = ObjectToString(oPC);
	
	// Victory Conditions here
	if( GetIsAnnihilated(oPC, REPUTATION_TYPE_ENEMY) )
	{
		// Victory Actions
		ShowBattleStat(oPC, "Victory"); //shows a report
		SetBattleActive(FALSE); //set battle inactive
		
		AddJournalQuestEntry(sAreaTag,2,oPC,TRUE);
		GiveXPToAll( oPC, GetJournalQuestExperience(sAreaTag) );
		GroupSetLocalInt(sGroup,"bVictory",TRUE);
		changePCPartyMetaFactionRenown(oPC,10);		
	}
	
	// Defeat Conditions here
	if( GetIsAnnihilated(oPC, REPUTATION_TYPE_FRIEND)
	&&  GetIsAnnihilated(oPC, REPUTATION_TYPE_NEUTRAL) )
	{
		// Defeat Actions
		ShowBattleStat(oPC, "Defeat"); //shows a report
		SetBattleActive(FALSE); //set battle inactive
		
		AddJournalQuestEntry(sAreaTag,3,oPC,TRUE);
		GroupSetLocalInt(sGroup,"bVictory",FALSE);
		changePCPartyMetaFactionRenown(oPC,-10);	
	}
}