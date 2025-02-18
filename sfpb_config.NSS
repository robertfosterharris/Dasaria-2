//::///////////////////////////////////////////////
//:: Scarface's Persistent Banking
//:: sfpb_config
//:://////////////////////////////////////////////
/*
    Written By Scarface
*/
//////////////////////////////////////////////////

/* WARNING!!!!! Please Read...

   If any changes are made to this script, you must
   use the "Build Module" option in toolset and check
   the "Scripts" box in order to compile (build) all
   scripts, failing to do so will result in any changes
   in thi sscript being overwritten back to its original
   state.....
*/

// Set this TRUE if you want the banking system to use
// the players CD Key, or FALSE to use the players
// account name.
// I recommend using the players CD Keys, it is a much
// secure option.
const int USE_CD_KEY = TRUE;

// Do you want players to be able to share items and gold
// between their own characters....
// If this is set TRUE, then players will be able to retrieve
// their items and gold with any of their own characters, if set
// FALSE, then they will only be able to retrieve items or gold
// that were saved on particular characters.
const int CHARACTER_SHARING = FALSE;

// Set the maximum amount of items allowed to be stored
// per player. I strongly recommend setting this no higher
// than 100. I cannot garuntee the system will function without
// any ill effects if you exceed this.
const int MAX_ITEMS = 75;

////////////////////////////////////////////////////////////////////////////////
// DO NOT TOUCH ANY FUNCTIONS OR CONSANTS BELOW THIS LINE!!!!!!!
////////////////////////////////////////////////////////////////////////////////
//
//	ROBERT HARRIS	03/26/2008	CREATED AND USED sID2 FROM INFORMATION STORED IN THE ADVENTURER'S JOURNAL
//								INORDER TO RETAIN ITEMS AFTER CD, PLAYER NAME OR CHARACTER NAME CHANGES
//								FOR EXAMPLE - FLEET PROMOTIONS

const string DATABASE_GOLD = "SFPB_GOLD_";
const string DATABASE_ITEM = "SFPB_ITEM_";

#include "std_persist_i0"

string SF_GetPlayerID(object oPC)
{
	object oJournal;
    string sID;
	string sID2;
	
	oJournal = std_journal_get(oPC);
	
    if (USE_CD_KEY)
	{
        sID = GetPCPublicCDKey(oPC);
		sID2 = GetLocalString(oJournal, "PCPublicCDKey");
	}		
    else
	{
        sID = GetPCPlayerName(oPC);
		sID2 = GetLocalString(oJournal, "PCPlayerName");
	}		
    if (!CHARACTER_SHARING)
	{
        sID += "_" + GetName(oPC);
		sID2 += "_" + GetLocalString(oJournal, "Name");
	}
//	if (sID != sID2)	//	TESTING FAILSAFE - FALL BACK TO ORIGINAL ID
//	{
//		WriteTimestampedLogEntry("ERROR: BANK IDS DO NOT MATCH ID1 = " + sID + " ID2 = " + sID2);
//		sID2 = sID;
//	}		
    return GetSubString(sID2, 0, 20);
}

////////////////////////////////////////////////////////////////////////////////