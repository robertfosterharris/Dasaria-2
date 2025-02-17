// ceardocks_urchin_ud
// urchins flee from players
// wired 02/26/08
// updated 01/25/08

#include "ginc_actions" 

void main()
{
	int nEvent;	
	object oPerceived;
	int nEntry;

	nEvent = GetUserDefinedEventNumber();
	switch(nEvent)
	{
		case EVENT_PERCEIVE:
		{
			oPerceived = GetLastPerceived();
			nEntry = GetJournalEntry("cd_childcatcher",oPerceived);			
			
			if (GetIsPC(oPerceived) )
			{
				if (nEntry > 0 && nEntry < 6	)
				{
					ClearAllActions(TRUE);
					ActionForceExit("EXIT_ceardocks_orphan1", TRUE);
				}
			}
			else if (GetTag(oPerceived) == "ceardocks_childcatcher")
			{
				SpeakString("The Childcatcher! Run!");	
				ActionMoveAwayFromObject(oPerceived,TRUE,40.0f);
			}
		}
		break;
		
		case EVENT_ATTACKED:
		{
			object oPC = GetLastHostileActor();
			int nEntry;
			int nCaptured;
			string sResRef = GetResRef(GetLastWeaponUsed(oPC));
			
			if (sResRef == "cd_childcatcher_crook" ||
				sResRef == "cd_childcatcher_club")
			{		
				// increment the journal entry only when appopriate
				int nEntry = GetJournalEntry("cd_childcatcher",oPC);			
				if ( nEntry > 0 && nEntry < 6 )
				{
					SpeakString("Allright, allright, you got me.");			
					AssignCommand(oPC,ClearAllActions(TRUE));
					AddJournalQuestEntry("cd_childcatcher",nEntry+1,oPC);					
				}
				// as long as PC uses crook, do this
				effect eTel = EffectNWN2SpecialEffectFile("fx_teleport");
				ApplyEffectToObject(0,eTel,OBJECT_SELF);
				DestroyObject(OBJECT_SELF);
			}
			else
			{
				FloatingTextStringOnCreature("Use the childcatcher's weapon, " + GetFirstName(oPC) + ", children are fragile!", oPC, FALSE);
			}
		}
		break;
	}
}