#include "i_array"
// =================================================================
// Battle Settings
//
// Contain variables and methods required to orchestrate a battle
// Scope of the methods are area (caller) centered. You cannot call 
// the methods from outside the area to change the battle. The methods 
// are designed to be used in the area in dialogue/cutscene.
// 
// By Nytir
// =================================================================
// Local Variables

// Area
const string ARO_BCTRL = "BATTLECONTROL";
// Battle Control
const string BCS_BARMY = "ARMIES";
const string BCS_BVCDF = "VictoryDefeatScript";
const string BCI_BACTV = "BATTLEACTIVE";
const string BCI_ENGGD = "ARMIESENGAGED";
const string BCI_BFOW  = "FOGOFWAR";
const string BCO_BFOW  = "FOGS";
// Army Statistic
const string AMI_FCTN  = "_FACTION";
const string AMI_TTL   = "_TOTAL";
const string AMI_RSRV  = "_RESERVE";
const string AMI_SLMT  = "_SPAWNLIMIT";
const string AMI_SCNT  = "_SPAWNCOUNT";
const string AMI_DCNT  = "_DEATHCOUNT";
const string AMS_BSREF = "_STANDARDREF";
const string AMO_ENTRY = "_ENTRYPOINTS";
// Army Cover Fire 
const string ACL_LNCH  = "_LAUNCHLOCATIONS";
const string ACL_TRGT  = "_TARGETLOCATIONS";
const string ACS_BRR   = "_BARRAGE";
const string ACS_CTP   = "_CATAPULT";
const string ACI_FQN   = "_FREQUENCY";
const string ACI_CDN   = "_COOLDOWN";
const string ACI_QTY   = "_QUANTITY";
const string ACI_DMG   = "_DAMAGE";
const string ACI_SDC   = "_SAVEDC";
// Army Soldier Type
const string ATO_TMPLT = "_TYPE_TEMPLATES";
const string ATS_TMPLT = "_TYPE_RESREFS";
const string ATI_RSRV  = "_TYPE_RESERVES";
const string ATI_LVADJ = "_TYPE_LVADJUSTS";
const string ATI_PRCNT = "_TYPE_PERCENTAGES";
// Individual Soldier
const string BSS_ARMY  = "ARMY";
const string BSI_ROUTE = "ATTACKROUTE";
const string BSI_ARNXT = "ATTACKROUTENEXT";
const string BSS_HBS   = "HEARTBEAT";
const string BSS_ODS   = "ONDEATH";
// PC
const string PCI_KCNT  = "KOCOUNT";
const string PCI_KTTL  = "KOTOTAL";
// Official
const string OFI_NTRSR = "X2_L_NOTREASURE";
// =================================================================
// Tags & resrefs
const string VFX_SMOKE = "n2_fx_fire_smoke";
const string SFX_BTTL  = "sfx_battle";
const string PLC_IP    = "plc_ipoint ";
const string PLC_BC    = "plc_battlecontrol";
const string WP_EP     = "wp_ep_"; //wp_ep_armyname
const string WP_AR     = "wp_r";   //wp_rx_armyname_x
// Scripts
const string SCR_PL_HB = "s_bt_pl_heartbeat";
const string SCR_CR_HB = "s_bt_cr_heartbeat";
const string SCR_CR_OD = "s_bt_cr_ondeath";
const string SCR_EX_VD = "s_bt_ex_victorydefeat";
// =================================================================
// Prototypes
// =================================================================

// Battle Preparation
object GetBattleControl();
string EntryPointTag(string sArmy);
string AttackPointTag(string sArmy, int iR, int iN);
int GetNearestAttackRoute(string sArmy, object oEP);
void MapAttackRoute(string sArmy);
void CreateLaunchPoint(string sArmy, object oPTA, object oPTB);
void SetupLaunchPoint(string sArmy);
void CreateTemplate(string sArmy);
// Special effects
int GetFogOfWar();
void SetFogOfWar(int iOn);
void CreateFogOfWar();
void RemoveFogOfWar();
void StartBattleSFX();
void StopBattleSFX();
void ResetKOCount();
// Army Settings
void DestroyTroop(string sArmy);
void DeleteArmy(string sArmy, int iDestroy=TRUE);
void CreateArmy(string sArmy, int iFct, int iRsrv, int iLmt);
void AddSoldier(string sArmy, string sRes, int iPrcnt, int iLvAdj=-1);
void ReinforeArmy(string sArmy, int iAmt);
void ShowArmyStat(string sArmy, object oPC);
int GetIsArmyAnnihilated(string sArmy);
int GetIsAnnihilated(object oPC, int iRpt);
// Cover Fire Settings
void SetCoverFire(string sName, int iF, int iN, int iD, int iDC);
void SetBarrage(string sArmy, int iF=3, int iN=20, int iD=1, int iDC=10);
void SetCatapult(string sArmy, int iF=5, int iN=4, int iD=5, int iDC=10);
void DeleteCoverFire(string sName);
void DeleteBarrage(string sArmy);
void DeleteCatapult(string sArmy);
int GetIsCoverFireSet(string sName);
int GetIsBarrageSet(string sArmy);
int GetIsCatapultSet(string sArmy);
// Battle Settings
int GetIsBattleActive();
void SetBattleActive(int iBol);
void AbortBattle();
void BeginBattle(string sVD="");
void ShowBattleStat(object oPC, string sTtl="", string sSrc="");
// =================================================================
// Battle Control Object (Private Use)
// =================================================================

// Get the battle control object (invisible placeable)(ipoint).
// Create one if missing. Battle control monitors the battlefield 
// and performs all neccessary administration using heartbeat script.
// Originally planned to use Area heartbeat to act as Battle control
// but SetEventHandler does not work on area
object GetBattleControl(){
	object oAR = GetArea(OBJECT_SELF);
	object oBC = GetLocalObject(oAR, ARO_BCTRL);
	if( !GetIsObjectValid(oBC) ){
		// Battle control not exist, Create one
		oBC = CreatePlacable(PLC_IP, OBJECT_SELF, PLC_BC);
		// Register New Battle Control
		SetPlotFlag(oBC, TRUE);
		SetEventHandler(oBC, SCRIPT_PLACEABLE_ON_HEARTBEAT, SCR_PL_HB);
		SetLocalObject(oAR, ARO_BCTRL, oBC);
	}
	return oBC;
}
// =================================================================
// Battle Preparations (Private Use)
// =================================================================

// Construct a tag of Entry Point
// wp_ep_armyname
string EntryPointTag(string sArmy){
	return WP_EP + sArmy;
}
// Construct a tag of a point of an Attack Route
// wp_rx_armyname_x
// iR : route number
// iN : attack route stage
string AttackPointTag(string sArmy, int iR, int iN){
	return WP_AR + IntToString(iR) +"_"+ sArmy +"_"+ IntToString(iN);
}
// =================================================================

// Find the nearest Attack Route to Entry Point
int GetNearestAttackRoute(string sArmy, object oEP){
	int    iN  = 0;
	int    iAR = iN;
	string sTG = AttackPointTag(sArmy, iN, 0);
	object oPT = GetNearestObjectByTag(sTG, oEP);
	float  fPT = GetDistanceBetween(oEP, oPT);
	float  fAR = fPT;
	while( GetIsObjectValid(oPT) ){
		if( fPT < fAR ){ iAR = iN; fAR = fPT; }
		// Next
		iN ++;
		sTG = AttackPointTag(sArmy, iN, 0);
		oPT = GetNearestObjectByTag(sTG, oEP);
		fPT = GetDistanceBetween(oEP, oPT);
	}
	return iAR;
}
// Collect Information about Entry Points and Attack Route
// Map Entry Points to Attack Route
void MapAttackRoute(string sArmy){
	object oBC = GetBattleControl();
	int    iN  = 1;
	string sTG = EntryPointTag(sArmy);
	object oEP = GetNearestObjectByTag(sTG, oBC, iN);

	ObjectArrayDelete(oBC, sArmy + AMO_ENTRY, FALSE);
	MyDebug("Map Attack Route", sArmy);
	
	while( GetIsObjectValid(oEP) ){
		int iAR = GetNearestAttackRoute(sArmy, oEP);
		SetLocalInt(oEP, BSI_ROUTE, iAR);
		ObjectArrayPush(oBC, sArmy + AMO_ENTRY, oEP);
		
		MyDebugLog("Map Entry Point " +IntToString(iN));
		MyDebugLog(" to Route " +IntToString(iAR));
		MyDebugFlush(sArmy);
		// Next
		iN ++;
		oEP = GetNearestObjectByTag(sTG, oBC, iN);
	}
}
// =================================================================

// Calculate A Set of Points for Launching missiles
void CreateLaunchPoint(string sArmy, object oPTA, object oPTB){
	object oBC  = GetBattleControl();
	vector vPTA = GetPosition(oPTA);
	vector vPTB = GetPosition(oPTB);
	vector vSrc = Vector();
	vector vTrg = Vector();
	float  fSMT = 1.5f;
	float  fTMT = 0.6f;
	
	vTrg.x = vPTA.x + (vPTB.x - vPTA.x) *fTMT;
	vTrg.y = vPTA.y + (vPTB.y - vPTA.y) *fTMT;
	vTrg.z = vPTA.z + (vPTB.z - vPTA.z) *fTMT;
	vSrc.x = vPTB.x + (vPTA.x - vPTB.x) *fSMT;
	vSrc.y = vPTB.y + (vPTA.y - vPTB.y) *fSMT;
	vSrc.z = vPTB.z + (vPTA.z - vPTB.z) *fSMT + 10.0f;
	location lSrc = Location(GetArea(oPTA), vSrc, 0.0f);
	location lTrg = Location(GetArea(oPTA), vTrg, 0.0f);
	LocationArrayPush(oBC, sArmy + ACL_LNCH, lSrc);
	LocationArrayPush(oBC, sArmy + ACL_TRGT, lTrg);
	
	MyDebugLog(FormatLocation(lSrc) +" >> ");
	MyDebugLog(FormatLocation(lTrg));
	MyDebugFlush(sArmy);
}
// Setup Launch Points for barrages and catapults
// base on the location of Entry Points
void SetupLaunchPoint(string sArmy){
	object oBC = GetBattleControl();
	int    iAX = StringArrayLen(oBC, BCS_BARMY);
	int    iEC = ObjectArrayLen(oBC, sArmy + AMO_ENTRY);
	int    iFC = GetLocalInt(oBC, sArmy + AMI_FCTN);
	int    iAR;
	int    iEP;
	
	LocationArrayDelete(oBC, sArmy + ACL_LNCH);
	LocationArrayDelete(oBC, sArmy + ACL_TRGT);
	MyDebug("Setup Launch Points", sArmy);
	
	for( iAR=0; iAR<iAX; iAR++ ){
		string sTrg = StringArrayGet(oBC, BCS_BARMY, iAR);
		string sTag = EntryPointTag(sTrg);
		int    iTFC = GetLocalInt(oBC, sTrg + AMI_FCTN);
		
		if( iFC != iTFC ){
			for( iEP=0; iEP<iEC; iEP++ ){
				object oEP = ObjectArrayGet(oBC, sArmy + AMO_ENTRY, iEP);
				object oPT = GetNearestObjectByTag(sTag, oEP);
				CreateLaunchPoint(sArmy, oEP, oPT);
			}
		}
	}
}
// =================================================================

// Create Soldier Templates for the Amry. They are used for further copying
void CreateTemplate(string sArmy){
	object oBC = GetBattleControl();
	object oEP = ObjectArrayCycle(oBC, sArmy + AMO_ENTRY);
	int    iFC = GetLocalInt(oBC, sArmy + AMI_FCTN);
	int    iTP = StringArrayLen(oBC, sArmy + ATS_TMPLT);
	int    iAL = GetPCAverageLevel();
	int    iN;
	// Destroy Old Templates
	ObjectArrayDelete(oBC, sArmy + ATO_TMPLT, TRUE);
	// Go thru all Templates
	for( iN=0; iN<iTP; iN++ ){
		int    iAdj = IntArrayGet(oBC, sArmy + ATI_LVADJ, iN);
		string sRef = StringArrayGet(oBC, sArmy + ATS_TMPLT, iN);
		string sTag = sRef +"_"+ IntToString(iN);
		object oBP  = CreateCreature(sRef, oEP, sTag);
		// Set hidden
		SetPlotFlag(oBP, TRUE);
		SetScriptHidden(oBP, TRUE, TRUE);
		// Adjust Level
		if( iAdj >= 0 ){ 
			LevelUpCreature(oBP, (iAL*iAdj/100), TRUE); 
			ForceRest(oBP);	
		}
		ChangeToStandardFaction(oBP, iFC);
		ObjectArrayPush(oBC, sArmy + ATO_TMPLT, oBP);
		MyDebugLog("Create template " +sTag);
		MyDebugLog(" Level " +IntToString(GetTotalLevels(oBP,TRUE)));
		MyDebugFlush(sArmy);
	}
}
// =================================================================

// Get Fog of War Effect
int GetFogOfWar(){
	object oBC = GetBattleControl();
	return GetLocalInt(oBC, BCI_BFOW);
}
// Set Fog of War Effect
void SetFogOfWar(int iOn){
	object oBC = GetBattleControl();
	SetLocalInt(oBC, BCI_BFOW, iOn);
}
// Create Fog of War Effect
void CreateFogOfWar(){
	if( !GetFogOfWar() ){ return; }
	object oBC  = GetBattleControl();
	int    iA   = StringArrayLen(oBC, BCS_BARMY);
	int    iTyp = OBJECT_TYPE_PLACED_EFFECT;
	int    iS   = 10/iA;
	int    iN, iM;
	MyDebug("Create Fog Of War", "Battle Control");
	ObjectArrayDelete(oBC, BCO_BFOW, TRUE);
	for( iN=0; iN<iA; iN++ ){
		string sArmy = StringArrayGet(oBC, BCS_BARMY, iN);
		for( iM=0; iM<iS; iM++ ){
			location lLoc = LocationArrayCycle(oBC, sArmy + ACL_TRGT);
			lLoc = GetOffsetLocation(lLoc, 0.0f, 0.0f, -8.0f);
			lLoc = GetDeviatedLocation(lLoc);
			object oFOW = CreateObject(iTyp, VFX_SMOKE, lLoc, FALSE, VFX_SMOKE);
			ObjectArrayPush(oBC, BCO_BFOW, oFOW);
		}
	}
}
// Remove Fog of War Effect
void RemoveFogOfWar(){
	object oBC  = GetBattleControl();
	ObjectArrayDelete(oBC, BCO_BFOW, TRUE);
}
// -------------------------------------------------------

// Start Battle Sound Effect
void StartBattleSFX(){
	object oBC = GetBattleControl();
	object oFX = GetNearestObjectByTag(SFX_BTTL, oBC); 
	SoundObjectPlay(oFX);
}
// Stop Battle Sound Effect
void StopBattleSFX(){
	object oBC = GetBattleControl();
	object oFX = GetNearestObjectByTag(SFX_BTTL, oBC); 
	SoundObjectStop(oFX);
}
// -------------------------------------------------------

// Reset KO Count
void ResetKOCount(){
	object oFM = GetFirstFactionMember(GetFirstPC(), FALSE);
	while( GetIsObjectValid(oFM) ){
		if( GetIsPC(oFM)
		 || GetIsOwnedByPlayer(oFM)
		 || GetIsRosterMember(oFM) ){
			SetLocalInt(oFM, PCI_KCNT, 0);
		}
		oFM = GetNextFactionMember(GetFirstPC(), FALSE);
	}
}
// =================================================================
// Army Cover Fire Settings (Public)
// =================================================================

// Setup Cover Fire
void SetCoverFire(string sName, int iF, int iN, int iD, int iDC){
	object oBC = GetBattleControl();
	SetLocalInt(oBC, sName + ACI_FQN, iF);
	SetLocalInt(oBC, sName + ACI_CDN, iF);
	SetLocalInt(oBC, sName + ACI_QTY, iN);
	SetLocalInt(oBC, sName + ACI_DMG, iD);
	SetLocalInt(oBC, sName + ACI_SDC, iDC);
}
// Delete Cover Fire
void DeleteCoverFire(string sName){
	object oBC = GetBattleControl();
	DeleteLocalInt(oBC, sName + ACI_FQN);
	DeleteLocalInt(oBC, sName + ACI_CDN);
	DeleteLocalInt(oBC, sName + ACI_QTY);
	DeleteLocalInt(oBC, sName + ACI_DMG);
	DeleteLocalInt(oBC, sName + ACI_SDC);
}
// Get Is Cover Fire set
int GetIsCoverFireSet(string sName){
	object oBC = GetBattleControl();
	return GetLocalInt(oBC, sName + ACI_QTY) > 0;
}
// -------------------------------------------------------

// Setup Barrage for sArmy
// iF  : Cool Down time (in rounds)
// iN  : No of arrows
// iD  : Damage (how many d6)
// iDC : Save DC
void SetBarrage(string sArmy, int iF=3, int iN=20, int iD=1, int iDC=10){
	SetCoverFire(sArmy + ACS_BRR, iF, iN, iD, iDC);
}
// Delete Barrage for sArmy
void DeleteBarrage(string sArmy){
	DeleteCoverFire(sArmy + ACS_BRR);
}
// Get Is Barrage set for sArmy
int GetIsBarrageSet(string sArmy){
	return GetIsCoverFireSet(sArmy + ACS_BRR);
}
// -------------------------------------------------------

// Setup Catapult for sArmy
// iF  : Cool Down time (in rounds)
// iN  : No of projectile
// iD  : Damage (how many d6)
// iDC : Save DC
void SetCatapult(string sArmy, int iF=5, int iN=4, int iD=5, int iDC=10){	
	SetCoverFire(sArmy + ACS_CTP, iF, iN, iD, iDC);
}
// Delete Catapult for sArmy
void DeleteCatapult(string sArmy){
	DeleteCoverFire(sArmy + ACS_CTP);
}
// Get Is Catapult set for sArmy
int GetIsCatapultSet(string sArmy){
	return GetIsCoverFireSet(sArmy + ACS_CTP);
}
// =================================================================
// Army Setting (Public)
// =================================================================

// Destroy sArmy's existing troops
void DestroyTroop(string sArmy){
	object oBC  = GetBattleControl();
	int    iN   = 1;
	int    iTyp = OBJECT_TYPE_CREATURE;
	object oTrg = GetNearestObject(iTyp, oBC, iN);
	while( GetIsObjectValid(oTrg) ){
		if( !GetIsOwnedByPlayer(oTrg) && !GetIsPC(oTrg) ){
			if( GetLocalString(oTrg, BSS_ARMY) == sArmy ){
				MyDebug("Destroy "+GetTag(oTrg), sArmy);
				DestroyObject(oTrg);
			}
		}
		iN ++;
		oTrg = GetNearestObject(iTyp, oBC, iN);
	}
}
// Delete an army
// sArmy 	: Army Name
// iDestroy : Destroy existing troops if true
void DeleteArmy(string sArmy, int iDestroy=TRUE){
	object oBC = GetBattleControl();
	int    iID = StringArrayFind(oBC, BCS_BARMY, sArmy);
	// Unregister Army
	if( iID >= 0 ){ StringArrayRemove(oBC, BCS_BARMY, iID); }
	// Destroy soldiers
	if( iDestroy ){ DestroyTroop(sArmy); }
	// Delete Class data
	ObjectArrayDelete(oBC, sArmy + ATO_TMPLT, TRUE);
	StringArrayDelete(oBC, sArmy + ATS_TMPLT);
	IntArrayDelete(oBC, sArmy + ATI_RSRV);
	IntArrayDelete(oBC, sArmy + ATI_PRCNT);
	IntArrayDelete(oBC, sArmy + ATI_LVADJ);
	// Delete Statistical data
	ObjectArrayDelete(oBC, sArmy + AMO_ENTRY);
	DeleteLocalString(oBC, sArmy + AMS_BSREF);
	DeleteLocalInt(oBC, sArmy + AMI_FCTN);
	DeleteLocalInt(oBC, sArmy + AMI_SLMT);
	DeleteLocalInt(oBC, sArmy + AMI_SCNT);
	DeleteLocalInt(oBC, sArmy + AMI_DCNT);
	DeleteLocalInt(oBC, sArmy + AMI_TTL);
	DeleteLocalInt(oBC, sArmy + AMI_RSRV);
	// Delete Cover Fire Data
	LocationArrayDelete(oBC, sArmy + ACL_LNCH);
	LocationArrayDelete(oBC, sArmy + ACL_TRGT);
	DeleteBarrage(sArmy);
	DeleteCatapult(sArmy);
	MyDebug("Destroyed", sArmy);
}
// -------------------------------------------------------

// Create a new army (Overwrites army with the same name)
//
// sArmy : Army Name
// iFct  : which faction the army belongs to
// iRsrv : how many troops the army has in total
// iLmt	 : how many troops the army can command at one time
//
// e.g. CreateArmy("Enemy", 0, 100, 10); 
// creates an Enemy army with 100 men and attacks in waves of 10
//
// note: must call AddSoldier afterward to add soldier type
// to the army. 
void CreateArmy(string sArmy, int iFct, int iRsrv, int iLmt){
	object oBC = GetBattleControl();
	DeleteArmy(sArmy);
	StringArrayPush(oBC, BCS_BARMY, sArmy);
	SetLocalInt(oBC, sArmy + AMI_FCTN, iFct);
	SetLocalInt(oBC, sArmy + AMI_TTL , iRsrv);
	SetLocalInt(oBC, sArmy + AMI_SLMT, iLmt);
	SetLocalInt(oBC, sArmy + AMI_RSRV, 0);
	SetLocalInt(oBC, sArmy + AMI_DCNT, 0);
	SetLocalInt(oBC, sArmy + AMI_SCNT, 0);
	MyDebug("Created", sArmy);
}
// Add a soldier type to the army
//
// sArmy  : Army Name
// sRes   : ResRef for the type
// iPrcnt : The percentage of this type in the army 
//          If total percentage (include previously added type)
//          exceeds 100, the excess will be ignored
// iLvAdj : Level adjustment (relative to PC), -1 for no adjustment
//
// e.g. AddSolider("Enemy", "c_skeleton", 50); 
//      AddSolider("Enemy", "c_zombie", 55); 
// makes the Enemy Army consists of skeletons and zombies (50/50)
// the 5% excess of zombie is ignored
void AddSoldier(string sArmy, string sRes, int iPrcnt, int iLvAdj=-1){
	object oBC = GetBattleControl();
	int    iRS = GetLocalInt(oBC, sArmy + AMI_RSRV);
	int    iTT = GetLocalInt(oBC, sArmy + AMI_TTL);
	int    iP  = (iTT * iPrcnt/100); // calculate allocation
	int    iQ  = (iTT - iRS);        // calculate reserve left
	// exceed reserve, use what's left
	if( iP > iQ ){ iP = iQ; }
	// if army not exist or reserve out, iP = 0, nothing happens
	if( iP > 0 ){
		StringArrayPush(oBC, sArmy + ATS_TMPLT , sRes);
		IntArrayPush(oBC, sArmy + ATI_RSRV , iP);
		IntArrayPush(oBC, sArmy + ATI_LVADJ, iLvAdj);
		IntArrayPush(oBC, sArmy + ATI_PRCNT, iPrcnt);
		IncLocalInt(oBC, sArmy + AMI_RSRV, iP);
		MyDebug("Adds "+ IntToString(iP) +" "+ sRes, sArmy);
	}
}
// -------------------------------------------------------

// sArmy  : Army Name
// sRes   : ResRef for the Battle Standard
void SetBattleStandard(string sArmy, string sRes){
	object oBC = GetBattleControl();
	SetLocalString(oBC, sArmy + AMS_BSREF, sRes);
}
// -------------------------------------------------------

// Reinforce an army (divided among soldier types)
// sArmy : Army Name
// iAmt  : Reinforcement
void ReinforeArmy(string sArmy, int iAmt){
	object oBC = GetBattleControl();
	int    iTP = StringArrayLen(oBC, sArmy + ATS_TMPLT);
	int    iQ  = iAmt;
	int    iN;
	MyDebugSeperator();
	MyDebug("Reinforced by " + IntToString(iAmt), sArmy);
	// Go thru all known types and allocate
	for( iN=0; iN<iTP; iN++ ){
		string sRF = StringArrayGet(oBC, sArmy + ATS_TMPLT, iN);
		int    iRS = IntArrayGet(oBC, sArmy + ATI_RSRV, iN);
		int    iPC = IntArrayGet(oBC, sArmy + ATI_PRCNT, iN);
		int    iP  = (iAmt * iPC/100);
		if( iP > iQ ){ iP = iQ; }
		IntArraySet(oBC, sArmy + ATI_RSRV, iN, (iRS+iP));
		IncLocalInt(oBC, sArmy + AMI_RSRV, iP);
		iQ -= iP;
		MyDebug(IntToString(iP)+ " allocated to " + sRF, sArmy);
	}
	IncLocalInt(oBC, sArmy + AMI_TTL, iAmt);
}
// -------------------------------------------------------

// Print army statistics
void ShowArmyStat(string sArmy, object oPC){
	object oBC = GetBattleControl();
	string sST = "";
	int    iFC = GetLocalInt(oBC, sArmy + AMI_FCTN);
	int    iSL = GetLocalInt(oBC, sArmy + AMI_SLMT);
	int    iSC = GetLocalInt(oBC, sArmy + AMI_SCNT);
	int    iSD = GetLocalInt(oBC, sArmy + AMI_DCNT);
	int    iTT = GetLocalInt(oBC, sArmy + AMI_TTL);
	int    iRS = GetLocalInt(oBC, sArmy + AMI_RSRV);
	int    iTP = StringArrayLen(oBC, sArmy + ATS_TMPLT);
	int    iRM = iRS + iSC;
	int    iN;

	sST += "\n"+ Bold(Gold(sArmy)) +"\n\n";
	sST += "Faction : " +GetStandardFactionName(iFC)+"\n";
	sST += "Troops : " +IntToString(iRM) +"/"+ IntToString(iTT)+"\n";
	sST += "Casualties : " +IntToString(iSD)+"\n";
	sST += "Deployed : " +IntToString(iSC)+"/"+ IntToString(iSL)+"\n\n";
	sST += "Reserves : " +IntToString(iRS)+"\n";
	for( iN=0; iN<iTP; iN++ ){
		string sCRF = StringArrayGet(oBC, sArmy + ATS_TMPLT, iN);
		int    iCRS = IntArrayGet(oBC, sArmy + ATI_RSRV, iN);
		sST += sCRF +" : "+ IntToString(iCRS) +"\n";
	}
	ShowReport(oPC, sST, "");
}
// -------------------------------------------------------

// Get is Army Annihilated
// Return TRUE if Annihilated
int GetIsArmyAnnihilated(string sArmy){
	object oBC = GetBattleControl();
	int    iRS = GetLocalInt(oBC, sArmy + AMI_RSRV);
	int    iSC = GetLocalInt(oBC, sArmy + AMI_SCNT);
	return (iRS + iSC) <= 0;
}
// Is all armies of factional reputation Annihilated
// oPC Annihilated
// oPC  : PC
// iRpt : REPUTATION_TYPE_*
int GetIsAnnihilated(object oPC, int iRpt){
	object oBC = GetBattleControl();
	object oPC = GetFirstPC(FALSE);
	int    iA  = StringArrayLen(oBC, BCS_BARMY);
	int    iN;
	for( iN=0; iN<iA; iN++ ){
		string sArmy = StringArrayGet(oBC, BCS_BARMY, iN);
		int    iFct  = GetLocalInt(oBC, sArmy + AMI_FCTN);
		if( GetFactionDisposition(iFct, oPC) == iRpt ){
			if( !GetIsArmyAnnihilated(sArmy) ){ return FALSE; }
		}
	}
	return TRUE;
}
// =================================================================
// Battle Flow Control (Public)
// =================================================================

// Is Battle Active?
int GetIsBattleActive(){
	return GetLocalInt(GetBattleControl(), BCI_BACTV);
}
// Set Battle Active/Inactive
void SetBattleActive(int iBol){
	object oBC = GetBattleControl();
	if( iBol ){
		ResetKOCount();
		CreateFogOfWar();
		StartBattleSFX();
	}else{
		RemoveFogOfWar();
		StopBattleSFX();
	}
	SetLocalInt(oBC, BCI_BACTV, iBol);
}
// -------------------------------------------------------

// Begins the battle
// sVD : Vicotry/Defeat script (Default will be used if empty)
void BeginBattle(string sVD=""){
	if( GetIsBattleActive() ){ return; }
	
	object oBC = GetBattleControl();
		// wired 08/12/2011
	object oPC = GetLocalObject(GetArea(oBC),"oPartyLeader");
	
	// Initiate Armies
	int iA = StringArrayLen(oBC, BCS_BARMY);
	int iN;
	for( iN=0; iN<iA; iN++ ){
		string sArmy = StringArrayGet(oBC, BCS_BARMY, iN);
		MyDebugSeperator();
		MapAttackRoute(sArmy);
		SetupLaunchPoint(sArmy);
		CreateTemplate(sArmy);
	}
	// Start Battle
	MyDebugSeperator();
	SetLocalString(oBC, BCS_BVCDF, sVD);
	SetLocalInt(GetModule(), OFI_NTRSR, TRUE);
	SetBattleActive(TRUE);
	SendMessageToAllPC("Battle Begins",oPC);
}
// Aborts the battle
void AbortBattle(){
	if( !GetIsBattleActive() ){ return; }
	
	object oBC = GetBattleControl();
	// wired 08/12/2011
	object oPC = GetLocalObject(GetArea(oBC),"oPartyLeader");
	
	// Stop Battle
	MyDebugSeperator();
	SetBattleActive(FALSE);
	SetLocalInt(GetModule(), OFI_NTRSR, FALSE);
	// Destroy all armies
	while( StringArrayLen(oBC, BCS_BARMY) > 0 ){
		DeleteArmy(StringArrayGet(oBC, BCS_BARMY, 0), TRUE);
	}
	SendMessageToAllPC("Battle Aborted",oPC);
}
// -------------------------------------------------------

// Show the battle's statistics
// sTtl : Title
// sSrc : script to run when ok is clicked
void ShowBattleStat(object oPC, string sTtl="", string sSrc=""){
	object oBC = GetBattleControl();
	object oFM = GetFirstFactionMember(oPC, FALSE);
	int    iA  = StringArrayLen(oBC, BCS_BARMY);
	string sST = "";
	int    iN;
	if( sTtl != "" ){ 
		sST += Bold(Gold(sTtl))+"\n\n"; 
	}
	if( iA > 0 ){ 
		sST += Bold(Orange("Army Statistics"))+"\n\n"; 
	}
	for( iN=0; iN<iA; iN++ ){
		string sArmy = StringArrayGet(oBC, BCS_BARMY, iN);
		int    iFC   = GetLocalInt(oBC, sArmy + AMI_FCTN);
		int    iTT   = GetLocalInt(oBC, sArmy + AMI_TTL);
		int    iSD   = GetLocalInt(oBC, sArmy + AMI_DCNT);
		sST += Bold(sArmy) +"\n";
		sST += "Faction : "+ GetStandardFactionName(iFC) +"\n";
		sST += "Troops : "+ IntToString(iTT) +"\n";
		sST += "Casualties : "+ IntToString(iSD) +"\n\n";
	}
	if( GetIsObjectValid(oFM) ){ 
		sST += Bold(Orange("Personal Statistics"))+"\n\n"; 
	}
	while( GetIsObjectValid(oFM) ){
		sST += Bold(GetName(oFM))+"\n";
		sST += "Kills : "+ IntToString(GetLocalInt(oFM, PCI_KCNT)) +"\n";
		sST += "Total : "+ IntToString(GetLocalInt(oFM, PCI_KTTL)) +"\n\n";
		oFM = GetNextFactionMember(oPC, FALSE);
	}
	ShowReport(oPC, sST, sSrc);
}