// wired 11/09/2007
// assassin_victim_ud
// edited 2014/07/04
#include "NW_I0_GENERIC"
#include "x0_i0_position"
#include "ginc_actions"
#include "ginc_das_jail"

// Spawn the Savant to Steal the PC's kill
void SpawnSavant(object oPC);

void main()
{
	int nEvent;
	object oLastAttacker;
	object oPC;
	
	nEvent = GetUserDefinedEventNumber();
	switch( nEvent )
	{
		case EVENT_ACTION_ATTACK_FAILED_NO_PATH:
		{
			ActionSpeakString( GetName(OBJECT_SELF) + " got action failed no path" );
		}
		break;
		
		case EVENT_ATTACKED:
		{
		// wired: why was this here?  should be on perceive of witnesses or similar
		/*
			oLastAttacker = GetLastHostileActor();
			
			if (GetLocalInt(oLastAttacker, "nLegalStatus") != LEGAL_STATUS_WARRANT)
			{
				issueWarrant(oLastAttacker, GetObjectByTag("d2_faction_cearguard"));
			}
		*/
		}
		break;
		
		case EVENT_PERCEIVE:
		{
		  	oPC = GetLastPerceived();			
  			if( !GetIsInCombat() )
			//if( GetIsPC( oPC) && !GetIsInCombat() )
  			{ 
				if (GetLocalObject(OBJECT_SELF,"AuthKiller") == oPC)
				{
					// we only want this run once, the first time the PC is perceived
					if (GetLocalInt(oPC,"nBungled") != 1)
					{				
						FloatingTextStringOnCreature("Bonus lost. <i>You have been perceived.</i>",oPC);
						SetLocalInt(oPC,"nBungled",1);
						
						// skip this part if we're on kill #1, PC could be on "good path"
						int nEntry = GetJournalEntry("assassin",oPC);
						if (nEntry == 1)
						{
							// 10% probability of The Savant "stealing" the kill						
							int nDiceRoll = Random(99);
							if (nDiceRoll > 90)
							{
								SpawnSavant(oPC);
							}
						}						
					}
				}	
  			}		
		}
		break;		
	}
    return;
}	

// Spawn the Savant to Steal the PC's kill
void SpawnSavant(object oPC)
{
	// spawn her
	location lLoc = GetLocation(oPC);
	object oSavant = CreateObject(OBJECT_TYPE_CREATURE, "assassin_savant", lLoc, TRUE);
	
	// make her attack the victim
	StandardAttack(oSavant, OBJECT_SELF, FALSE);
	
	// fail the PC's quest
	FloatingTextStringOnCreature("The Savant has taken your kill.",oPC);
	AddJournalQuestEntry("assassin",3,oPC,FALSE,FALSE,TRUE);	
	
	// clean up the savant afterward
	AssignCommand(oSavant,DelayCommand(300.0,DestroyObject(oSavant)));
}