// like it say!
// wired 02/28/09
#include "ginc_partymath"
void main()
{
	
	object oPC = GetEnteringObject();
	object oTrigger = OBJECT_SELF;
	
	string quest = GetLocalString( oTrigger, "quest" );
	int require = GetLocalInt( oTrigger, "quest_require" );
	int advance = GetLocalInt( oTrigger, "quest_advance" );
	int bParty = GetLocalInt( oTrigger, "bParty" );
	int bOverride = GetLocalInt( oTrigger,"bOverride" );	
	
	if ( quest == "")
	{
		// Panic
		return;
	}
		
	int nState = GetHighJournalEntry(quest,oPC);

	// Compare and assign	
	if ( nState == require )
		{
		AddJournalQuestEntry( quest, advance, oPC, bParty, FALSE, bOverride );
		}		
}