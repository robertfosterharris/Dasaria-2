// =================================================================
// Utility
//
// Contain miscellaneous reusable mehtods that doesn't fit into any 
// categories or not important enough to have its own file. 
// 
// By Nytir
// ================================================================
const string MDB  = "MYDEBUGMODE";
const string MDBL = "MYDEBUGLOG";
// =================================================================
// Prototypes
// =================================================================

// Location
location GetOffsetLocation(location lLoc, float fX=0.0f, float fY=0.0f, float fZ=0.0f);
location GetDeviatedLocation(location lLoc, int iDvt=10);
// Object
int CountNearbyObjectWithTag(string sTag, object oTrg=OBJECT_SELF);
object CreateCreature(string sRef, object oWP, string sTag="");
object CreatePlacable(string sRef, object oWP, string sTag="");
object CreatePlacedEffect(string sRef, object oWP, string sTag="");
object CreateStore(string sRef, object oWP, string sTag="");
// Facion and reputation
int GetFactionDisposition(int iFct, object oTrg);
object GetCreatureNearLocation(location lLoc, int iN=1);
object GetNearestCreatureByReputation(object oTrg, int iRpt, int iN=1);
object GetNearestHostile(object oTrg);
object GetNearestNeutral(object oTrg);
object GetNearestFriend(object oTrg);
object GetRandomCreatureByReputation(object oTrg, int iRpt);
object GetRandomHostile(object oTrg);
object GetRandomNeutral(object oTrg);
object GetRandomFriend2(object oTrg);
object GetNearestCreatureByDisposition(location lLoc, int iFct, int iRpt);
object GetNearestHostileByDisposition(location lLoc, int iFct);
object GetNearestNeutralByDisposition(location lLoc, int iFct);
object GetNearestFriendByDisposition(location lLoc, int iFct);
object GetRandomCreatureByDisposition(location lLoc, int iFct, int iRpt);
object GetRandomHostileByDisposition(location lLoc, int iFct);
object GetRandomNeutralByDisposition(location lLoc, int iFct);
object GetRandomFriendByDisposition(location lLoc, int iFct);
string GetStandardFactionName(int iFct);
// Behaviour
int MoveToObject(object oAct, object oTrg, int iRun=TRUE, float fDis=3.0f);
int MoveToObjectWithTag(object oAct, string sTag, int iRun=TRUE, float fDis=3.0f);
int GetIsCharmed(object oTrg);
void RemoveCharmEffect(object oTrg);
// PC and level
int GetLevelAdjustment(object oCreature);
int GetPCAverageLevel();
int GetPCAverageXP();
int GetXPForLevel(int iLv);
void LevelUpCreature(object oPC, int iLv, int iAuto=FALSE);
// Local variable
int IncLocalInt(object oObj, string sVar, int iInc);
float IncLocalFloat(object oObj, string sVar, float fInc);
string IncLocalString(object oObj, string sVar, string sInc);
// Formatting
string FormatFloat(float fVal, int iDec=2);
string FormatLocation(location lLoc);
// Communication
string MarkUp(string sTxt, string sMrk, string sAtt="");
string Color(string sTxt, string sClr);
string Gold(string sTxt);
string Orange(string sTxt);
string Red(string sTxt);
string Green(string sTxt);
string Blue(string sTxt);
string Bold(string sTxt);
string Italic(string sTxt);
void ShowReport(object oPC, string sMsg, string sScr="");
void ShowReportToAllPC(string sMsg, string sScr="", object oPC=OBJECT_INVALID);
void SendMessageToAllPC(string sMsg, object oPC=OBJECT_INVALID);
// Companions
void AddCompanion(object oPC, string sRef, int iJn=0, int iALv=TRUE);
void SelectParty(object oPC, int iMdt=FALSE, int iPSz=3, string sScr="");
// MyDebug
int GetMyDebugMode();
void MyDebugMode(int iOn=TRUE);
void MyDebug(string sMsg, string sSbj="Debug");
void MyDebugSeperator();
void MyDebugLog(string sMsg);
void MyDebugFlush(string sSbj="Debug");
// =================================================================
// Location
// =================================================================

// Get an Offsetted location from lLoc
// fX : x offset of original location
// fY : y offset of original location
// fZ : z offset of original location
location GetOffsetLocation(location lLoc, float fX=0.0f, float fY=0.0f, float fZ=0.0f){
	float  fDir  = GetFacingFromLocation(lLoc);
	vector vLoc  = GetPositionFromLocation(lLoc);
	object oArea = GetAreaFromLocation(lLoc);
	vLoc.x += fX;
	vLoc.y += fY;
	vLoc.z += fZ;
	return Location(oArea, vLoc, fDir);
}
// Get a randomly deviated location
// lLoc : Location
// iDvt : Deviation
location GetDeviatedLocation(location lLoc, int iDvt=10){
	float fX = IntToFloat( iDvt/2 - Random(iDvt+1) ); 
	float fY = IntToFloat( iDvt/2 - Random(iDvt+1) );
	return GetOffsetLocation(lLoc, fX, fY);
}
// =================================================================
// Object
// =================================================================

// Count Objects with sTag in target's area
// sTag : Tag
// oTrg : Target
int CountNearbyObjectWithTag(string sTag, object oTrg=OBJECT_SELF){
	int    iN   = 1;
	object oObj = GetNearestObjectByTag(sTag, oTrg, iN);
	while( GetIsObjectValid(oObj) ){
		iN ++;
		oObj = GetNearestObjectByTag(sTag, oTrg, iN);
	}
	return (iN - 1);
}
// Create Creature at a waypoint
// sRef : ResRef
// oWP  : Object (preferably Waypoint)
// sTag : new tag for the Creature
object CreateCreature(string sRef, object oWP, string sTag=""){
	int      iTyp = OBJECT_TYPE_CREATURE;
	location lLoc = GetLocation(oWP);
	return CreateObject(iTyp, sRef, lLoc, FALSE, sTag);
}
// Create Placable at a waypoint
// sRef : ResRef
// oWP  : Object (preferably Waypoint)
// sTag : new tag for the Placable
object CreatePlacable(string sRef, object oWP, string sTag=""){
	int      iTyp = OBJECT_TYPE_PLACEABLE;
	location lLoc = GetLocation(oWP);
	return CreateObject(iTyp, sRef, lLoc, FALSE, sTag);
}
// Create Placed Effect at a waypoint
// sRef : ResRef
// oWP  : Object (preferably Waypoint)
// sTag : new tag for the Placed Effect
object CreatePlacedEffect(string sRef, object oWP, string sTag=""){
	int      iTyp = OBJECT_TYPE_PLACED_EFFECT;
	location lLoc = GetLocation(oWP);
	return CreateObject(iTyp, sRef, lLoc, FALSE, sTag);
}
// Create Store at a waypoint
// sRef : ResRef
// oWP  : Object (preferably Waypoint)
// sTag : new tag for the Store
object CreateStore(string sRef, object oWP, string sTag=""){
	int      iTyp = OBJECT_TYPE_STORE;
	location lLoc = GetLocation(oWP);
	return CreateObject(iTyp, sRef, lLoc, FALSE, sTag);
}
// =================================================================
// Faction and Reputation
// =================================================================

// Get the Nth nearest Creature By Reputation
// Does not return dead or hidden creatures
// oTrg : Target
// iRpt : REPUTATION_TYPE_*
// iN   : Nth nearest
object GetNearestCreatureByReputation(object oTrg, int iRpt, int iN=1){
	int iFCT = CREATURE_TYPE_REPUTATION;
	int iSCT = CREATURE_TYPE_IS_ALIVE;
	int iSCV = CREATURE_ALIVE_TRUE;
	int iTCT = CREATURE_TYPE_SCRIPTHIDDEN;
	int iTCV = CREATURE_SCRIPTHIDDEN_FALSE;
	return GetNearestCreature(iFCT, iRpt, oTrg, iN, iSCT, iSCV, iTCT, iTCV);
}
// Get nearest Hostile Creature
// oTrg : Target
object GetNearestHostile(object oTrg){
	int iRpt = REPUTATION_TYPE_ENEMY;
	return GetNearestCreatureByReputation(oTrg, iRpt);
}
// Get nearest Neutral Creature
// oTrg : Target
object GetNearestNeutral(object oTrg){
	int iRpt = REPUTATION_TYPE_NEUTRAL;
	return GetNearestCreatureByReputation(oTrg, iRpt);
}
// Get nearest Friendly Creature
// oTrg : Target
object GetNearestFriend(object oTrg){
	int iRpt = REPUTATION_TYPE_FRIEND;
	return GetNearestCreatureByReputation(oTrg, iRpt);
}
// -------------------------------------------------------

// Get a random nearby Creature By Reputation
// Does not return dead or hidden creatures
// oTrg : Target
// iRpt : REPUTATION_TYPE_*
object GetRandomCreatureByReputation(object oTrg, int iRpt){
	int iN;
	// Don't spend too much resources, search for 3-12 creature 
	// Search backward so that if won't always return the nearest one
	for( iN = d4(3); iN > 0; iN-- ){
		object oTrg = GetNearestCreatureByReputation(oTrg, iRpt, iN);
		if( GetIsObjectValid(oTrg) ){ return oTrg; }
	}
	return OBJECT_INVALID;
}
// Get random nearby Hostile Creature
// oTrg : Target
object GetRandomHostile(object oTrg){
	int iRpt = REPUTATION_TYPE_ENEMY;
	return GetRandomCreatureByReputation(oTrg, iRpt);
}
// Get random nearby Neutral Creature
// oTrg : Target
object GetRandomNeutral(object oTrg){
	int iRpt = REPUTATION_TYPE_NEUTRAL;
	return GetRandomCreatureByReputation(oTrg, iRpt);
}
// Get random nearby Friendly Creature
// oTrg : Target
object GetRandomFriend2(object oTrg){
	int iRpt = REPUTATION_TYPE_FRIEND;
	return GetRandomCreatureByReputation(oTrg, iRpt);
}
// -------------------------------------------------------

// Get Faction's reputation type towards target
// iFct : Faction 
// oTrg : Target
// return REPUTATION_TYPE_*
int GetFactionDisposition(int iFct, object oTrg){
	int iRpt = GetStandardFactionReputation(iFct, oTrg);
	if( iRpt <= 10 ){ return REPUTATION_TYPE_ENEMY; }
	if( iRpt >= 90 ){ return REPUTATION_TYPE_FRIEND; }
	return REPUTATION_TYPE_NEUTRAL;
}
// Get the Nth nearest Creature to location
// Does not return dead or hidden creatures
// lLoc : location
// iN   : Nth nearest
object GetCreatureNearLocation(location lLoc, int iN=1){
	int iFCT = CREATURE_TYPE_IS_ALIVE;
	int iFCV = CREATURE_ALIVE_TRUE;
	int iSCT = CREATURE_TYPE_SCRIPTHIDDEN;
	int iSCV = CREATURE_SCRIPTHIDDEN_FALSE;
	return GetNearestCreatureToLocation(iFCT, iFCV, lLoc, iN, iSCT, iSCV);
}
// -------------------------------------------------------

// Get creature with certain reputation towards a faction
// lLoc : Location
// iFct : Faction 
// iRpt : REPUTATION_TYPE_*
object GetNearestCreatureByDisposition(location lLoc, int iFct, int iRpt){
	int iN;
	// Don't spend too much resources, search for 10
	// return OBJECT_INVALID if can't find one
	for( iN = 1; iN < 10; iN++ ){
		object oTrg = GetCreatureNearLocation(lLoc, iN);
		if( !GetIsObjectValid(oTrg) ){ return OBJECT_INVALID; }
		if( GetFactionDisposition(iFct, oTrg) == iRpt ){ return oTrg; }
	}
	return OBJECT_INVALID;
}
// Get nearest Creature Hostile to Faction
// lLoc : Location
// iFct : Faction 
object GetNearestHostileByDisposition(location lLoc, int iFct){
	int iRpt = REPUTATION_TYPE_ENEMY;
	return GetNearestCreatureByDisposition(lLoc, iFct, iRpt);
}
// Get nearest Creature Neutral 
// lLoc : Location
// iFct : Faction 
object GetNearestNeutralByDisposition(location lLoc, int iFct){
	int iRpt = REPUTATION_TYPE_NEUTRAL;
	return GetNearestCreatureByDisposition(lLoc, iFct, iRpt);
}
// Get nearest Creature Friendly to Faction
// lLoc : Location
// iFct : Faction 
object GetNearestFriendByDisposition(location lLoc, int iFct){
	int iRpt = REPUTATION_TYPE_FRIEND;
	return GetNearestCreatureByDisposition(lLoc, iFct, iRpt);
}
// -------------------------------------------------------

// Get a random creature with certain reputation towards a faction
// close to a location
// lLoc : Location
// iFct : Faction 
object GetRandomCreatureByDisposition(location lLoc, int iFct, int iRpt){
	int iN;
	// Don't spend too much resources, search for 5-20 creature 
	// Search backward so that if won't always return the nearest one
	// return OBJECT_INVALID if can't find one
	for( iN = d4(5); iN > 0; iN-- ){
		object oTrg = GetCreatureNearLocation(lLoc, iN);
		if( GetIsObjectValid(oTrg) ){
			if( GetFactionDisposition(iFct, oTrg) == iRpt ){ return oTrg; }
		}
	}
	return OBJECT_INVALID;
}
// Get random Creature Hostile to Faction
// lLoc : Location
// iFct : Faction 
object GetRandomHostileByDisposition(location lLoc, int iFct){
	int iRpt = REPUTATION_TYPE_ENEMY;
	return GetRandomCreatureByDisposition(lLoc, iFct, iRpt);
}
// Get random Creature Neutral to Faction
// lLoc : Location
// iFct : Faction 
object GetRandomNeutralByDisposition(location lLoc, int iFct){
	int iRpt = REPUTATION_TYPE_NEUTRAL;
	return GetRandomCreatureByDisposition(lLoc, iFct, iRpt);
}
// Get random Creature Friendly to Faction
// lLoc : Location
// iFct : Faction 
object GetRandomFriendByDisposition(location lLoc, int iFct){
	int iRpt = REPUTATION_TYPE_FRIEND;
	return GetRandomCreatureByDisposition(lLoc, iFct, iRpt);
}
// -------------------------------------------------------

// Get the name of a standard Faction
// Return Faction_x for nonstandard Faction
string GetStandardFactionName(int iFct){
	switch(iFct){
		case STANDARD_FACTION_HOSTILE : return Red("Hostile");
		case STANDARD_FACTION_COMMONER: return "Commoner";
		case STANDARD_FACTION_MERCHANT: return "Merchant";
		case STANDARD_FACTION_DEFENDER: return Green("Defender");
	}
	return "Faction_"+IntToString(iFct);
}
// =================================================================
// Behaviour
// =================================================================

// Move to target if distance with oTrg > fDis
// Return true if within desired distance
// oAct : Actor
// oTrg : Target
// iRun : Run or walk
// fDis : How close to Target
int MoveToObject(object oAct, object oTrg, int iRun=TRUE, float fDis=3.0f){
	if( GetDistanceBetween(oAct, oTrg) > fDis ){
		AssignCommand(oAct, ActionMoveToObject(oTrg, iRun));
		return FALSE;
	}
	return TRUE;
}
// Move to target if distance with oTrg > fDis
// Return true if within desired distance
// oAct : Actor
// sTag : Tag of target
// iRun : Run or walk
// fDis : How close to Target
int MoveToObjectWithTag(object oAct, string sTag, int iRun=TRUE, float fDis=3.0f){
	object oTrg = GetNearestObjectByTag(sTag, oAct);
	return MoveToObject(oAct, oTrg, iRun, fDis);
}
// ------------------------------------------------------------

// Return true if oTrg is under charm effects
int GetIsCharmed(object oTrg){
	effect eEff = GetFirstEffect(oTrg);
	while( GetIsEffectValid(eEff) ){
		if( GetEffectType(eEff) == EFFECT_TYPE_CHARMED
		||  GetEffectType(eEff) == EFFECT_TYPE_DOMINATED ){
			return TRUE;
		}
		eEff = GetNextEffect(oTrg);
	}
	return FALSE;
}
// Remove charm effects on oTrg
void RemoveCharmEffect(object oTrg){
	effect eEff = GetFirstEffect(oTrg);
	while( GetIsEffectValid(eEff) ){
		if( GetEffectType(eEff) == EFFECT_TYPE_CHARMED
		||  GetEffectType(eEff) == EFFECT_TYPE_DOMINATED ){
			RemoveEffect(oTrg, eEff);
		}
		eEff = GetNextEffect(oTrg);
	}
}
// =================================================================
// PC and Level
// =================================================================

// Get level adjustment
int GetLevelAdjustment(object oCreature){
	switch( GetSubRace(oCreature) ){
		case RACIAL_SUBTYPE_AASIMAR:
		case RACIAL_SUBTYPE_TIEFLING:
		case RACIAL_SUBTYPE_GRAY_DWARF:
		case RACIAL_SUBTYPE_AIR_GENASI:
		case RACIAL_SUBTYPE_FIRE_GENASI:
		case RACIAL_SUBTYPE_EARTH_GENASI:
		case RACIAL_SUBTYPE_WATER_GENASI: return 1;
		case RACIAL_SUBTYPE_DROW:
		case RACIAL_SUBTYPE_GITHYANKI:
		case RACIAL_SUBTYPE_GITHZERAI:    return 2;
		case RACIAL_SUBTYPE_SVIRFNEBLIN:  return 3;
	}
	return 0;
}
// Get PCs' average Level
int GetPCAverageLevel(){
	object oPC = GetFirstPC(TRUE);
	int    iLv = 0;
	int    iC  = 0;
	while( GetIsObjectValid(oPC) ){
		iLv += GetTotalLevels(oPC, TRUE);
		iLv += GetLevelAdjustment(oPC);
		iC  ++;
		oPC = GetNextPC(TRUE);
	}
	if( iC > 0 ){ return (iLv/iC); }
	return 0;
}
// Get PCs' average XP
int GetPCAverageXP(){
	object oPC = GetFirstPC(TRUE);
	int    iXP = 0;
	int    iC  = 0;
	while( GetIsObjectValid(oPC) ){
		iXP += GetXP(oPC);
		iC  ++;
		oPC = GetNextPC(TRUE);
	}
	if( iC > 0 ){ return (iXP/iC); }
	return 0;
}
// Get the XP needed to reach a certain level
int GetXPForLevel(int iLv){
	// XP follows an arithmetic progression:
	// 1000+2000+3000..+n = 1000(1+n)n/2 where n = iLv-1
	return iLv*(iLv-1)*500;
}
// Level Creature to certain level
// oTrg  : Target
// iLV   : Level
// iAuto : automatic or manual
void LevelUpCreature(object oTrg, int iLv, int iAuto=FALSE){
	if( GetTotalLevels(oTrg, TRUE) < iLv ){
		int iXP = GetXPForLevel(iLv);
		if( iAuto ){
			ResetCreatureLevelForXP(oTrg, iXP, TRUE);
		}else{
			SetXP(oTrg, iXP);
		}
	}
}
// =================================================================
// Local Variables
// =================================================================

// Increment local int and return it
// oObj : Object
// sVar : Var Name
// iInc : Increment (use negative number to decrement)
int IncLocalInt(object oObj, string sVar, int iInc){
	SetLocalInt(oObj, sVar, GetLocalInt(oObj, sVar) + iInc);
	return GetLocalInt(oObj, sVar);
}
// Increment local float and return it
// oObj : Object
// sVar : Var Name
// fInc : Increment (use negative number to decrement)
float IncLocalFloat(object oObj, string sVar, float fInc){
	SetLocalFloat(oObj, sVar, GetLocalFloat(oObj, sVar) + fInc);
	return GetLocalFloat(oObj, sVar);
}
// Increment local string and return it
// oObj : Object
// sVar : Var Name
// sInc : Increment
string IncLocalString(object oObj, string sVar, string sInc){
	SetLocalString(oObj, sVar, GetLocalString(oObj, sVar) + sInc);
	return GetLocalString(oObj, sVar);
}
// =================================================================
// Formatting
// =================================================================

// Convert float to string and remove the white spaces
// that normally occur in FloatToString
// fVal : Float
// iDec : Decimal place
string FormatFloat(float fVal, int iDec=2){
	string sInt = IntToString(FloatToInt(fVal));
	string sFlt = FloatToString(fVal,18,iDec);
	int    iLen = GetStringLength(sInt) + 1 + iDec;
	return GetStringRight(sFlt, iLen);
}
// Convert a location to a printable string: Area (x,y,z)
string FormatLocation(location lLoc){
	vector vLoc = GetPositionFromLocation(lLoc);
	string sA   = GetTag(GetAreaFromLocation(lLoc));
	string sX   = FormatFloat(vLoc.x);
	string sY   = FormatFloat(vLoc.y);
	string sZ   = FormatFloat(vLoc.z);
	return sA+" ("+sX+", "+sY+", "+sZ+")";
}
// =================================================================
// Communication and feedback
// =================================================================

string MarkUp(string sTxt, string sMrk, string sAtt=""){
	return "<"+ sMrk + sAtt +">"+ sTxt +"</"+ sMrk +">";
}
string Color(string sTxt, string sClr){
	return MarkUp(sTxt, "color", "="+sClr);
}
string Gold(string sTxt){
	return Color(sTxt, "gold");
}
string Orange(string sTxt){
	return Color(sTxt, "orange");
}
string Red(string sTxt){
	return Color(sTxt, "red");
}
string Green(string sTxt){
	return Color(sTxt, "green");
}
string Blue(string sTxt){
	return Color(sTxt, "blue");
}
string Bold(string sTxt){
	return MarkUp(sTxt, "b");
}
string Italic(string sTxt){
	return MarkUp(sTxt, "i");
}
// ------------------------------------------------------------

// Shows a report to oPC
// sMsg : Content
// oPC  : PC to show to
// sScr : Call back script when ok is clicked
void ShowReport(object oPC, string sMsg, string sScr=""){
	string sGUI = "SCREEN_MESSAGEBOX_REPORT";
	string sCls = "CloseButton";	
	CloseGUIScreen(oPC, sGUI);
	SetGUIObjectDisabled(oPC, sGUI, sCls, TRUE);
	DelayCommand(0.1f,
		DisplayMessageBox(
			oPC, // Display a message box for this PC
			-1,   // string ref to display
			sMsg, // Message to display
			sScr, // Callback for clicking the OK button
			sScr, // Callback for clicking the Cancel button
			FALSE,// display the Cancel button
			sGUI, // Display the tutorial message box
			-1,   // OK string ref
			"",   // OK string
			-1,   // Cancel string ref
			""    // Cancel string
		)
	);
}
// Show report to every PC
// sMsg : Content
// sScr : Call back script when ok is clicked
// oPC  : if valid, only report to oPC's party members
void ShowReportToAllPC(string sMsg, string sScr="", object oPC=OBJECT_INVALID){
	object oCPC = GetFirstPC(FALSE);
	while( GetIsObjectValid(oCPC) ){
		if( !GetIsObjectValid(oPC) || GetFactionEqual(oPC, oCPC) ){
			ShowReport(oCPC, sMsg, sScr);
		}
		oCPC = GetNextPC(FALSE);
	}
}
// ------------------------------------------------------------

// Send a message to every PC
// oPC : if valid, only message oPC's party members
void SendMessageToAllPC(string sMsg, object oPC=OBJECT_INVALID){
	object oCPC = GetFirstPC(FALSE);
	while( GetIsObjectValid(oCPC) ){
		if( !GetIsObjectValid(oPC) || GetFactionEqual(oPC, oCPC) ){
			SendMessageToPC(oCPC, sMsg);
		}
		oCPC = GetNextPC(FALSE);
	}
}
// =================================================================
// Companions
// =================================================================

// Adds a companion to oPC
// sRef : Companion ResRef
// iJn  : 0 Add Only, 1 Add & Join, 2 Add & Force Join
// iALv : Auto adjust level if true (For new companions only)
void AddCompanion(object oPC, string sRef, int iJn=0, int iALv=TRUE){
	object oCmp = OBJECT_INVALID;
	string sRN  = GetFirstRosterMember();
	// Check Roster Member list
	while( (sRN != sRef) && (sRN != "") ){
		sRN = GetNextRosterMember();
	}
	// Companion not in Roster List
	if( sRN != sRef ){
		// look for an existing instance
		oCmp = GetObjectByTag(sRef);
		if( !GetIsObjectValid(oCmp) ){	
			// Not found, Create one
			oCmp = CreateCreature(sRef, oPC, sRef);
		}
		LevelUpCreature(oCmp, GetTotalLevels(oPC, TRUE), iALv);
		AddRosterMemberByCharacter(sRef, oCmp);
		// Save and unspawn if add to roster only
		if( iJn <= 0 ){ 
			DespawnRosterMember(sRef); 
		}
	}
	// Spawn and join
	if( iJn > 0 ){
		AddRosterMemberToParty(sRef, oPC);
		if( iJn >= 2 ){
			// Force Join (Cannot remove)
			SetIsRosterMemberSelectable(sRef, FALSE);
		}
	}
}
// Show Party Selection Screen
// iMdt : Selection is Mandatory if true (cannot cancel)
// iPSz : Party Size
// sScr : Script to run when party accpeted
void SelectParty(object oPC, int iMdt=FALSE, int iPSz=3, string sScr=""){

	string sGUI = "SCREEN_PARTYSELECT";
	string sCnl = "REMOVE_PARTY";
	string sCls = "CloseButton";
	
	CloseGUIScreen(oPC, sGUI);	
	SetRosterNPCPartyLimit(iPSz);
	SetGUIObjectDisabled(oPC, sGUI, sCnl, iMdt);
	SetGUIObjectDisabled(oPC, sGUI, sCls, iMdt);
	SetLocalGUIVariable(oPC, sGUI, 0, sScr);
	DelayCommand(0.1f, DisplayGuiScreen(oPC, sGUI, TRUE));
}
// =================================================================
// My Debgug
// =================================================================

// Get MyDebug Mode
int GetMyDebugMode(){
	return GetLocalInt(GetModule(), MDB);
}
// Set MyDebug Mode
void MyDebugMode(int iOn=TRUE){
	SetLocalInt(GetModule(), MDB, iOn);
}
// Sends a MyDebug Message
// sMsg : Message
// sSbj : subject of the message
void MyDebug(string sMsg, string sSbj="Debug"){
	if( !GetLocalInt(GetModule(), MDB) ){ return; }
	if( sSbj != "" ){
		SendMessageToPC(GetFirstPC(FALSE), "["+ sSbj +"] "+ sMsg);
	}else{
		SendMessageToPC(GetFirstPC(FALSE), sMsg);
	}
}
// Print a seperator line
void MyDebugSeperator(){
	MyDebug("----------------------------------------", "");
}
// Append a Message in MyDebug Log, send out later
void MyDebugLog(string sMsg){
	if( !GetLocalInt(GetModule(), MDB) ){ return; }
	IncLocalString(GetModule(), MDBL, sMsg);
}
// Send out the MyDebug Message stored in MyDebug Log
void MyDebugFlush(string sSbj="Debug"){
	MyDebug(GetLocalString(GetModule(), MDBL), sSbj);
	DeleteLocalString(GetModule(), MDBL);
}