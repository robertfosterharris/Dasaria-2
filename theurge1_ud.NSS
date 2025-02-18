// theurge1_ud

#include "ginc_misc"
#include "X0_I0_PARTYWIDE"
#include "ginc_partymath"
	
void main()
{

    int nUser = GetUserDefinedEventNumber();	
    if(nUser == EVENT_DAMAGED )
	{
		int nHP = GetCurrentHitPoints( OBJECT_SELF );
		int nMaxHP = GetMaxHitPoints( OBJECT_SELF );
		float MIN_HP = 0.30f;
		object oPC = GetLastHostileActor();
		
		if (GetIsObjectValid(GetMaster(oPC)) == TRUE)
		{
	            oPC = GetMaster(oPC);
		}			
		
		int nJournal = GetHighJournalEntry("tristan_theurge", oPC);
		
		//effect eHeal = EffectHeal(300);
	   
		if ( ( IntToFloat( nHP ) / nMaxHP ) < MIN_HP )
		{
			if ( IsMarkedAsDone() == TRUE ) return;
			MarkAsDone();
			
			//ApplyEffectToObject(DURATION_TYPE_INSTANT,eHeal,OBJECT_SELF);
				
			SetPlotFlag( OBJECT_SELF, TRUE );
			
			if ( nJournal > 0 && nJournal < 3 && PartyLevelCheck( oPC, 12, 17 ) == TRUE )
			{
				AddJournalQuestEntry("tristan_theurge", 3, oPC, TRUE,0, 0);
			}			
			
			SurrenderToEnemies();
			
			ClearAllActions( TRUE );
			ClearNearbyFriendActions(OBJECT_SELF, TRUE);
			ClearNearbyFriendActions(oPC,TRUE);
			
			DelayCommand(2.0,ActionStartConversation(oPC,"theurge_enc1_end",FALSE,TRUE));
		}
	}
}