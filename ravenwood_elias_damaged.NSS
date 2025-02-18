// rnvw_elias_damaged_final
// OnDamaged script for Elias
#include "NW_I0_GENERIC"
#include "ginc_misc"
	
void main()
{
	
	int n;
	object oPC;
	
	oPC = GetLastDamager();
	
    if (GetIsObjectValid(GetMaster(oPC)) == TRUE)
    {
            oPC = GetMaster(oPC);
    }	
 
	if (GetHPPercentage(OBJECT_SELF) < 50)
	{
		if ( IsMarkedAsDone() == TRUE ) return;
		MarkAsDone();
		
		//Patch him up a little before fighting more.
		effect eHeal = EffectHeal(200);	
		ApplyEffectToObject(DURATION_TYPE_INSTANT,eHeal,OBJECT_SELF);
		//Advance the quest state here
		AddJournalQuestEntry("ravenswood_embers", 40, oPC, 1,0, 0);
		
		// elias stop what you're doing	
		ChangeToStandardFaction( OBJECT_SELF, STANDARD_FACTION_DEFENDER );
		ClearAllActions( TRUE );
		SurrenderToEnemies();
				
		// players stop what you're doing
		object oPlayer = GetFirstFactionMember(oPC);
		while (GetIsObjectValid(oPlayer))
		{
			AssignCommand (oPlayer,ClearAllActions( TRUE ));
			oPlayer = GetNextFactionMember(oPlayer,TRUE);
		}				
		
		// hostiles stop what you're doing
		n = 1;
		object oTarget = GetNearestCreature(CREATURE_TYPE_PLAYER_CHAR, PLAYER_CHAR_NOT_PC, oPC, n);
		while (GetIsObjectValid(oTarget))
		{
			AssignCommand(oTarget, ClearAllActions(TRUE));
			ChangeToStandardFaction(oTarget, STANDARD_FACTION_DEFENDER);
			n = n+1;
			oTarget = GetNearestCreature(CREATURE_TYPE_PLAYER_CHAR, PLAYER_CHAR_NOT_PC, oPC, n);
		}		
		//DetermineCombatRound();
		
		// put the players in a conversation while we clean up the area
		AssignCommand(
			GetNearestObjectByTag("ravenwood_elias_speaker"),
			DelayCommand(1.0,ActionStartConversation(oPC,"ravenwood_elias_surrender",FALSE,TRUE))
			);		
        }
}