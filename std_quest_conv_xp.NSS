/*
	ga_*	( conversation action )

	Attach this to conversation nodes to award XP.  
	Works just like the standard but it	persists.
	
	There is NOT currently a xp cap in place - you CAN accidentally give more 
	than 100% xp.  I hope to correct this "one day"
	
	Why is this script not replaced by xp_flat yet?
		I think we just need to patch marie.
	
	2006/11/19		jhr4n		
		initial revision

*/


void	main( string quest, int nPercentXP )
	{
	
	// Locate the PC involved in this mess
	object oPC = GetPCSpeaker();
	if ( !GetIsObjectValid( oPC ) )
		oPC = OBJECT_SELF;	
		
	
	int total = GetJournalQuestExperience( quest );
	total *= 100;
	total /= nPercentXP;
	
	GiveXPToCreature( oPC, total );
	}



/*
*/