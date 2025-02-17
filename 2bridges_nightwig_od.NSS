// 2bridges_nightwig_od
// Custom Death Script for Nightwig
#include "std_quest_i0"
void main()
{
	object oPC = GetLastHostileActor();
	
     if (GetIsObjectValid(GetMaster(oPC)) == TRUE)
     {
     	oPC = GetMaster(oPC);
     }	
	
	
	if (GetJournalEntry("2bridges_dragon", oPC) > 0)
	{
		// loop through PC's party
		object oMember = GetFirstFactionMember( oPC, TRUE );
		while ( GetIsObjectValid( oMember ) )
		{
			// find anyone not already marked Dragonfoe
			if (GetCampaignInt("Cear","Dragonfoe",oMember) != 1)
			{	
				// go ahead and mark the individual, apply penalties
				SetCampaignInt("Cear","Dragonfoe",1,oMember);
				effect eSavePen = EffectSavingThrowDecrease(SAVING_THROW_ALL, 1, SAVING_THROW_TYPE_FEAR);
				eSavePen = SupernaturalEffect(eSavePen);
				ApplyEffectToObject(DURATION_TYPE_PERMANENT,eSavePen,oMember);				
				SendMessageToPC(oMember,"The chill of fright shockwaves through you as the Dragon-witch Nightwig curses you with her dying breath, forever branding you <i>Dragonfoe</i>.");
			}
			
			// apply the fear effect to everyone in party
			effect eVis = EffectVisualEffect(VFX_DUR_AURA_DRAGON_FEAR);
			effect eFear = EffectFrightened();		
			ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eVis,oMember,60.0);
			ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eFear,oMember,60.0);
									
			oMember = GetNextFactionMember( oPC, TRUE );
		}
		// finish looping through party

		// update the quest journal
		//AddJournalQuestEntry("2bridges_dragon",6,oPC,TRUE);	
		persist_advance_party( oPC, "2bridges_dragon", 0, 6, 0, "" );
	}
}