// std_quest_ondeath
// wired 05/01/09
//
// standard ondeath to handle journal updates, quest item drops, etc
// creates quest item on killer if configured

// sQuestName		Journal tag to update; Leave blank for no journal advance
// sJournalReq 		Standard compare ints, takes >,>,=,! or an int
// nJournalEntry	Highest int read off the party
// nJournalAdv		Push the quest state to this number
// nMinLvl			Party members must be between these two ints, inclusive
// nMaxLvl
// sDropTemplate	Optional item to drop on death (tag and resref of this item need to be the same)
// nMaxItems		Optional restriction on the number of instances of this item a party can have
// sCustomDeath		Fire an additional custom ondeath() script
// bDrop			Drop item
// bFeet			Create item at PC location
//						else Create in inventory
// bQuestXP			If TRUE, give the Quest XP while we're at it


#include "ginc_partymath"
#include "ginc_var_ops"
#include "ginc_journal"

void main()
{
	int nJournalAdv;
	int nJournalEntry;
	int nMinLvl;
	int nMaxLvl;
	int nMaxItems;
	int bDrop;
	int bFeet;
	int bDebug;
	int nPartyItems;
	int bQuestXP;
	string sJournalReq;
	string sQuestName;
	string sDropTemplate;
	string sCustomDeath;
	object oPC;
	object oItem;
	
	bDebug			=	GetLocalInt(OBJECT_SELF,"bDebug");
	
	oPC	= 	GetLastHostileActor();
    if ( !GetIsObjectValid(oPC) ) return;
	
	if (GetIsObjectValid(GetMaster(oPC)) == TRUE)
	{
            oPC = GetMaster(oPC);
	}	
	
	// required for a journal advance
	sJournalReq		=	GetLocalString(OBJECT_SELF,"sJournalReq");
	nJournalAdv		=	GetLocalInt(OBJECT_SELF,"nJournalAdv");
	sQuestName		=	GetLocalString(OBJECT_SELF,"sQuestName");
		
	// required for quest item drop
	sDropTemplate 	=	GetLocalString(OBJECT_SELF,"sDropTemplate");
	nMinLvl 		=	GetLocalInt(OBJECT_SELF,"nMinLvl");
	nMaxLvl 		=	GetLocalInt(OBJECT_SELF,"nMaxLvl");	
	nMaxItems		=	GetLocalInt(OBJECT_SELF,"nMaxItems");
	bDrop			=	GetLocalInt(OBJECT_SELF,"bDrop");
	bFeet			=	GetLocalInt(OBJECT_SELF,"bFeet");
	bQuestXP		=	GetLocalInt(OBJECT_SELF,"bQuestXP");
		
	// if we wish to run an additional custom action
	sCustomDeath = GetLocalString(OBJECT_SELF, "sCustomDeath");	

	if (bDebug)
	{
		SendMessageToPC(oPC,"I was killed by "+GetFirstName(oPC));
		SendMessageToPC(oPC,"VARIABLES ON CREATURE ======");
		SendMessageToPC(oPC,"sJournalReq: "+sJournalReq);		
		SendMessageToPC(oPC,"nJournalAdv: "+IntToString(nJournalAdv));		
		SendMessageToPC(oPC,"sQuestName: "+sQuestName);		
		SendMessageToPC(oPC,"sDropTemplate: "+sDropTemplate);
		SendMessageToPC(oPC,"nMinLvl: "+IntToString(nMinLvl));
		SendMessageToPC(oPC,"nMaxLvl: "+IntToString(nMaxLvl));	
		SendMessageToPC(oPC,"nMaxItems: "+IntToString(nMaxItems));
		SendMessageToPC(oPC,"bDrop: "+IntToString(bDrop));
		SendMessageToPC(oPC,"bQuestXP: "+IntToString(bQuestXP));
		SendMessageToPC(oPC,"bDebug: "+IntToString(bDebug));
		SendMessageToPC(oPC,"sCustomDeath: "+sCustomDeath);	
	}	
	
	if (bDebug) { SendMessageToPC(oPC,"SITUATIONALS ======"); }
	
	// entire party must be between these limits, inclusive	
	if (!PartyLevelCheck(oPC, nMinLvl, nMaxLvl) )
	{
		if (bDebug) { SendMessageToPC(oPC,"Somebody's out of level"); }
		return;
	}
	if (bDebug) { SendMessageToPC(oPC,"Killer is in-level"); }
	
	// get the highest journal state in the party
	nJournalEntry 	= 	GetHighJournalEntry(sQuestName,oPC);	
	if (bDebug) { SendMessageToPC(oPC,"Party highest journal state was: "+IntToString(nJournalEntry));	}
	
	// if a drop is configured, otherwise skip this
	if ( (sDropTemplate != "") 	)
	{
		if (bDebug) { SendMessageToPC(oPC,"This creature is supposed to drop something"); }
		if (bDebug) { SendMessageToPC(oPC,"Checking Quest State against Requirement");	}
		// if we're not on the quest, drop nothing
		if ( CompareInts(nJournalEntry, sJournalReq) )
		{
			// make sure we don't have too many already
			nPartyItems = GetPartyNumItems(oPC,sDropTemplate);
			if (bDebug) { SendMessageToPC(oPC,"Number of items possesed by party are: "+IntToString(nPartyItems));}
			if (nPartyItems < nMaxItems || nMaxItems == 0)
			{
				if (bDebug) { SendMessageToPC(oPC,"Number of items in party is OK"); }
				if (bDrop == TRUE)
				{
					if (bDebug) { SendMessageToPC(oPC,"Dropping an item to the ground"); }
					CreateObject(OBJECT_TYPE_ITEM,sDropTemplate,GetLocation(OBJECT_SELF));
				}
				else if (bFeet == TRUE)
				{
					if (bDebug) { SendMessageToPC(oPC,"Dropping at PC feet"); }
					CreateObject(OBJECT_TYPE_ITEM,sDropTemplate,GetLocation(oPC));
					SendMessageToPC(oPC,"You feel something fall at your feet.");		
				}
				else
				{
					// create the object on the killer, should drop to ground on full inventory
					oItem = CreateItemOnObject(sDropTemplate,oPC);
					SendMessageToPC(oPC,"You seized an item from the corpse.");
				}
			}
		}
	}
	
	// do the journal bit
	if (sQuestName != "")
	{
		if (bDebug) { SendMessageToPC(oPC,"Checking Journal State");	}
		if ( CompareInts(nJournalEntry, sJournalReq) )
		{			
			// if all's well, advance everybody's journal
			AddJournalQuestEntry(sQuestName,nJournalAdv,oPC,TRUE);
			if (bDebug) { SendMessageToPC(oPC,"Advancing Journal");	}		
		}
	}	
	
	if (bQuestXP == TRUE)
	{
		if (bDebug) { SendMessageToPC(oPC,"Awarding XP");	}
		RewardPartyQuestXP(oPC, sQuestName);
	}
	
	// finally fire any additional custom stuff desired
	if (sCustomDeath != "")
		ExecuteScript(sCustomDeath, OBJECT_SELF);
}