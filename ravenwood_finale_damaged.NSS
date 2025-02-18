// finale_damaged
// OnDamaged script for Ravenwood finale

#include "ginc_misc"
	
void TestFinaleCompleted()
{
	int nHP = GetCurrentHitPoints( OBJECT_SELF );
	int nMaxHP = GetMaxHitPoints( OBJECT_SELF );
	float MIN_HP = 0.50f;
	object oPC = GetLastDamager();
	object oTarget = OBJECT_SELF;
	string sCreatureTag = GetTag ( OBJECT_SELF );
	string sOneLiner = sCreatureTag + "_flee";
   
	//	PrettyMessage( "Target has " + IntToString(nHP) + "/" + IntToString(nMaxHP) + " hp." );
	if ( ( IntToFloat( nHP ) / nMaxHP ) < MIN_HP )
	{
		if ( IsMarkedAsDone() == TRUE ) return;
		MarkAsDone();
	
		PrettyDebug( "Target is below " + FloatToString( MIN_HP ) + "% hit points." );

		//Only if you want him immortal!
		SetPlotFlag( OBJECT_SELF, TRUE );
		
		//Advance the quest state here
		string sTag = GetTag( OBJECT_SELF );
		
		//Who am I?
		if (sTag == "rvnw_locksley")
		{		
			AddJournalQuestEntry("ravenswood_embers", 53, oPC, 1,0, 0);
		}
		
		if (sTag == "rvnw_praetor_pontius")
		{
			AddJournalQuestEntry("ravenswood_embers", 52, oPC, 1,0, 0);
		}
		
		//ChangeToStandardFaction( OBJECT_SELF, STANDARD_FACTION_DEFENDER );
		
		SurrenderToEnemies();
		
		ClearAllActions( TRUE );
		ClearAllActions( TRUE );
		//DetermineCombatRound();

		// Create the effect to apply
    	effect eHaste = EffectHaste();
    	// Apply the effect to the object   
    	ApplyEffectToObject(DURATION_TYPE_PERMANENT, eHaste, oTarget);
		
		// Run for it!
		//ActivateFleeToExit();
		SpeakOneLinerConversation(sOneLiner, oTarget);	
		ForceExit(sCreatureTag,"WP_escape", 1);   		            
        }
}

void main()
{
	//ExecuteScript( "nw_c2_default6" );	
	TestFinaleCompleted();
}