// wired 12/19/07
// 2bridges_assassin_victim_ud
#include "NW_I0_GENERIC"

void main()
{
	int nEvent = GetUserDefinedEventNumber();
	
	switch( nEvent )
	{
		case EVENT_ATTACKED:
		{
			object oPC = GetLastHostileActor();
    		// lower my faction's relationship with the PC by 100 (to hostile)
    		AdjustReputation (oPC, OBJECT_SELF, -100);
   			// start combat (this requires the nw_i0_generic file to be included, above)
   		 	DetermineCombatRound();
    		// and shout to my allies in the vicinity to join me
    		SpeakString ("NW_ATTACK_MY_TARGET", TALKVOLUME_SILENT_SHOUT);			
			// after 1.5 minutes forget that we hate you
			DelayCommand(90.0, SetStandardFactionReputation(STANDARD_FACTION_DEFENDER,100,oPC));
		}
		break;
		
		case EVENT_PERCEIVE:
		{
		  	object oPC = GetLastPerceived();
			// make sure this is someone on the quest
			int nEntry = GetJournalEntry("2bridges_assassin",oPC);
			if (nEntry == 6)
			{			
				if( !GetIsInCombat() )
				{
					// we only want this run once, the first time the PC is perceived
					if (GetLocalInt(oPC,"nBungled") != 1)
					{				
						FloatingTextStringOnCreature("Bonus lost. <i>You have been perceived.</i>",oPC);
						SetLocalInt(oPC,"nBungled",1);
					}
				}	
  			}		
		}
		break;		
	}
    return;
}