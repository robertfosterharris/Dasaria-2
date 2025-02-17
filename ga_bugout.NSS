// BugOut -- Wrapper for ForceExit
// Beacause the NWN2 wrapper function doesn't work the exact way I want it to
// Blackheart 4/16/2007

#include "NW_I0_GENERIC"
#include "ginc_misc"

void main()
{
	object oTarget = OBJECT_SELF;
	string sCreatureTag = GetTag ( OBJECT_SELF );
	string sOneLiner = sCreatureTag + "_flee";
	
	// Don't get killed
	SetPlotFlag( OBJECT_SELF, TRUE );
	
	// Stop fighting, casting, whatever and do my bidding!
	ChangeToStandardFaction( OBJECT_SELF, STANDARD_FACTION_DEFENDER );
	SurrenderToEnemies();
	ClearAllActions( TRUE );
	DetermineCombatRound();
	
	// Run for it!
	SpeakOneLinerConversation(sOneLiner, oTarget);
	SetCreatureScriptsToSet(OBJECT_SELF, 0);
	ForceExit(sCreatureTag,"WP_escape", TRUE);
}