/*
*/
// wired 10/04/2008 launch welcome convo on new character
// Atharin 07/17/2009 delayed welcome convo by 1 sec in case it breaks DMFI tool pickup
#include "std_i0_data"
#include "std_i0_time"


object	std_journal_get( object oPC );
object	std_journal_event_login( object oPC );
void	std_journal_event_unaquire( );



/*
*/

string journal_tag = "std_journal";
string kOwner = "std_journal_owner";
string kVersion = "std_journal_version";

// Make sure they have a journal.  Assign journal owner object
object std_journal_event_login( object oPC )
{
	object oJournal;
	
	oJournal = std_journal_get( oPC );
	if (!GetIsObjectValid(oJournal))
	{
		SendMessageToPC(oPC, "New Player");
		oJournal = CreateItemOnObject(journal_tag, oPC);
		// wired 10/04/2008 launch welcome convo on new character 
		if (!GetIsDM(oPC)) 
		{ 
			ActionStartConversation(oPC,"mod_cnv_welcome",TRUE,FALSE); }
		}
	//	MAKE THE JOURNAL NON-DROPABLE	
	SetItemCursedFlag(oJournal, TRUE);
	//	Found or created, the owner must be redefined every time
	SetLocalObject( oJournal, kOwner, oPC );
	
	//	SAVE ORIGINAL NAMES AND CD KEY FOR DATABASE KEYS
	if (GetLocalString(oJournal, "Name") == "")
	{
		SetLocalString(oJournal, "Name", GetName(oPC));
		SetLocalString(oJournal, "PCPlayerName", GetPCPlayerName(oPC));
		SetLocalString(oJournal, "PCPublicCDKey", GetPCPublicCDKey(oPC));
	}
	return oJournal;
}
	
	

// Hook	into module unaquire.  Prevents dropping journal.
void	std_journal_event_unaquire( )
	{
	// This "owner" method is not really necessary, 
	// but I like to hedge my bets
	
	object oItem = GetModuleItemLost();
	object oLoser = GetModuleItemLostBy();
	string resref = GetTag( oItem );

	// trying to drop the journal.  stop them.			
	if ( resref == journal_tag )
		{	
		// find the owner and give it to them
		object oOwner = GetLocalObject( oItem, kOwner );
		if ( GetIsObjectValid( oOwner ) )
			{
			CopyItem( oItem, oLoser, TRUE );
			DestroyObject( oItem );
			}
			
		}
	}	

	

// Self descriptive helper function.  Wraps journal tag.	
object	std_journal_get( object oPC )
	{
	return GetItemPossessedBy( oPC, journal_tag );
	}

	
void	std_persist_time_save()
	{
    string db = "DateTime";

	int Year = GetCalendarYear();
	int Month = GetCalendarMonth();
	int Day = GetCalendarDay();
	int Hour = GetTimeHour();	
	
    SetCampaignInt(db, "Hour", Hour );
    SetCampaignInt(db, "Day", Day );
    SetCampaignInt(db, "Month", Month );
    SetCampaignInt(db, "Year", Year );
	}

	
	
void	std_persist_time_load()
	{
    string db = "DateTime";

    int Hour =  GetCampaignInt(db, "Hour" );
    int Day =   GetCampaignInt(db, "Day" );
    int Month = GetCampaignInt(db, "Month" );
    int Year =  GetCampaignInt(db, "Year" );

    SetTime( Hour, 0, 0, 0);
    SetCalendar(Year, Month, Day);
	}	


/*
*/