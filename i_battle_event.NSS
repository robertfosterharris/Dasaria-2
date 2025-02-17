#include "i_battle_setting"
// =================================================================
// Battle Events
// 
// By Nytir
// =================================================================

// =================================================================
// Prototypes
// =================================================================

// Battle Control
int SpawnProbablity(string sArmy, int iN, int iTR, int iRD);
void SpawnSoldier(string sArmy, int iN, string sFG="");
void SpawnPlatoon(string sArmy);
void ApplyCatapultEffect(location lLoc, int iFac, int iD, int iDC);
void FireCatapult(location lSrc, location lTrg, int iFac, int iD, int iDC);
void FireArrow(location lSrc, location lTrg, int iFac, int iD, int iDC, int iF=FALSE);
void LaunchCoverFire(string sArmy, string sType);
void BattleControlHB();
// Battle Spawn
void ReportCasualty(object oBS = OBJECT_SELF);
void IncKOCount(object oBS = OBJECT_SELF);
void BattleCharge(object oBS = OBJECT_SELF);
void BattleSpawnHB();
void BattleSpawnOD();
// =================================================================
// Battle Control Events
// =================================================================

// Get a Spawn Probablity Test Result
// sArmy : Army
// iN    : Soldier Type ID
// iTR   : total reserve left
// iRD   : P = Type Reserve/ Total Reserve if true
//         P = 1 for Type Reserve > 0 if false
// Return TRUE if passed the Probablity Test
int GetSpawnProbablity(string sArmy, int iN, int iTR, int iRD){
	object oBC = GetBattleControl();
	int    iRS = IntArrayGet(oBC, sArmy + ATI_RSRV, iN);
	if( iRD ){ 
		return (Random(iTR)+1 <= iRS ); 
	}
	return (iRS > 0);
}
// Spawns a Soldier
// sArmy : Army
// iN    : Soldier Type ID
// iFC   : Faction to join
void SpawnSoldier(string sArmy, int iN, string sFG=""){
	object oBC = GetBattleControl();
	object oBP = ObjectArrayGet(oBC, sArmy + ATO_TMPLT, iN);
	int    iRS = IntArrayGet(oBC, sArmy + ATI_RSRV, iN);
	string sTG = GetTag(oBP) +"_"+ IntToString(iRS);
	object oEP = ObjectArrayCycle(oBC, sArmy + AMO_ENTRY);
	object oBS = CopyObject(oBP, GetLocation(oEP), OBJECT_INVALID, sTG);
	int    iAR = GetLocalInt(oEP, BSI_ROUTE);
	if( !GetIsObjectValid(oBS) ){
		// CopyObject does not return the new object properly after 
		// I installed MOTB. This is plan B.
		oBS = GetNearestObjectByTag(sTG, oEP);
	}
	// Update statistics
	IntArraySet(oBC, sArmy + ATI_RSRV, iN, (iRS-1) ); //Type Reserve
	IncLocalInt(oBC, sArmy + AMI_RSRV, -1);           //Total Reserve
	IncLocalInt(oBC, sArmy + AMI_SCNT, 1);            //Spawn Count
	// Set Up soldier
	SetLocalInt(oBS, BSI_ARNXT, 0);
	SetLocalInt(oBS, BSI_ROUTE, iAR);
	SetLocalString(oBS, BSS_ARMY, sArmy);
	SetLocalString(oBS, BSS_HBS, GetEventHandler(oBS, CREATURE_SCRIPT_ON_HEARTBEAT));
	SetLocalString(oBS, BSS_ODS, GetEventHandler(oBS, CREATURE_SCRIPT_ON_DEATH));
	SetEventHandler(oBS, CREATURE_SCRIPT_ON_HEARTBEAT, SCR_CR_HB);
	SetEventHandler(oBS, CREATURE_SCRIPT_ON_DEATH, SCR_CR_OD);
	if( sFG != "" ){
		object oFG = CreateItemOnObject(sFG, oBS);
		SetDroppableFlag(oFG, FALSE);
		FeatAdd(oBS, FEAT_MONKEY_GRIP, FALSE);
		AssignCommand(oBS, ActionEquipItem(oFG, INVENTORY_SLOT_LEFTHAND));
	}
	MyDebug("Spawn "+ sTG, sArmy);
	// Remove protection
	DelayCommand(0.5f, ExecuteScript(SCR_CR_HB, oBS));
	DelayCommand(1.0f, SetImmortal(oBS, FALSE));
	DelayCommand(1.0f, SetPlotFlag(oBS, FALSE));
	DelayCommand(1.5f, SetScriptHidden(oBS, FALSE));
}
// -------------------------------------------------------
// Spawn a Platoon for the army
// Spawn 0-5 soldiers per call depends on availability
void SpawnPlatoon(string sArmy){
	object oBC = GetBattleControl();
	string sFG = GetLocalString(oBC, sArmy + AMS_BSREF);
	int    iSL = GetLocalInt(oBC, sArmy + AMI_SLMT);
	int    iSC = GetLocalInt(oBC, sArmy + AMI_SCNT);
	int    iTR = GetLocalInt(oBC, sArmy + AMI_RSRV);
	int    iTP = StringArrayLen(oBC, sArmy + ATS_TMPLT);
	int    iPL = 5; //platoon limit
	int    iCL = 3; //cycle limit
	int    iN  = 0;
	// Cycle all soldier types and spawn randomly
	while( (iTR>0) && (iSC<iSL) && (iPL>0) ){
		if( GetSpawnProbablity(sArmy, iN, iTR, (iCL>0)) ){ 
			if( iTR%10 == 0 ){
				SpawnSoldier(sArmy, iN, sFG);
			}else{
				SpawnSoldier(sArmy, iN);
			}
			iSC ++;
			iTR --;
			iPL --;
		}
		iN ++;
		//One cycle passed
		if( iN >= iTP ){
			iCL --; 
			iN = 0;
		}
	}
}
// =================================================================

// Apply Catapult Effect
// lLoc : Location
// iFac : Faction of Catapult (will not harm friendly)
// iD   : Damage Dices (d6)
// iDC  : Save DC
void ApplyCatapultEffect(location lLoc, int iFac, int iD, int iDC){
	int    iN   = 1;
	int    iDF  = iD/4;
	int    iDB  = iDF*3;
	int    iTyp = OBJECT_TYPE_CREATURE;
	object oTrg = GetNearestObjectToLocation(iTyp, lLoc, iN);
	float  fDis = GetDistanceBetweenLocations(lLoc, GetLocation(oTrg));
	float  fRad = 18.0f;
	effect eKnc = EffectKnockdown();
	// Go trhu all creature within damage radius
	while( GetIsObjectValid(oTrg) && (fDis < fRad) ){
		if( GetFactionDisposition(iFac, oTrg) == REPUTATION_TYPE_ENEMY ){
			// Allows a relfex save
			if( ReflexSave(oTrg, iDC) == 0 ){
				effect eDamF = EffectDamage(d6(iDF), DAMAGE_TYPE_FIRE);
				effect eDamB = EffectDamage(d6(iDB), DAMAGE_TYPE_BLUDGEONING);
				ApplyEffectToObject(DURATION_TYPE_INSTANT, eDamF, oTrg);
				ApplyEffectToObject(DURATION_TYPE_INSTANT, eDamB, oTrg);
				ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eKnc, oTrg, 4.0f);
			}
		}
		iN ++;
		oTrg = GetNearestObjectToLocation(iTyp, lLoc, iN);
		fDis = GetDistanceBetweenLocations(lLoc, GetLocation(oTrg));
    }
}
// Fire a Catapult
// lSrc : Source Location
// lTrg : Target Location
// iFac : Faction of Catapult (will not harm friendly)
// iD   : Damage Dices (d6)
// iDC  : Save DC
void FireCatapult(location lSrc, location lTrg, int iFac, int iD, int iDC){
	int	   iSpl = SPELL_CATAPULT;
	int    iMtm = METAMAGIC_ANY;
	int	   iPth = PROJECTILE_PATH_TYPE_BALLISTIC_THROWN;
	object oInv = OBJECT_INVALID;
	object oTrg = GetRandomHostileByDisposition(lTrg, iFac);
	float  fTrv = GetProjectileTravelTime(lSrc, lTrg, iPth);
	// Create a visual effect (no damage)
	// Apply the effect when the projectile hit the ground
	SpawnSpellProjectile(oInv, oTrg, lSrc, lTrg, iSpl, iPth);
	DelayCommand(fTrv, ApplyCatapultEffect(lTrg, iFac, iD, iDC));
}
// Fire an Arrow
// lSrc : Source Location
// lTrg : Target Location
// iFac : Faction of Catapult (will not harm friendly)
// iD   : Damage Dices (d6)
// iDC  : Save DC
// iF   : Flame Arrow if true
void FireArrow(location lSrc, location lTrg, int iFac, int iD, int iDC, int iF=FALSE){
	int	   iBIt = BASE_ITEM_LONGBOW;
	int	   iTyp = DAMAGE_TYPE_PIERCING;
	int	   iAtt = OVERRIDE_ATTACK_RESULT_MISS;
	int	   iPth = PROJECTILE_PATH_TYPE_BALLISTIC_LAUNCHED;
	object oInv = OBJECT_INVALID;
	object oTrg = GetRandomHostileByDisposition(lTrg, iFac);
	if( iF ){ iTyp = DAMAGE_TYPE_FIRE; }
	if( GetIsObjectValid(oTrg) ){
		lTrg = GetLocation(oTrg);
		// Allows a relfex save
		if( ReflexSave(oTrg, iDC) == 0 ){
			effect eDam = EffectDamage(d6(iD), iTyp);
			float  fTrv = GetProjectileTravelTime(lSrc, lTrg, iPth);
			iAtt = OVERRIDE_ATTACK_RESULT_HIT_SUCCESSFUL;
			DelayCommand(fTrv, ApplyEffectToObject(DURATION_TYPE_INSTANT, eDam, oTrg));
		}
	}
	SpawnItemProjectile(oInv, oTrg, lSrc, lTrg, iBIt, iPth, iAtt, iTyp);
}
// Launch Cover Fire
// Nothing happens if cover fire is not set
// sArmy : Army
// sType : Cover Fire Type
void LaunchCoverFire(string sArmy, string sType){
	if( !GetIsCoverFireSet(sArmy + sType) ){ return; }
	object oBC = GetBattleControl();
	string sVN = sArmy + sType;
	int    iFC = GetLocalInt(oBC, sArmy + AMI_FCTN);
	int    iDC = GetLocalInt(oBC, sVN + ACI_SDC);
	int    iFQ = GetLocalInt(oBC, sVN + ACI_FQN);
	int    iD  = GetLocalInt(oBC, sVN + ACI_DMG);
	int    iN  = GetLocalInt(oBC, sVN + ACI_QTY);
	if( GetLocalInt(oBC, sVN + ACI_CDN) > 0 ){ 
		// Cool Down
		IncLocalInt(oBC, sVN + ACI_CDN, -1);
		return;
	}else{
		// Reset Cool Down and launch
		SetLocalInt(oBC, sVN + ACI_CDN, iFQ);
		while( iN > 0 ){
			location lSrc = LocationArrayCycle(oBC, sArmy + ACL_LNCH);
			location lTrg = LocationArrayCycle(oBC, sArmy + ACL_TRGT);
			if( sType == ACS_BRR ){ FireArrow(lSrc, lTrg, iFC, iD, iDC); }
			if( sType == ACS_CTP ){ FireCatapult(lSrc, lTrg, iFC, iD, iDC); }
			iN --;
		}
	}
}
// =================================================================
// Battle Control Heart Beat
void BattleControlHB(){
	if( !GetIsBattleActive() ){ return; }
	
	object oBC = OBJECT_SELF;
	string sVD = GetLocalString(oBC, BCS_BVCDF);
	int    iA  = StringArrayLen(oBC, BCS_BARMY);
	int    iN;
	// Do the standard stuff for all armies
	MyDebugSeperator();
	MyDebug("Upkeep", "Battle Control");
	for( iN=0; iN<iA; iN++ ){
		string sArmy = StringArrayGet(oBC, BCS_BARMY, iN);
		SpawnPlatoon(sArmy);
		LaunchCoverFire(sArmy, ACS_BRR); //Barrage
		LaunchCoverFire(sArmy, ACS_CTP); //Catapult
	}
	// Check for victory/defeat
	if( sVD != "" ){
		// Custom script defined
		ExecuteScript(sVD, oBC);
	}else{
		// Run default script
		ExecuteScript(SCR_EX_VD, oBC);
	}
}
// =================================================================
// Battle Spawn Events
// =================================================================

// Tell Battle control I am dead
void ReportCasualty(object oBS = OBJECT_SELF){
	object oBC = GetBattleControl();
	string sAR = GetLocalString(oBS, BSS_ARMY);
	//Update Statistics
	IncLocalInt(oBC, sAR + AMI_SCNT, -1); //Spawn Count
	IncLocalInt(oBC, sAR + AMI_DCNT, 1);  //Death Count
	MyDebug(GetTag(oBS) +" Despawn", sAR);
}
// Increase killer's KO Count, use in On Death Script
void IncKOCount(object oBS = OBJECT_SELF){
	object oKiller = GetLastKiller();
	if( GetIsObjectValid(GetMaster(oKiller)) ){
		//Add associates' kills to master's count
		oKiller = GetMaster(oKiller);
	}
	if( GetIsPC(oKiller)
	||  GetIsOwnedByPlayer(oKiller)
	||  GetIsRosterMember(oKiller) ){
		int    iKCnt = IncLocalInt(oKiller, PCI_KCNT, 1);
		int    iKTtl = IncLocalInt(oKiller, PCI_KTTL, 1);
		int    iTVol = TALKVOLUME_SHOUT;
		string sBCry = IntToString(iKCnt)+" !";
		AssignCommand(oKiller, SpeakString(sBCry, iTVol) );
	}
}
// Attack nearest hostile or follow attack route
void BattleCharge(object oBS = OBJECT_SELF){
	if( GetIsInCombat(oBS) ){ return; }
	
	int    iAR = GetLocalInt(oBS, BSI_ROUTE);
	int    iNX = GetLocalInt(oBS, BSI_ARNXT);
	string sAR = GetLocalString(oBS, BSS_ARMY);
	string sTG = AttackPointTag(sAR, iAR, iNX);
	object oAR = GetNearestObjectByTag(sTG, oBS);
	object oHT = GetNearestHostile(oBS);
	
	// Attack hostile
	if( GetIsObjectValid(oHT) ){
		float fAR = GetDistanceToObject(oAR)*1.5;
		float fHT = GetDistanceToObject(oHT);
		if( fHT < fAR ){
			AssignCommand(oBS, ActionAttack(oHT) );
			return;
		}
	}
	// Follow Attack Route
	if( GetIsObjectValid(oAR) ){
		if( MoveToObject(oBS, oAR, TRUE) ){
			iNX ++;
			sTG = AttackPointTag(sAR, iAR, iNX);
			oAR = GetNearestObjectByTag(sTG, oBS);
			if( GetIsObjectValid(oAR) ){
				// Move to next stage of attack route
				SetLocalInt(oBS, BSI_ARNXT, iNX);
				MoveToObject(oBS, oAR, TRUE);
			}
		}
	}
}
// =================================================================
void BattleSpawnHB(){
	object oBS = OBJECT_SELF;
	BattleCharge(oBS);
	// Execute original heartbeat
	ExecuteScript(GetLocalString(oBS, BSS_HBS), oBS);
}
void BattleSpawnOD(){
	object oBS = OBJECT_SELF;
	ReportCasualty(oBS);
	IncKOCount(oBS);
	// Execute original on death
	ExecuteScript(GetLocalString(oBS, BSS_ODS), oBS);
}