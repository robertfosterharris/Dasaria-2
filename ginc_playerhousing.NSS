// 	Name     : ginc_playerhousing
// 	Purpose  : Scripting functions for Dasaria2 Player Housing
// 	Author   : Wired
// 	Modified : 04/30/2010
//
//	TODO: Integrate this with the faction system
// wired 08/12/2011 replace uses of GetIsLocationValid(location) with  GetIsObjectValid(GetAreaFromLocation(location))
// wired 2013/03/24 line 566 skip reference area and go straight to a copy
// wires 2013/09/07 make max # of placeables = 75*area height

#include "x0_i0_position"
#include "d2_sql"
#include "std_enviro_torch_i0"
#include "sfpb_config"

/************************************/
/* Constants                        */
/************************************/

const int DEBUG = FALSE;

const int PH_CLASS1_PRICE = 50000;		// 1x1 std
const int PH_CLASS2_PRICE = 100000;		// 2x2 std
const int PH_CLASS3_PRICE = 250000;		// 3x5 std
const int PH_CLASS4_PRICE = 100000;		// 2x2 cave

const float fReSaleValue = 0.5;			// % of original value NPC will pay to re-purchase home 
const int PH_MAX_PLC = 75;				// base maximum # of placeables to allow in an area

const string SWEEPER = "j4acs_ha_exit";	// name of sweeper script

/************************************/
/* Function prototypes              */
/************************************/

// Returns the price of certain class of home
int GetPrice(int class);

// Set Price Tokens
void SetPHPriceTokens();

// Checks if PC already owns home here
int CheckHome(object oPC, string sDoorTag);

// Checks if anybody else on the server is using this door
int CountOccupants();

// Checks if PC has enough gold in bank to purchase home
int CheckGold(object oPC, int nClass);

// Purchase home for PC
void BuyHome(object oPC, string sDoorTag, int class);

// Sell home for PC
void SellHome(object oPC, string sDoorTag);

// Transfer home from one PC to another (TBD)
void XferHome(object oSeller, object oBuyer, string sDoorTag, int class);

// you can't copy a copy, so always record the original area object
// on the module, we'll always use this original area to create
// instances and on which to store the number of extant instances
object GetReferenceArea( string sRef);

// test validity of location as if Z value were 0.0
// nb: stops us from crashing the server with an invalid
// location; doesn't mean this is a good place to put something
int TestValidLocation(location lTarget);

// bumps a location into valid walkmesh space
location FindValidWalkMeshLocation(location lNew, object oPC);

// Jumps to PC and eligible partymembers into Area
void HomeEnterArea(object oArea, object oPC, string sDoorTag);

// Sends a 'knock' to PCs in an occupied area
//void Knock(object oPC, object oDoor);

// Sends a 'knock' to a specific PC
void RingOwner(object oOwner, object oRinger);

// Allows owner-PC to answer a knock
void FriendInvite(object oOwner, object oFriend);

// Jumps a PC back to the location from which they entered
void HomeExitArea(object oPC);

// Looks for an available area based on the location and class of housing
// Can be placed on the OnFailToOpen() of a Door, OnUsed() of placeable, OnEnter() of trigger
void HomeFindArea(object oPC);

// some helper functions for HomeOCE
void KickMeOut(object oPC);
int IsOwnerHome(object oOwner, object oArea);
void KickIfOwnerNotHome(object oOwner, object oArea);

// OnClientEnter() event for a player-owned home
// ejects unauthorized entry, sets up home, generates the player's stored furniture
void HomeOCE();

// OnExit() event for a player-owned home
// kicks everyone besides PC out, breaks down home
void HomeOnExit(object oPC);

// set all furniture usable
void HomeReset(object oPC);

// return a location directly above or below the target
location GetAboveBelowLocation(object oTarget, float fDist);

// moves a placeable x,y, or z, or rotates
// updates vector and facing in db
// iType			iDist
// 1=forward		1 SHORT
// 2=back			2 MEDIUM
// 3=left
// 4=right
// 5=up/down
void MoveDecor(object oPlc, object oPC, int iType, float fDist = 1.0f );

// accepts a facing and converts to the nearest 45 degree angle 
float squareFacing(float fFacing);

// places a decor item in the room (or on an object if supported)
// saves to db resref, vector, facing under room owner's name
void PlaceDecor(object oItem, object oPC, location lLoc, object oTarget = OBJECT_INVALID);

/************************************/
/* Implementation                   */
/************************************/

int GetPrice(int class)
{
	int nPrice = 0;
	
	switch (class)
	{
		case 1: nPrice = PH_CLASS1_PRICE; break;
		case 2: nPrice = PH_CLASS2_PRICE; break;
		case 3: nPrice = PH_CLASS3_PRICE; break;
		case 4: nPrice = PH_CLASS4_PRICE; break;
		default:
			nPrice = 0;
	}
	return nPrice;
}

void SetPHPriceTokens()
{
	SetCustomToken(7034691,IntToString(GetPrice(1)));
	SetCustomToken(7034692,IntToString(GetPrice(2)));
	SetCustomToken(7034693,IntToString(GetPrice(3)));
	SetCustomToken(7034694,IntToString(GetPrice(4)));
	SetCustomToken(7034695,IntToString(GetPrice(5)));
	SetCustomToken(7034696,IntToString(GetPrice(6)));
	SetCustomToken(7034697,IntToString(GetPrice(7)));
}

int CheckHome(object oPC, string sDoorTag)
{
	string sSQL;
	string pcid = getPCid(oPC);	
	
	if (pcid == "ERROR_OBJ_INVALID") return FALSE;
	
	sSQL = 	"SELECT pcid FROM ph_records WHERE pcid = "+pcid+" AND doortag = '"+sDoorTag+"'";
	SQLExecDirect(sSQL);
	if (SQLFetch() == SQL_SUCCESS)
	{
		return TRUE;
	}
	return FALSE;	
}

int CountOccupants()
{
	int i = 0;
	int nToken = 7034700;	
	string sDoorTag = GetTag(OBJECT_SELF);
	string sName;
	object oArea;
	string sAreaName;
	object oTarget = GetFirstPC();
	
	while(GetIsObjectValid(oTarget))
	{
		sName = GetName(oTarget);
		oArea = GetArea(oTarget);
		sAreaName = GetName(oArea);
		if (DEBUG) { SendMessageToAllDMs(sName + " is in "+ sAreaName); }
		
		if ( GetLocalString(oArea,"sDoorTag") == sDoorTag && oTarget == GetLocalObject(oArea,"oOwner") )
		{
			if (DEBUG) { SendMessageToAllDMs(sName + " is in the target population"); }
			
			i = i+1;
			
			nToken = nToken+1;
			SetCustomToken(nToken,GetName(oTarget));
			SetLocalObject(OBJECT_SELF,IntToString(nToken),oTarget);
		}
		else
		{
			if (DEBUG) {  SendMessageToAllDMs(sName + " is NOT in the target population"); }
		}
		
		
		oTarget = GetNextPC();
	}
	
	SetLocalInt(OBJECT_SELF,"nOccupants",i);	
	return i;
}

int CheckGold(object oPC, int nClass)
{
    // Vars
    string sID = SF_GetPlayerID(oPC);
    int nGold;
	
	nGold = GetPrice(nClass);	
		
    int nBanked = GetCampaignInt(GetName(GetModule()), "SFPB_GOLD_" + sID);

    // Check if the player has enough to withdraw
    return(nBanked >= nGold);
}

void BuyHome(object oPC, string sDoorTag, int class)
{
	string sSQL;
	string pcid = getPCid(oPC);
	
	if (pcid == "ERROR_OBJ_INVALID") return;
	
	string sID = SF_GetPlayerID(oPC);
	int nPrice = GetPrice(class);
	int nBanked = GetCampaignInt(GetName(GetModule()), DATABASE_GOLD + sID);	
	int nTotal;
	
	if (CheckHome(oPC, sDoorTag))
	{
		SendMessageToPC(oPC,"You already own a home in this area.");
		return;
	}
	
	if (nBanked >= nPrice)
	{
		sSQL = 	"INSERT INTO ph_records (pcid,doortag,class) VALUES ("+pcid+",'"+sDoorTag+"',"+IntToString(class)+")";
		SQLExecDirect(sSQL);
		if (DEBUG) SendMessageToPC(oPC,sSQL);
		
		if (SQLGetAffectedRows() > 0)
		{
			SendMessageToPC(oPC,"Home Purchased");
			//TakeGoldFromCreature(nPrice,oPC,TRUE,TRUE);
			
			// Subtract the amount from player's gold and store in the database
   			nTotal = nBanked - nPrice;
    		SetCampaignInt(GetName(GetModule()), DATABASE_GOLD + sID, nTotal);
		}	
		else
		{
			SendMessageToPC(oPC,"INSERT FAILED");
		}
	}
	else
	{
		SendMessageToPC(oPC,"You do not have enough gold on deposit in the bank to afford this home.");
	}	
}

void SellHome(object oPC, string sDoorTag)
{
	string sSQL;
	string pcid = getPCid(oPC);	
	if (pcid == "ERROR_OBJ_INVALID") return;
	
	int nGold;
	int nClass;
	int nTotal;
	string sID 	= SF_GetPlayerID(oPC);
	int nBanked = GetCampaignInt(GetName(GetModule()), DATABASE_GOLD + sID);
	
	// if they have a home here
	if (CheckHome(oPC, sDoorTag))
	{		
		// find out what class it is
		sSQL = 	"SELECT class FROM ph_records WHERE pcid = "+pcid+" AND doortag = '"+sDoorTag+"'";
		SQLExecDirect(sSQL);		
		while (SQLFetch() == SQL_SUCCESS)
		{
			nClass = StringToInt(SQLGetData(1));
		}
		
		// then look up the cost of the class less % resale value
		nGold = GetPrice(nClass) - FloatToInt(GetPrice(nClass)*(1-fReSaleValue));	

		sSQL = 	"DELETE FROM ph_records WHERE pcid = "+pcid+" AND doortag = '"+sDoorTag+"'";
		SQLExecDirect(sSQL);		
		
		//GiveGoldToCreature(oPC,nGold);
		if (SQLGetAffectedRows() == 1)
		{		    
        	nTotal = nGold + nBanked;
        	SetCampaignInt(GetName(GetModule()), DATABASE_GOLD + sID, nTotal);
			SendMessageToPC(oPC,"The proceeds from this sale have been placed on deposit in the bank.");
		}
	}	
}

object GetReferenceArea( string sRef)
{
	object oArea = GetLocalObject(GetModule(), sRef);
	//
	if( !GetIsObjectValid( oArea ) ){
		//
		oArea = GetObjectByTag(sRef);
		//
		SetLocalObject( GetModule(), sRef, oArea ) ;
		//
	}
	return oArea;
}

int TestValidLocation(location lTarget)
{
	location lTest;
	vector vTest = GetPositionFromLocation(lTarget);
	float fFacing = GetFacingFromLocation(lTarget);
	vTest.z = 0.0f;
	lTest	= Location(	GetAreaFromLocation(lTarget),vTest,fFacing);
	if (GetIsObjectValid( GetAreaFromLocation(lTest) ) )	
	{
		return TRUE;
	}
	else
	{
		return FALSE;
	}
}

location FindValidWalkMeshLocation(location lTarget, object oPC)
{
	location lTest;		// target @ .z=0
	location lSafe;		// caculated safe location
	location lValid;	// modified return location

	vector vTarget = GetPositionFromLocation(lTarget);	
	vector vTest = GetPositionFromLocation(lTarget);
	vector vSafe;
	vector vValid;	
	float fFacing = GetFacingFromLocation(lTarget);
	
	float fSafeFacing;
	
	vTest.z = 0.0f;
	lTest	= Location(	GetAreaFromLocation(lTarget),vTest,fFacing);
	
	lSafe = CalcSafeLocation(oPC,lTest,1.0,TRUE,FALSE);
	
	// flattened target location == nearest safe location
	if ( lSafe == lTest)
	{
		//  original target location was ok, return that
		return lTarget;
	}
	else
	{
		// start with location lSafe and swap orignal vTarget.z (height) into that vector
		vSafe = GetPositionFromLocation(lSafe);
		vSafe.z = vTarget.z; 
		
		// create new location using safe area, revised vector, safe facing
		lValid	= Location(	GetAreaFromLocation(lSafe),vSafe,GetFacingFromLocation(lSafe));
		
		// return that bad boy as a valid location target
		return lValid;		
	}

}

void HomeEnterArea(object oArea, object oPC, string sDoorTag)
{
	if (DEBUG) SendMessageToPC(oPC,"DEBUG: In HomeEnterArea()");
	
	object oMember;
	object oWP;
	object oTest;
	string sMessage;
	location lPC;
	
	// there should only be one waypoint in each room
    oTest = GetFirstObjectInArea(oArea);
    while(GetIsObjectValid(oTest))
    {
         if(GetObjectType(oTest) == OBJECT_TYPE_WAYPOINT)
         {
             oWP = oTest;
         }
         oTest = GetNextObjectInArea(oArea);
    }
		
	if (!GetIsObjectValid(oArea))
	{
		SendMessageToPC(oPC,"DEBUG: Invalid Area!");
		return;
	}
	if (!GetIsObjectValid(oWP))
	{
		SendMessageToPC(oPC,"DEBUG: Invalid WP!");
		return;
	}
	
	// set the area busy
	SetLocalInt(oArea,"bInUse",TRUE);
	
	// asociate the room with the pc
	SetLocalObject(oArea,"oOwner",oPC);	
		
	// associate door (location) with room
	// because this tells the room where
	// to store the furniture back to when
	// the owner exits
	SetLocalString(oArea,"sDoorTag",sDoorTag);
	
	// jump the owner, worry about faction members later
	lPC = GetLocation(oPC);
	DelayCommand(1.0f,AssignCommand(oPC,JumpToObject(oWP)));
	
	// store pc current location on the room (this will be the area's exit)
	// jump me and anyone in my party w/i 20m
	//
	oMember = GetFirstFactionMember(oPC);
	
	while (GetIsObjectValid(oMember))
	{
		// getdistancebetween will return 0 if the two aren't 
		// in the same area, so add an area check to this
		if (GetAreaFromLocation(lPC) == GetArea(oMember) && GetDistanceBetweenLocations(lPC,GetLocation(oMember)) < 20.0f)
		{		
			SetLocalLocation(oMember,"lExit",CalcSafeLocation(oMember,GetOppositeLocation(oMember,0.0f),1.0,TRUE,FALSE));
			if (DEBUG) SendMessageToPC(oMember,"DEBUG: Porting Faction Member.");
			
			if (oMember != oPC)	
			{
				SetLocalObject(oMember,"oDest",oWP);
				sMessage = "You have been invited into the home of "+GetName(oPC)+".  Enter?";
					DelayCommand(1.5f,DisplayMessageBox( oMember, 0, sMessage, "gui_ph_follow", "", TRUE));
			}				
		}
		oMember = GetNextFactionMember(oPC);
	}
}

/*
void Knock(object oPC, object oDoor)
{
	object oArea;
	object oTest = GetFirstPC();
	string sDoorTag = GetTag(oDoor);
	string sMessage;
	
	while (GetIsObjectValid(oTest))
	{
		oArea = GetArea(oTest);
		
		// this PC is at a location behind sDoorTag and they are the owner
		if ( GetLocalString(oArea,"sDoorTag") == sDoorTag && oTest == GetLocalObject(oArea,"oOwner") )
		{
			// send oTest a knock
			sMessage = GetName(oPC)+" is knocking on your door. Allow them to enter?";
			SetLocalObject(oTest,"oKnocker",oPC);
			DelayCommand(1.5f,DisplayMessageBox( oTest, 0, sMessage, "gui_ph_knock", "", TRUE));		
		}
		oTest = GetNextPC();
	}
}
*/

void RingOwner(object oOwner, object oRinger)
{

	if (!GetIsObjectValid(oOwner) || !GetIsObjectValid(oRinger))
	{
		if (DEBUG) SendMessageToPC(GetFirstPC(),"Invalid object passed to RingOwner");
		
	 	return;
	}

	if (DEBUG) SendMessageToPC(oRinger,"Sending ring to "+GetName(oOwner));
	
	string sSexPronoun = "him";
	if (GetGender(oRinger) == 1) sSexPronoun = "her";
	string sMessage;
	
	sMessage = GetName(oRinger)+" is knocking on your door. Allow "+sSexPronoun+" to enter?";
	
	SetLocalObject(oOwner,"oKnocker",oRinger);
	
	DelayCommand(1.5f,DisplayMessageBox( oOwner, 0, sMessage, "gui_ph_knock", "", TRUE));
}

void FriendInvite(object oOwner, object oFriend)	
{
	//string sDoorTag = GetLocalString(GetArea(oOwner),"sDoorTag");	
	//object oEnter = GetObjectByTag(sDoorTag);
	
	if (DEBUG) SendMessageToPC(oOwner,"FriendInvite() by "+GetName(oOwner)+" to "+GetName(oFriend));
	
	object oExit = GetNearestObjectByTag("ph_exit", oOwner);
	//location lExit;
	
	SetLocalLocation(oFriend,"lExit",CalcSafeLocation(oFriend,GetOppositeLocation(oFriend,0.0f),1.0,TRUE,FALSE));	
	
	RemoveFromParty(oFriend);
	AddToParty(oFriend,oOwner);
	
	if (GetIsObjectValid(oExit))
	{
		DelayCommand(2.0,SendMessageToPC(oFriend,"You are admitted to the home of "+GetName(oOwner)));
		DelayCommand(3.0,AssignCommand(oFriend,JumpToObject(oExit)));
	}
}

/*
void FriendInvite(object oOwner, object oFriend)	
{
	if (DEBUG) SendMessageToPC(oOwner,"DEBUG: FriendInvite()");
	
	if (!GetIsObjectValid(oOwner) || !GetIsObjectValid(oFriend) ) return;
	
	string sDoorTag;
	location lPC;
	float fDistance;
	object oEnter;
	object oExit;
	string sMessage;
	
	sDoorTag = GetLocalString(GetArea(oOwner),"sDoorTag");
	
	oEnter = GetObjectByTag(sDoorTag);
	oExit = GetNearestObjectByTag("ph_exit", oOwner);
	
	if (!GetIsObjectValid(oEnter) || !GetIsObjectValid(oExit))
	{
		if (DEBUG) SendMessageToPC(oFriend,"DEBUG: Either the entry or exit point were invalid.");
	}
	
	fDistance = GetDistanceBetween(oEnter,oFriend);
	
	if ( fDistance < 20.0f && GetArea(oEnter) == GetArea(oFriend) )
	{		
		SetLocalLocation(oFriend,"lExit",CalcSafeLocation(oFriend,GetOppositeLocation(oFriend,0.0f),1.0,TRUE,FALSE));
		if (DEBUG) SendMessageToPC(oFriend,"DEBUG: You are being invited in.");
			
		SetLocalObject(oFriend,"oDest",oExit);
		SetLocalObject(oFriend,"oOwner",oOwner);
		sMessage = "You have been invited the home of "+GetName(oOwner)+".  Enter?";
		DelayCommand(1.5f,DisplayMessageBox( oFriend, 0, sMessage, "gui_ph_follow", "", TRUE));		
	}
}
*/


void HomeFindArea(object oPC)
{	
	object oInstance;
	string sDoorTag = GetTag(OBJECT_SELF);
	object oArea;
	string pcid;
	string sSQL;
	string sTag;
	int nInstances;
	int i; // counter
	
	if (DEBUG) SendMessageToPC(oPC,"Starting HomeFindArea()");
	
	// am i the owner of an area here?
	pcid = getPCid(oPC);
	
	if (pcid == "ERROR_OBJ_INVALID") return;
	
	sSQL = "SELECT class FROM ph_records WHERE pcid = "+pcid+" AND doortag ='"+sDoorTag+"'";
	if (DEBUG) SendMessageToPC(oPC,"DEBUG: Query was: "+sSQL);
	
	SQLExecDirect(sSQL);
	
	while (SQLFetch() == SQL_SUCCESS)
	{
		string sClass = SQLGetData(1);
		sTag = "ph_"+sClass;

		/* 
		
		SendMessageToPC(oPC,"DEBUG: LIST OF AREAS");
		object oA = GetFirstArea();
		while( GetIsObjectValid( oA ) ) 
		 {
			SendMessageToPC(GetFirstPC(), "area list :: " + GetTag(oA) );
			oA = GetNextArea();
		 }
		 
		 */
		
		 if (DEBUG) SendMessageToPC(oPC,"DEBUG: Looking for area tagged "+sTag);
		
		// grab the first area and see how many are out there
		oArea = GetReferenceArea( sTag );
		nInstances = GetLocalInt(oArea,"nInstances");
		if (DEBUG) SendMessageToPC(oPC,"DEBUG: "+IntToString(nInstances+1)+" instances of this area exist.");
		
		/*  wired 2013/03/24: skip reference area and go straight to a copy
		oInstance = GetObjectByTag(sTag);
		if (GetLocalInt(oInstance,"bInUse") != 1)
		{
			// first instance found is free, go there
			if (DEBUG) SendMessageToPC(oPC,"DEBUG: The first one is free, we're going there.");
			
			HomeEnterArea(oInstance,oPC,sDoorTag);
			return;
		}
		else
		{
		*/
			// loop around looking for an alternative free instance
			for (i = 1; i <= nInstances; i++)
			{		
				oInstance = GetObjectByTag(sTag,i);
				
				if (!GetIsObjectValid(oInstance))
				{
					SendMessageToPC(oPC,"DEBUG: INVALID AREA!");
				}
				if (GetLocalInt(oInstance,"bInUse") != 1)
				{
					// we found a free area, so go there
					if (DEBUG) SendMessageToPC(oPC,"DEBUG: Located available instance: "+GetTag(oInstance));
					
					HomeEnterArea(oInstance,oPC,sDoorTag);
					return;
				}
				if (DEBUG) SendMessageToPC(oPC,"DEBUG: Area "+GetTag(oInstance)+","+IntToString(i)+" reports bInUse "+IntToString(GetLocalInt(oInstance,"bInUse")));
			}
		//}

		// if we made it this far, all areas are busy, make one
		// tell the first area it has a new instance
		SetLocalInt(oArea,"nInstances",nInstances+1);
		// create that instance
		oInstance = CreateInstancedAreaFromSource(oArea);
		
		if (DEBUG) SendMessageToPC(oPC,"DEBUG: Could not find an available instance, making one.");
		
		// act like normal
		HomeEnterArea(oInstance,oPC,sDoorTag);		
		return;
	}
	SendMessageToPC(oPC,"You do not have a key to this area.");
}

void KickMeOut(object oPC)
{
	location lExit = GetLocalLocation(oPC,"lExit");
	if (!GetIsObjectValid( GetAreaFromLocation(lExit) ) ) lExit = GetStartingLocation();		
		
	// kick me out, i can re-enter later if i really belong
	AssignCommand(oPC,	JumpToLocation(lExit));
	SendMessageToPC(oPC,"You will be required to re-enter");	
}

int IsOwnerHome(object oOwner, object oArea)
{
	if (GetArea(oOwner) == oArea)
	{
		return TRUE;
	}
	return FALSE;
}

void KickIfOwnerNotHome(object oOwner, object oArea)
{
	if (!IsOwnerHome(oOwner,oArea))
	{
		KickMeOut(OBJECT_SELF);
	}
}

void HomeOCE()
{
	object oPC = GetEnteringObject();
	object oPlc;
	object oOwner;
	object oArea = OBJECT_SELF;
	string sSQL;
	int nID;
	int nCount = 0;
	string sResRef;
	string sDoorTag;
	vector vVec;
	float fFacing;
	location lLoc;
	location lExit;
	int nMaxObjects = GetAreaSize(AREA_HEIGHT,oArea)*PH_MAX_PLC;
	
	if (nMaxObjects < 100) nMaxObjects == 100;	// supports legacy 1x1 areas that already have 100
												// still won't let you place new ones > 75
	 
	if (GetIsDM(oPC)) return;
	 
     // make sure its a PC
     if (GetIsObjectValid(oPC) && GetIsPC(oPC))
     {	 
	 	oOwner = GetLocalObject(OBJECT_SELF,"oOwner");
		
		if (DEBUG) SendMessageToPC(oPC,"Owner of this room is "+GetFirstName(oOwner));
			 
	 	// special condition: pc does not belong here (probably a relogin)
		// not in the party of the owner
		// entering w/o the owner
		if (	GetFactionLeader(oPC) != GetFactionLeader(oOwner) ||	// i am not in the same party as owner
				!GetIsObjectValid(oOwner)								// or the owner is invalid
				)
		{
			KickMeOut(oPC);
			return;
		}
		
		// if the owner isn't home, wait 6 more seconds and then kick if s/he hasn't shown
		if (!IsOwnerHome(oOwner, oArea) )
		{
			DelayCommand(6.0, AssignCommand(oPC,KickIfOwnerNotHome(oOwner,oArea) ) );
		}			
			
	 	// the rest of this we do this for the owner only
	 	if (oPC != oOwner) return;
		
		SetLocalInt(OBJECT_SELF,"bInUse",TRUE);
		sDoorTag = GetLocalString(OBJECT_SELF,"sDoorTag");
				
		// retrieve decor	
		sSQL = 	"SELECT sResRef,sVector,fFacing,id FROM ph_decor WHERE pcid = " + getPCid(oPC)+" AND doortag ='"+sDoorTag+"' LIMIT "+IntToString(nMaxObjects);
		SQLExecDirect(sSQL);
		while (SQLFetch() == SQL_SUCCESS)
		{
			sResRef = SQLGetData(1);
			vVec =  SQLStringToVector(SQLGetData(2));
			fFacing = StringToFloat(SQLGetData(3));
			nID = StringToInt(SQLGetData(4));
			lLoc = Location(OBJECT_SELF,vVec,fFacing);			
			oPlc = CreateObject(OBJECT_TYPE_PLACEABLE,sResRef,lLoc);
			nCount++;
			// small, manipulable stuff should be useable for RP use
			if (GetLocalInt(oPlc,"bStayUsable") != 1) SetUseableFlag(oPlc,FALSE);
			SetLocalInt(oPlc,"nID",nID);
			if (GetLocalInt(oPlc,"bLit") == 1)  std_enviro_torch_light( oPlc );
		}
		
		SetLocalInt(oArea,"nCount",nCount);
	 }
}

void HomeExitArea(object oPC)
{
	location lExit = GetLocalLocation(oPC,"lExit");
	
	if (GetIsObjectValid( GetAreaFromLocation(lExit) ) )
	{
		// Send PC to the location from which they entered
		AssignCommand(oPC,JumpToLocation(lExit));
	}
	else
	{
		SendMessageToPC(oPC,"Invalid Location!");
		
		// Send PC to an alternate location
		AssignCommand(oPC,JumpToLocation(GetStartingLocation()));
	}
}

void HomeOnExit(object oPC)
{
	object oFriend;
	object oPlc;
	object oOwner;
	object oArea = OBJECT_SELF;
	string sSQL;
	int nObjectType;
		
	if (DEBUG) SendMessageToPC(oPC,"DEBUG: Area OnExit() Script Running.");
	
	oOwner = GetLocalObject(oArea,"oOwner");
	if (DEBUG) SendMessageToPC(oPC,"Owner of the room you're leaving was  "+GetFirstName(oOwner));
	
	location lExit = GetLocalLocation(oPC,"lExit");
	
	// failsafe exit location
	if (!GetIsObjectValid( GetAreaFromLocation(lExit) ) ) lExit = GetStartingLocation();
	//if (!GetIsLocationValid(lExit)) lExit = GetStartingLocation();
	 
 	// the owner is leaving
	if (oPC == oOwner)
	{	
		if (DEBUG) SendMessageToPC(oPC,"You are leaving your own room.");
		
		// kick everyone out when the owner leaves
		// a little artificial, but solves a lot of problems		
		oFriend = GetFirstPC();
		while (	GetIsObjectValid(oFriend) && !GetIsDM(oFriend)	)
		{
			// compare oFriend & oPC here, we don't want to 
			// kick our owner out before we run the queries
			// suspect the issue was encountered in mp testing
			if ( GetArea(oFriend) == oArea && oFriend != oPC )
			{
				AssignCommand(oFriend,JumpToLocation(lExit));
				SendMessageToPC(oFriend,GetName(oPC)+" has left the area.  You return to your point of entry.");
			}				
			oFriend = GetNextPC();
		}
		
	    // loop around crap in the room and destroy it
		// leave doors and waypoints
		oPlc = GetFirstObjectInArea(oArea);
		while (	GetIsObjectValid(oPlc)	)
		{		
			nObjectType = GetObjectType(oPlc);
			
			// get rid of decor system placeables
			if (nObjectType == OBJECT_TYPE_PLACEABLE && FindSubString(GetResRef(oPlc),"decor") > -1		)
			{
				if (DEBUG) SendMessageToPC(oPC,"Destroyed object "+GetName(oPlc));
				DestroyObject(oPlc);
			}
			else if (GetResRef(oPlc) == "std_plc_invisibleobject")
			{
				if (DEBUG) SendMessageToPC(oPC,"Destroyed object "+GetName(oPlc));
				DestroyObject(oPlc);
			}				
			// get rid of creatures without masters
			else if (nObjectType == OBJECT_TYPE_CREATURE && GetMaster(oPlc) == OBJECT_INVALID)
			{
				if (DEBUG) SendMessageToPC(oPC,"Destroyed object "+GetName(oPlc));
				DestroyObject(oPlc);
			}
			// get rid of items and effects
			else if (nObjectType == OBJECT_TYPE_AREA_OF_EFFECT || nObjectType == OBJECT_TYPE_ITEM )  
			{
				if (DEBUG) SendMessageToPC(oPC,"Destroyed object "+GetName(oPlc));
				DestroyObject(oPlc);
			}
			
			oPlc = GetNextObjectInArea(oArea);
		}				

		// mark it available after 10 second wait
		// timing can be tightened later
		DelayCommand(10.0f,DeleteLocalInt(oArea,"bInUse"));
		DeleteLocalObject(oArea,"oOwner");
		DeleteLocalString(oArea,"sDoorTag");
		DeleteLocalInt(oArea,"nCount");
		
		// sweep the room after a small delay
		// timing can be tightened later
		ExecuteScript(SWEEPER,oArea);		
	}
}

void HomeReset(object oPC)
{
	object oPlc;
	object oArea = GetArea(oPC);

	// loop around crap in the room
	oPlc = GetFirstObjectInArea(oArea);
	
	while (GetIsObjectValid(oPlc))
	{ 	
		if (	GetObjectType(oPlc) == OBJECT_TYPE_PLACEABLE && 
				FindSubString(GetResRef(oPlc),"decor") > -1	)
			{
				SetUseableFlag(oPlc, TRUE);
			}
		oPlc = GetNextObjectInArea(oArea);	
	}
	
	SendMessageToPC(oPC,"The decor in this room may now be moved.");
}

location GetAboveBelowLocation(object oTarget, float fDist = 0.25)
{
	vector vNew;
	location lLoc = GetLocation(oTarget);
	vector vTarget	= GetPositionFromLocation(lLoc);
	float fFacing = GetFacingFromLocation(lLoc);
	
	vNew.x = vTarget.x;
	vNew.y = vTarget.y;
	vNew.z = vTarget.z+fDist;
	
	return Location( GetArea(oTarget),vNew,fFacing);
}

// moves a placeable x,y, or z, or rotates
// updates vector and facing in db
// iType			
// 1=forward		
// 2=back			
// 3=left
// 4=right
// 5=up/down
void MoveDecor(object oPlc, object oPC, int iType, float fDist = 1.0f )
{
	int nCount;
	float fFacing;
	string sSQL;	
	location lNew;
	location lTest;
	vector vPos;
	object oItem;
	object oNewPlc;
	object oArea;
	
	int nID = GetLocalInt(oPlc,"nID");
	string sResRef = GetResRef(oPlc);
		
	if (DEBUG) SendMessageToPC(oPC,"Running MoveDecor() on "+sResRef+", ID# "+IntToString(nID)+". Type was "+IntToString(iType)+", fDist was "+FloatToString(fDist));
	
	if (nID < 1) SendMessageToPC(oPC,"Error: Decor item has no ID!"); 
	
	switch (iType)
	{
		case 1: lNew = GetAheadLocation(oPlc, fDist); break;
		case 2: lNew = GetBehindLocation(oPlc, fDist); break;
		case 3: lNew = GetLeftLocation(oPlc, fDist); break;
		case 4: lNew = GetRightLocation(oPlc,fDist); break;
		case 5: lNew = GetAboveBelowLocation(oPlc, fDist); break;
		default: SendMessageToPC(oPC,"Error: Bad or Missing iType"); return;
	}

	// make sure the location is valid (don't crash server)
	if (GetLocalInt(oPlc,"bStayUsable") != 1 && !TestValidLocation(lNew))
	{
		SendMessageToPC(oPC,"Invalid location, try again");
		return;
	}
	
	// bump location if necessary (no tapestries in walls, etc)
	//lNew = FindValidWalkMeshLocation(lNew,oPC);	
	
	vPos = GetPositionFromLocation(lNew);
	fFacing = GetFacingFromLocation(lNew);
	
	if (vPos.z > 4.0 || vPos.z < -0.25)
	{
		SendMessageToPC(oPC,"Invalid height, try again");
		return;	
	}
	
	if (!GetIsDM(oPC))
	{
		sSQL = "UPDATE ph_decor SET sVector = '"+ SQLVectorToString(vPos) + "', fFacing = " + FloatToString(fFacing)+ " WHERE id = "+IntToString(nID);
		SQLExecDirect(sSQL); 
		if (DEBUG) SendMessageToPC(oPC,sSQL);
								
		if (SQLGetAffectedRows() == 1)
		{
			if (DEBUG) SendMessageToPC(oPC,"Save of placeable "+sResRef+" succeeded.");
			
			if (GetLocalInt(oPlc,"bLit") == 1)  std_enviro_torch_extinguish( oPlc );
			DestroyObject(oPlc);
			oNewPlc = CreateObject(OBJECT_TYPE_PLACEABLE,sResRef,lNew);
			SetLocalInt(oNewPlc,"nID",nID);		
			if (GetLocalInt(oNewPlc,"bLit") == 1)  std_enviro_torch_light( oNewPlc );
		}	
		else
		{
			if (DEBUG) SendMessageToPC(oPC,"Save of placeable "+sResRef+" failed.");
			
			// fail safe
			oArea = (GetArea(oPC));
			nCount = GetLocalInt(oArea,"nCount");
			oItem = CreateItemOnObject("decor",oPC);
			SetLocalString(oItem,"sTemplate",sResRef);
			SetFirstName(oItem,"Decor: "+GetName(oPlc));
			SetDescription(oItem,GetDescription(oPlc));	
			if (GetLocalInt(oPlc,"bIsWallHanging") == 1)
			{
				SetLocalInt(oItem,"bIsWallHanging",1);
			}			
			DestroyObject(oNewPlc);
			DestroyObject(oPlc);
			SetLocalInt(oArea,"nCount",nCount-1);
		}	
	}
	else
	{
		if (GetLocalInt(oPlc,"bLit") == 1)  std_enviro_torch_extinguish( oPlc );
		DestroyObject(oPlc);
		oNewPlc = CreateObject(OBJECT_TYPE_PLACEABLE,sResRef,lNew);
		if (GetLocalInt(oNewPlc,"bLit") == 1)  std_enviro_torch_light( oNewPlc );
	}
}

void RotateDecor(object oPC, object oPlc, float fDist)
{	
	string sSQL;
	int nID = GetLocalInt(oPlc,"nID");
	float fNewFacing = GetNormalizedDirection(GetFacing(oPlc) + fDist);
	SetFacing(fNewFacing);
	
	// save if not DM
	if (!GetIsDM(oPC))
	{
		sSQL = "UPDATE ph_decor SET fFacing = " + FloatToString(fNewFacing)+ " WHERE id = "+IntToString(nID);
		SQLExecDirect(sSQL);
	
	if (DEBUG) SendMessageToPC(oPC,sSQL);
	}
}

float squareFacing(float fFacing)
{
	float fTest = GetNormalizedDirection(fFacing);
	
	fFacing =	360.0;
	if (fTest < 	337.5	) 	fFacing =	315.0;
	if (fTest < 	292.5	) 	fFacing =	270.0;
	if (fTest < 	247.5	) 	fFacing =	225.0;
	if (fTest < 	202.5	) 	fFacing =	180.0;
	if (fTest < 	157.5	) 	fFacing =	135.0;
	if (fTest < 	112.5	) 	fFacing =	90.0;
	if (fTest < 	67.5	) 	fFacing =	45.0;
	if (fTest < 	22.5	) 	fFacing =	0.0;
			
	return fFacing;
}

void PlaceDecor(object oItem, object oPC, location lLoc, object oTarget = OBJECT_INVALID)
{
	int nCount;
	int nID;
	int nMaxObjects;
	object oDecor;
	object oPlc;
	object oArea;
	object oOwner;
	string sSQL;
	string pcid;
	string sDoorTag;
	string sResRef;
	vector vTarget;
	float fFacing;
	float fTop;
	
	oArea = GetArea(oPC);
	nMaxObjects = GetAreaSize(AREA_HEIGHT,oArea)*PH_MAX_PLC;
	
	nCount = GetLocalInt(oArea,"nCount");
	
	// let DMs and PCs outside a house exceed 	
	if (!GetIsDM(oPC) && nCount > nMaxObjects && FindSubString(GetTag(oArea),"ph_") != -1)
	{
		SendMessageToPC(oPC,"You cannot place more than "+IntToString(nMaxObjects)+" objects here.  You'll need to remove something before you can place another.");
		return;
	}
	
	if (DEBUG) SendMessageToPC(oPC,"oTarget was: "+GetName(oTarget));
	
	oOwner = GetLocalObject(oArea,"oOwner");  // << NOT oPC!
	pcid = GetLocalString( oOwner, "pcid");
	sDoorTag = GetLocalString(oArea,"sDoorTag");
	sResRef = GetLocalString(oItem, "sTemplate");
	
	// square the facing up and flip object to
	// face in opposite direction as player
	fFacing =  squareFacing(GetFacingFromLocation(lLoc));
	vTarget	= GetPositionFromLocation(lLoc);
	
	// if item is supposed to be suspended above floor
	// overwrite the height of the targeted location
	if (GetLocalInt(oItem,"bIsWallHanging") == 1 )
	{		
		if (DEBUG) SendMessageToPC(oPC,"HANGING");
		
		vTarget.z = 1.5f;
	}	
	else if (DEBUG)
	{
		SendMessageToPC(oPC,"NOT HANGING");
	}
	
	// trick for 'stacking' items on other placeables
	if (	GetIsObjectValid(oTarget) && GetObjectType(oTarget) == OBJECT_TYPE_PLACEABLE )
	{
		if (DEBUG) SendMessageToPC(oPC,"STACKING");
		
		fTop = GetLocalFloat(oTarget,"fTop");
		if (fTop > 0.0)
		{
			vTarget.z = fTop;
		}
	}	
	else if (DEBUG)
	{
		SendMessageToPC(oPC,"NOT STACKING");
	}
	
	lLoc	= Location(	GetArea(oPC),vTarget,fFacing);
	
	// if this object is being placed on the floor, make
	// sure the location is valid
	if (!GetIsObjectValid(oTarget) && !TestValidLocation(lLoc))
	{
		SendMessageToPC(oPC,"Invalid location, try again");
		return;
	}
	
	// bump location if necessary (no tapestries in walls, etc)
	//lLoc = FindValidWalkMeshLocation(lLoc,oPC);	
	
	// you're not a dm and your in a player hoouse
	//
	if (!GetIsDM(oPC) || FindSubString(GetTag(oArea),"ph_") != -1	)
	{
		sSQL = "INSERT INTO ph_decor (pcid,doortag,sResRef,sVector,fFacing) VALUES (" + pcid + ",'" + sDoorTag + "','" + sResRef + "','"+ SQLVectorToString(vTarget) + "'," + FloatToString(fFacing)+ ")";
		if (DEBUG) SendMessageToPC(oPC,sSQL);
		
		SQLExecDirect(sSQL);	
		
		SQLExecDirect("SELECT LAST_INSERT_ID()");
	    if (SQLFetch() == SQL_SUCCESS) 
		{
			if (DEBUG) SendMessageToPC(oPC,"LAST_INSERT_ID was: "+SQLGetData(1));
			
			oDecor = CreateObject(OBJECT_TYPE_PLACEABLE, sResRef, lLoc);
			SetLocalInt(oArea,"nCount",nCount+1);
	        nID = StringToInt(SQLGetData(1));
			if (GetLocalInt(oDecor,"bLit") == 1)  std_enviro_torch_light( oDecor );		
			SetLocalInt( oDecor, "nID", nID);
			DestroyObject(oItem);
	    }
	}
	else
	// your either a dm or you're a pc outside a player house
	{
		oDecor = CreateObject(OBJECT_TYPE_PLACEABLE, sResRef, lLoc);
		if (GetLocalInt(oDecor,"bLit") == 1)  std_enviro_torch_light( oDecor );
		DestroyObject(oItem);				
	}
}

void PackDecor(object oPC, object oDecor)
{
	int nPrice;
	int nCount;
	int nID = GetLocalInt(oDecor,"nID");
	object oArea = GetArea(oDecor);
	object oItem;
	string sSQL;
	string sTemplate = GetResRef(oDecor);
	string sName = GetName(oDecor);
	string sDesc = GetDescription(oDecor);
	int bIsWallHanging = GetLocalInt(oDecor,"bIsWallHanging");
	
	// if we're not in the showroom, destroy the object
	// and clean it up in the database
	if (FindSubString(GetTag(oArea),"showroom") == -1)
	{
		nCount = GetLocalInt(oArea,"nCount");
		nID = GetLocalInt(oDecor,"nID");
		sSQL = 	"DELETE FROM ph_decor WHERE id = " +IntToString(nID);
		if (DEBUG) SendMessageToPC(oPC,sSQL); // debug
		if (GetLocalInt(oDecor,"bLit") == 1)  std_enviro_torch_extinguish( oDecor );		
		SQLExecDirect(sSQL);
		DestroyObject(oDecor);
		SetLocalInt(oArea,"nCount",nCount-1);
	}
	else
	{
		// otherwise leave it there and attempt to pay for a copy
		nPrice = GetLocalInt(oDecor,"nPrice");
		if (GetGold(oPC) > nPrice)
		{
			TakeGoldFromCreature(nPrice,oPC,TRUE,TRUE);
		}
		else
		{
			SendMessageToPC(oPC,"You cannot afford this item");
			return;
		}
	}
	
	oItem = CreateItemOnObject("decor",oPC);
	SetLocalString(oItem,"sTemplate",sTemplate);
	SetFirstName(oItem,"Decor: "+sName);
	SetDescription(oItem,sDesc);
	if (bIsWallHanging == 1)
	{
		SetLocalInt(oItem,"bIsWallHanging",1);
	}
}

/*

CREATE TABLE  `nwnx`.`ph_records` (
  `id` int(10) unsigned NOT NULL auto_increment,
  `pcid` int(10) unsigned NOT NULL,
  `doortag` varchar(45) NOT NULL,
  `class` int(10) unsigned NOT NULL,
  PRIMARY KEY  USING BTREE (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `nwnx`.`ph_decor`;
CREATE TABLE  `nwnx`.`ph_decor` (
  `id` int(10) unsigned NOT NULL auto_increment,
  `pcid` int(10) unsigned NOT NULL,
  `doortag` varchar(45) NOT NULL,
  `sResRef` varchar(45) NOT NULL,
  `fFacing` float NOT NULL,
  `sVector` varchar(128) NOT NULL,
  `timetamp` timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=149 DEFAULT CHARSET=latin1;

void main() { }
*/