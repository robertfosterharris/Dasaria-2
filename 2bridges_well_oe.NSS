// 2bridges_well_oe
// force the player to make a hide/move check upon approaching the well
#include "NW_I0_GENERIC"
void main()
{
	object oPC = GetEnteringObject();
	// if pc is on the quest
	if (GetJournalEntry("2bridges_assassin",oPC) == 4)
	{
		// if isn't stealthed or fails roll against move/hide dc 20
		if (GetStealthMode(oPC) == 0 ||
			!GetIsSkillSuccessful(oPC,SKILL_MOVE_SILENTLY, 20) ||
			!GetIsSkillSuccessful(oPC,SKILL_HIDE, 20) )
		{
			// guards attack
			object oWellGuard1 = GetNearestObjectByTag("2bridges_wellguard1");
			object oWellGuard2 = GetNearestObjectByTag("2bridges_wellguard2");
			AdjustReputation(oPC,oWellGuard1,-100);		
			//DetermineCombatRound();
			AssignCommand(oWellGuard1, ActionAttack(oPC));
			AssignCommand(oWellGuard2, ActionAttack(oPC));	
   		 	
    		// and shout to my allies in the vicinity to join me
    		AssignCommand(oWellGuard1,SpeakString ("NW_ATTACK_MY_TARGET", TALKVOLUME_SILENT_TALK));			
			
			// end quest
			AddJournalQuestEntry("2bridges_assassin",9,oPC,FALSE);				
			// reset rep
			DelayCommand(60.0, SetStandardFactionReputation(STANDARD_FACTION_DEFENDER,100,oPC));
		}
		// else proceed normally
	}
}