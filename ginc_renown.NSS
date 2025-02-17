// ginc_renown WIP Wired 06/18/2010
// wired 09/29/2011 new scale for renown with 7 ranks and max 525 renown
/*

    todo
   
    hook pc deletion, renown should be subtracted from the faction on deletion
	get this showing on the PC character sheet

*/

#include "d2_sql"
#include "std_faction_i0"
#include "ginc_faction"
#include "std_quest_i0"

/************************************/
/* Constants                        */
/************************************/

const int bDEBUG			= FALSE;
const int OFFSET            = 2871;  // position of imperial feat in feats.2da
const int MAX_RENOWN		= 525;

const int METAFAC_IMPERIAL  = 1;
const int METAFAC_REBEL     = 2;
const int METAFAC_CANITE    = 3;

const string METAFAC_IMPERIAL_PROXY	= "d2_faction_imperial";
const string METAFAC_REBEL_PROXY    = "d2_faction_rebel";
const string METAFAC_CANITE_PROXY	= "d2_faction_canite";

//const int METAFAC_RANK_10	=	999;
//const int METAFAC_RANK_9	=	900;
//const int METAFAC_RANK_8	=	800;
//const int METAFAC_RANK_7	=	700;

const int METAFAC_RANK_6	=	500;
const int METAFAC_RANK_5	=	375;
const int METAFAC_RANK_4	=	250;
const int METAFAC_RANK_3	=	150;
const int METAFAC_RANK_2	=	75;
const int METAFAC_RANK_1	=	25;
const int METAFAC_RANK_0	=	0;

const string METAFAC_1_RANK_0    = "Fighter (1)";  
const string METAFAC_1_RANK_1    = "Warrior (2)";   
const string METAFAC_1_RANK_2    = "Veteran (3)";
const string METAFAC_1_RANK_3    = "Hero (4)";
const string METAFAC_1_RANK_4    = "Champion (5)";
const string METAFAC_1_RANK_5    = "Guardian (6)";
const string METAFAC_1_RANK_6    = "Vanquisher (MAX)";

//const string METAFAC_1_RANK_7    = "Warlord (8)";
//const string METAFAC_1_RANK_8    = "Warlord (9)";
//const string METAFAC_1_RANK_9    = "Warlord (10)";
//const string METAFAC_1_RANK_10   = "Warlord (MAX)";

const string METAFAC_2_RANK_0    = "Loyalist (1)";
const string METAFAC_2_RANK_1    = "Defender (2)";   
const string METAFAC_2_RANK_2    = "Veteran (3)";
const string METAFAC_2_RANK_3    = "Captain (4)";
const string METAFAC_2_RANK_4    = "Bannerman (5)";
const string METAFAC_2_RANK_5    = "Knight (6)";
const string METAFAC_2_RANK_6    = "Knight Protector (MAX)";

//const string METAFAC_2_RANK_7    = "Lord (8)";
//const string METAFAC_2_RANK_8    = "Lord (9)";
//const string METAFAC_2_RANK_9    = "Lord (10)";
//const string METAFAC_2_RANK_10   = "Lord (MAX)";

const string METAFAC_3_RANK_0    = "Sympathizer (1)";
const string METAFAC_3_RANK_1    = "Agent (2)";   
const string METAFAC_3_RANK_2    = "Saboteur (3)";
const string METAFAC_3_RANK_3    = "Slayer (4)";
const string METAFAC_3_RANK_4    = "Reaper (5)";
const string METAFAC_3_RANK_5    = "Dark Champion (6)";
const string METAFAC_3_RANK_6    = "Shadow Knight (MAX)";

//const string METAFAC_3_RANK_7    = "Lord Executioner (8)";
//const string METAFAC_3_RANK_8    = "Warlord (9)";
//const string METAFAC_3_RANK_9    = "Dark Champion (10)";
//const string METAFAC_3_RANK_10   = "Shadow Lord (MAX)";

/************************************/
/* Protypes                            */
/************************************/

// get the PC's renown
int getPCMetaFactionRenown(object oPC);

// get the PC's metafaction's renown
int getMetaFactionRenown(object oPC);

// the metafaction renown from metafaction #
int getRenownFromMetaFaction(int nMetaFac);

// return the name of the a metafaction
string getMetaFactionName(int nFac);

// set the PC's renown
void setPCMetaFactionRenown(object oPC, int nRenown);

// set the PC's metafaction's renown
void setMetaFactionRenown(int nMetaFactionID, int nRenown);

//    Move PC's renown up or down
//    Update a record for the faction while we're at it
//    Change Rank if necessary
void changePCMetaFactionRenown(object oPC, int nRenown);

//	Apply a change to a PC's entire party
void changePCPartyMetaFactionRenown(object oPC, int nRenown);

//    Get the PCs Meta Faction
int getMetaFaction(object oPC);

//    Set the PCs Meta Faction, Zero all renown, take feat, give feat
void setMetaFaction(object oPC, int nID);

//    Get Rank from Renown
int getRank(int nRenown);

//	  Get Name of Rank
string getRankName(int nFac, int nRenown);


/************************************/
/* Implementation                   */
/************************************/

int getMetaFactionRenown(object oPC)
{
    if (!GetIsObjectValid(oPC)) return 0;
	if (bDEBUG) SendMessageToPC(oPC,"getMetaFactionRenown()");
	
    string sSQL;
    int nRenown;
   
    sSQL =     "SELECT renown FROM metafactions WHERE id = "+ IntToString(getMetaFaction(oPC));
    SQLExecDirect(sSQL);       
    while (SQLFetch() == SQL_SUCCESS)
    {
        nRenown = StringToInt(SQLGetData(1));
    }
    return nRenown;       
}

// the metafaction renown from metafaction #
int getRenownFromMetaFaction(int nMetaFac)
{
	if (bDEBUG) SendMessageToPC(GetFirstPC(),"getMetaFactionRenown()");
	
    string sSQL;
    int nRenown;
   
    sSQL =     "SELECT SUM(renown) FROM pc_data WHERE metafaction = "+ IntToString(nMetaFac);
    SQLExecDirect(sSQL);       
    while (SQLFetch() == SQL_SUCCESS)
    {
        nRenown = StringToInt(SQLGetData(1));
    }
    return nRenown; 
}

int getPCMetaFactionRenown(object oPC)
{
    if (!GetIsObjectValid(oPC)) return 0;
   if (bDEBUG) SendMessageToPC(oPC,"getPCMetaFactionRenown()");
   
    string pcid = getPCid(oPC);
	
	if (pcid == "ERROR_OBJ_INVALID") return 0;
	
    string sSQL;
    int nRenown;
   
    sSQL =     "SELECT renown FROM pc_data WHERE pcid = "+pcid;
    SQLExecDirect(sSQL);       
    while (SQLFetch() == SQL_SUCCESS)
    {
        nRenown = StringToInt(SQLGetData(1));
    }
    return nRenown;
}

string getMetaFactionName(int nFac)
{
	switch (nFac)
	{
		case 1:
			return "Varanite";
		break;
		case 2:
			return "Dasarian";
		break;
		case 3:
			return "Canite";
		break;
	}
	return "NONE";
}

void setMetaFactionRenown(int nID, int nRenown)
{
    string sSQL;
   
    sSQL =     "UPDATE metafactions SET renown = "+IntToString(nRenown)+" WHERE id = " + IntToString(nID);
    SQLExecDirect(sSQL);       
}

void setPCMetaFactionRenown(object oPC, int nRenown)
{
    if (!GetIsObjectValid(oPC)) return;
    if (bDEBUG) SendMessageToPC(oPC,"setPCMetaFactionRenown()");
	
    string pcid = getPCid(oPC);
	if (pcid == "ERROR_OBJ_INVALID") return;
    string sSQL;
   
    sSQL =     "UPDATE pc_data SET renown = "+IntToString(nRenown)+" WHERE pcid = " + pcid;
    SQLExecDirect(sSQL);       
    if (    SQLGetAffectedRows() != 1    )
    {
        SendMessageToPC(oPC,"Something terrible happened.  Could not update record " + pcid);
    }
	else
	{
		SendMessageToPC(oPC,"You now have "+IntToString(nRenown)+" renown");
	}
   
    // update the faction record
    setMetaFactionRenown(getMetaFaction(oPC), getMetaFactionRenown(oPC) + nRenown);
}

void changePCMetaFactionRenown(object oPC, int nRenown)
{
	int nCurRenown;
	int nNewRenown;
	
	nCurRenown = getPCMetaFactionRenown(oPC);
	nNewRenown = nCurRenown + nRenown;
	
	if (nRenown > 0 && nNewRenown > MAX_RENOWN)
	{
		SendMessageToPC(oPC,"You have maximum renown and can gain no more.");
		return;
	}
	
    setPCMetaFactionRenown(oPC, nNewRenown);
	
	if (nRenown < 0)
	{
		SendMessageToPC(oPC,"Your renown has DECREASED by "+IntToString(nRenown)+", as has that of your faction.");
	}
	else
	{
		SendMessageToPC(oPC,"Your renown has INCREASED by "+IntToString(nRenown)+", as has that of your faction.");
	}
}

void changePCPartyMetaFactionRenown(object oPC, int nRenown)
{
	object oMember = GetFirstFactionMember(oPC,TRUE);
	while (GetIsObjectValid(oMember))
	{
		changePCMetaFactionRenown(oMember, nRenown);
	
		oMember = GetNextFactionMember(oPC,TRUE);	
	}
}

int getMetaFaction(object oPC)
{
    if (!GetIsObjectValid(oPC)) return -1;
	if (bDEBUG) SendMessageToPC(oPC,"getMetaFaction()");
	
	// REMOVE ME? Workaround for test
	//int nMeta = GetJournalEntry("mf_tracker",oPC);
	//if (nMeta > 0) return nMeta;
	// REMOVE ME
	
	// check feat first
	if (GetHasFeat(OFFSET,oPC)) return 1;
	if (GetHasFeat(OFFSET+1,oPC)) return 2;
	if (GetHasFeat(OFFSET+2,oPC)) return 3;
	
	// then go to SQL if necessary
	int nMetaFaction = -1;
    string pcid = getPCid(oPC);
	
	if (pcid == "ERROR_OBJ_INVALID") return -1;	
	
    string sSQL;
   
    sSQL =     "SELECT metafaction FROM pc_data WHERE pcid = " + pcid;
    SQLExecDirect(sSQL);       
	while (SQLFetch() == SQL_SUCCESS)
    {
       nMetaFaction = StringToInt(SQLGetData(1));
    }
	
	// if we're over here they didn't have the feat, so give it back
	FeatAdd(oPC,OFFSET+nMetaFaction-1,FALSE,TRUE,TRUE);
	return nMetaFaction;
}

//    Set the PCs Meta Faction, Zero all renown, take feat, give feat
void setMetaFaction(object oPC, int nID)
{
    if (!GetIsObjectValid(oPC)) return;
   	if (bDEBUG) SendMessageToPC(oPC,"setMetaFaction() to "+IntToString(nID));
   
	// REMOVE ME? Workaround for test
	//persist_advance_single( oPC, "mf_tracker", 0, nID, 0, "" );
	
	string sSQL;
    string pcid        	= getPCid(oPC);
	
	if (pcid == "ERROR_OBJ_INVALID") return;
	
    int nCurFac        	= getMetaFaction(oPC);
    int nCurRenown   	= getPCMetaFactionRenown(oPC);
	int nFeatAdd		= OFFSET+nID-1;
	int nFeatRemove		= OFFSET+nCurFac-1;
	//setMetaFactionRenown(getMetaFaction(oPC), getMetaFactionRenown(oPC) - getPCMetaFactionRenown(oPC));
	
	if (nCurFac == nID) return;  // if we're re-joining our own faction, something is fubared
	
	// skip the faction leave if PC is not already in one
	// or if for some reason (error condition) pc 
	// has a faction in the db but no feats	
    if (nCurFac != 0 && nCurFac != nID)
    {
	    // subtract renown from the old faction, if there was one
        setMetaFactionRenown(nCurFac, getMetaFactionRenown(oPC) - getPCMetaFactionRenown(oPC));
        FeatRemove(oPC,nFeatRemove);
		SendMessageToPC(oPC,"You have left the "+getMetaFactionName(nCurFac)+" faction.");
    }
   
    // update the table
    sSQL =     "UPDATE pc_data SET renown = 0, metafaction = "+IntToString(nID) +" WHERE pcid = " + pcid;
    SQLExecDirect(sSQL);       
    if (    SQLGetAffectedRows() == 1    )
    {
		FeatAdd(oPC,nFeatAdd,FALSE,TRUE,TRUE);
		SendMessageToPC(oPC,"You have joined the "+getMetaFactionName(nID)+" faction.");	
    }
    else
    {
        SendMessageToPC(oPC,"setMetaFaction: Something terrible happened.  Could not update record " + pcid);
    }
}

int getRank(int nRenown)
{
	if (nRenown >= METAFAC_RANK_6) return 6;
	if (nRenown >= METAFAC_RANK_5) return 5;
	if (nRenown >= METAFAC_RANK_4) return 4;
	if (nRenown >= METAFAC_RANK_3) return 3;
	if (nRenown >= METAFAC_RANK_2) return 2;
	if (nRenown >= METAFAC_RANK_1) return 1;
	else return 0;
}

int getMinRenownFromRank(int nRank)
{
	if (nRank > 6) return METAFAC_RANK_6;
	if (nRank == 6) return METAFAC_RANK_6;
	if (nRank == 5) return METAFAC_RANK_5;
	if (nRank == 4) return METAFAC_RANK_4;
	if (nRank == 3) return METAFAC_RANK_3;
	if (nRank == 2) return METAFAC_RANK_2;
	if (nRank == 1) return METAFAC_RANK_1;
	else 			return METAFAC_RANK_0;
}

int getNeededToLevel(int nRank)
{
	switch (nRank)
	{
		case 7:										// one user may be looking for renown to NEXT level
		case 6:										// i don't need any more renown because i'm MAX
			return 0;								// 0
		case 5:
			return METAFAC_RANK_6 - METAFAC_RANK_5;	// 500 - 375 = 125
		case 4:
			return METAFAC_RANK_5 - METAFAC_RANK_4; // 375 - 250 = 125
		case 3:
			return METAFAC_RANK_4 - METAFAC_RANK_3; // 250 - 150 = 100
		case 2:
			return METAFAC_RANK_3 - METAFAC_RANK_2; // 150 - 75 = 75
		case 1:
			return METAFAC_RANK_2 - METAFAC_RANK_1; // 75 - 25 = 50
		case 0:
		default:
			return METAFAC_RANK_1;					// 25										
	}
	return METAFAC_RANK_1;
}


string getRankName(int nFac, int nRenown)
{
	switch (nFac)
	{
		case 1:		
			/*
			if (nRenown >= METAFAC_RANK_10) return METAFAC_1_RANK_10;		
			if (nRenown >= METAFAC_RANK_9) return METAFAC_1_RANK_9;
			if (nRenown >= METAFAC_RANK_8) return METAFAC_1_RANK_8;
			if (nRenown >= METAFAC_RANK_7) return METAFAC_1_RANK_7;
			*/
			if (nRenown >= METAFAC_RANK_6) return METAFAC_1_RANK_6;	
			if (nRenown >= METAFAC_RANK_5) return METAFAC_1_RANK_5;
			if (nRenown >= METAFAC_RANK_4) return METAFAC_1_RANK_4;
			if (nRenown >= METAFAC_RANK_3) return METAFAC_1_RANK_3;
			if (nRenown >= METAFAC_RANK_2) return METAFAC_1_RANK_2;
			if (nRenown >= METAFAC_RANK_1) return METAFAC_1_RANK_1;
			return METAFAC_1_RANK_0;
		break;
		
		case 2:
			/*
			if (nRenown >= METAFAC_RANK_10) return METAFAC_2_RANK_10;		
			if (nRenown >= METAFAC_RANK_9) return METAFAC_2_RANK_9;
			if (nRenown >= METAFAC_RANK_8) return METAFAC_2_RANK_8;
			if (nRenown >= METAFAC_RANK_7) return METAFAC_2_RANK_7;
			*/
			if (nRenown >= METAFAC_RANK_6) return METAFAC_2_RANK_6;			
			if (nRenown >= METAFAC_RANK_5) return METAFAC_2_RANK_5;
			if (nRenown >= METAFAC_RANK_4) return METAFAC_2_RANK_4;
			if (nRenown >= METAFAC_RANK_3) return METAFAC_2_RANK_3;
			if (nRenown >= METAFAC_RANK_2) return METAFAC_2_RANK_2;
			if (nRenown >= METAFAC_RANK_1) return METAFAC_2_RANK_1;
			return METAFAC_2_RANK_0;
		break;
		
		case 3:
			/*
			if (nRenown >= METAFAC_RANK_10) return METAFAC_3_RANK_10;		
			if (nRenown >= METAFAC_RANK_9) return METAFAC_3_RANK_9;
			if (nRenown >= METAFAC_RANK_8) return METAFAC_3_RANK_8;
			if (nRenown >= METAFAC_RANK_7) return METAFAC_3_RANK_7;
			*/
			if (nRenown >= METAFAC_RANK_6) return METAFAC_3_RANK_6;		
			if (nRenown >= METAFAC_RANK_5) return METAFAC_3_RANK_5;
			if (nRenown >= METAFAC_RANK_4) return METAFAC_3_RANK_4;
			if (nRenown >= METAFAC_RANK_3) return METAFAC_3_RANK_3;
			if (nRenown >= METAFAC_RANK_2) return METAFAC_3_RANK_2;
			if (nRenown >= METAFAC_RANK_1) return METAFAC_3_RANK_1;
			return METAFAC_3_RANK_0;
		break;
				
	}
	return "Error";	
}

/*

void main()
{
}

*/