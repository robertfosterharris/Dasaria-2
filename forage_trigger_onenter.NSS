/*
	When the PC enters, do a skill check, and spawn a placeable.
	
	2006/11/??		jhr4n
		Initial revision

	2006/11/25		jhr4n
		Made respawn second accurate instead of game hour accurate
		Made respawn trigger dependent instead of player dependent

	2006/11/26		jhr4n
		Changed the way checks were performed.  Used to add them all 
		togeather and check vs one DC for "find" and one for "know"
		
	2008/12/28	wired
		random placeable based on gather system
		random location near pc
		implemented respawn_search
		lore/survival, xp award moved onto placeable/item
		
	2010/03/19 wired
		a few tweaks to make this re-usable for knobblenort quest /
		battlefield metal
		
	2010/06/28 wired
		add a 'quest required' option
*/

#include "x0_i0_position"
#include "std_i0_time"
#include "std_i0_skill"
#include "ginc_partymath"
#include "ginc_var_ops"

//	The find DCs
string kFindSearch	= "cfg_find_search";
string kFindSurvive	= "cfg_find_survive";
	
// Respawn rates
string kRespawn1	= "cfg_respawn_search";  // wired 2008/12/28

// wired 2008/12/28
string GetPlant()
{
	string sHerb = GetLocalString(OBJECT_SELF,"sHerb");
	int bHigh	= GetLocalInt(OBJECT_SELF,"cfg_high");
	if (sHerb == "")
	{	
		if (bHigh == TRUE)
		{
			switch (Random(6))
			{
				case 0: sHerb	=	"forage_hellebore";  break;		// hellebore nectar
				case 1: sHerb	=	"forage_hawthorn";  break;		// hawthorne snuff
				case 2: sHerb	=	"forage_blackthorn";  break;	// blackthorn barb
				case 3: sHerb	=	"forage_henbane";  break;		// henbane drought
				case 4: sHerb	=	"forage_ravensara";  break;		// ravensara oil
				case 5: sHerb	=	"forage_speedwell";  break;		// speedwell tonic
			}
		}
		else
		{	
	
			switch (Random(30))
			{
				case 0: sHerb	=	"forage_arrach";  break;
				case 1: sHerb	=	"forage_acac";  break;
				case 2: sHerb	=	"forage_alf";  break;
				case 3: sHerb	=	"forage_aloe";  break;
				case 4: sHerb	=	"forage_asa";  break;
				case 5: sHerb	=	"forage_birth";  break;
				case 6: sHerb	=	"forage_bmoss";  break;
				case 7: sHerb	=	"forage_blete";  break;
				case 8: sHerb	=	"forage_brown";  break;
				case 9: sHerb	=	"forage_crrt";  break;
				case 10: sHerb	=	"forage_comf";  break;
				case 11: sHerb	=	"forage_dead";  break;
				case 12: sHerb	=	"forage_fenn";  break;
				case 13: sHerb	=	"forage_fire";  break;
				case 14: sHerb	=	"forage_puff";  break;
				case 15: sHerb	=	"forage_ging";  break;
				case 16: sHerb	=	"forage_goose";  break;
				case 17: sHerb	=	"forage_green";  break;
				case 18: sHerb	=	"forage_hazel";  break;
				case 19: sHerb	=	"forage_holly";  break;
				case 20: sHerb	=	"forage_kelp";  break;
				case 21: sHerb	=	"forage_lark";  break;
				case 22: sHerb	=	"forage_mm";  break;
				case 23: sHerb	=	"forage_mug";  break;
				case 24: sHerb	=	"forage_pmoss";  break;
				case 25: sHerb	=	"forage_reeds";  break;
				case 26: sHerb	=	"forage_retch";  break;
				case 27: sHerb	=	"forage_sage";  break;
				case 28: sHerb	=	"forage_bry";  break;
				case 29: sHerb	=	"forage_wolfsbane"; break;
				default: sHerb  = 	"forage_arrach";
			}
		}
	}
	return sHerb;
}

int	gather_search_new( object oTrigger, object oPC )
{	
	int iSurvival	= GetLocalInt( oTrigger, kFindSurvive );
	int iSearch		= iSurvival+5;	

	if ( GetIsSkillSuccessfulPrivate(oPC, SKILL_SURVIVAL, iSurvival) )
	{
		return TRUE;
	}

	if ( GetActionMode( oPC, ACTION_MODE_DETECT ) && GetIsSkillSuccessfulPrivate(oPC, SKILL_SEARCH, iSearch) )
	{
		return TRUE;
	}

	return FALSE;
}
	
void main()
{

	object oPC = GetEnteringObject();
	if ( !GetIsPC(oPC) )
		return;
		
	int	i;	
	int	nMaxHerbs		= 1;
	int nDist;
	location lRandom;
	location lFinal;
	effect eID;
	string herb_ownerpc = "herb_ownerpc";
	string sMessage;
	
	int nJournalEntry;
	string sQuestRequired;
	string sJournalReq;
	
	object oTrigger		= OBJECT_SELF;
	object oArea 		= GetArea(OBJECT_SELF);
	object oHerb;
	sQuestRequired		=	GetLocalString(OBJECT_SELF,"sQuestRequired");
	
	// if sQuestRequired is set check the PCs
	// journal before doing anything
	if (sQuestRequired != "")
	{
		sJournalReq		=	GetLocalString(OBJECT_SELF,"sJournalReq");
		nJournalEntry 	= 	GetHighJournalEntry(sQuestRequired,oPC);
		if (! CompareInts(nJournalEntry, sJournalReq) ) return;
	}
		
	int nRespawnSecs	= GetLocalInt( oTrigger, kRespawn1 );
	
	sMessage = GetLocalString(OBJECT_SELF,"sMessage");
	if (sMessage == "") sMessage = "This seems like a good place to forage for Herbs!";
		
	int debug = GetLocalInt(oTrigger,"debug");
	if (debug) SendMessageToPC(oPC, "Running");
	
	// You can check a trigger every 30 seconds
	int elapsed_skillchecks = time_stamp_seconds_elapsed( oTrigger, "skillchecktimestamp");
	if ( elapsed_skillchecks < 30 )
	{
		if (debug) SendMessageToPC(oPC, "Skillcheck Timer: " + IntToString(elapsed_skillchecks) );
		return;
	}
		
	if (debug) SendMessageToPC(oPC, "Allowed to check");
	// Only do checks if there is something to find
	int elapsed = time_stamp_seconds_elapsed( oTrigger, "respawntimestamp");
	if ( elapsed < nRespawnSecs )
	{
		if (debug) SendMessageToPC(oPC, "Respawn Timer: " + IntToString(elapsed) );
		return;
	}
		
	if (debug) SendMessageToPC(oPC, "Something to find");

	// Mark the last search, and search
	time_stamp_seconds_set( oTrigger, "skillchecktimestamp");		
	if ( !gather_search_new(oTrigger, oPC) )
		return;

	if (debug) SendMessageToPC(oPC, "Check Passed");
	// Set last spawn timer
	time_stamp_seconds_set( oTrigger, "respawntimestamp");
	
	nMaxHerbs = GetLocalInt(oTrigger,"cfg_maxherbs");
	
	for (i = 0; i < nMaxHerbs; i++)
	{	
		// wired 2008/12/28
		nDist = Random(20)+7;
		lRandom	= GetRandomLocation(oArea, oPC, IntToFloat(nDist));
		lFinal	= CalcSafeLocation( oPC, lRandom, 5.0f, TRUE,FALSE );
		// Create the random placeable
		oHerb = CreateObject( OBJECT_TYPE_PLACEABLE, GetPlant(), lFinal, FALSE);
		
		if (!GetIsObjectValid(oHerb) && debug) SendMessageToPC(GetFirstPC(),"Herb not valid."); 
		if (!GetIsObjectValid(oPC) && debug) SendMessageToPC(GetFirstPC(),"PC not valid."); 
		
		// Set backlink to PC
		SetLocalObject( oHerb, "herb_ownerpc", oPC );		
	}
	
	// Send message to PC
	eID = EffectVisualEffect( VFX_DUR_SPELL_IDENTIFY );
	ApplyEffectToObject( DURATION_TYPE_TEMPORARY, eID, oPC, 10.0f); 
	GiveXPToCreature(oPC, 5);
	SendMessageToPC(oPC, sMessage);
}
	