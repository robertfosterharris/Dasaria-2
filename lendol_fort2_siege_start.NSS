// lendol_fort2_siege
//
//
#include "ginc_group"
#include "ginc_ai"
#include "catapult_boulder_throw"

void SpawnTowers(string sGroupName, object oRep, int nEnemyFac)
{
	//SendMessageToAllDMs("Spawning Towers");
	
	object oTower1 = CreateObject(OBJECT_TYPE_CREATURE,"lendol_fort2_tower",GetLocation(GetObjectByTag("lendol_fort2_towera_sp")),TRUE,"lendol_fort2_towera");
	//SetLocalObject(OBJECT_SELF,"oRep",oRep);
	ChangeFaction(oTower1,oRep);
	GroupAddMember(sGroupName,oTower1);
	AIIgnoreCombat(oTower1);
	SetLocalString(oTower1,"sSpawn","lndol_"+IntToString(nEnemyFac)+"_swordsman");
	
	object oTower2 = CreateObject(OBJECT_TYPE_CREATURE,"lendol_fort2_tower",GetLocation(GetObjectByTag("lendol_fort2_towerb_sp")),TRUE,"lendol_fort2_towerb");
	//SetLocalObject(OBJECT_SELF,"oRep",oRep);
	ChangeFaction(oTower2,oRep);
	GroupAddMember(sGroupName,oTower2);
	AIIgnoreCombat(oTower2);
	SetLocalString(oTower2,"sSpawn","lndol_"+IntToString(nEnemyFac)+"_halberd");
	
}

void SpawnCats(string sGroupName, object oRep, int nEnemyFac)
{
	//SendMessageToAllDMs("Spawning Cats");
	location lCat1Spawn		= GetLocation(GetObjectByTag("lendol_fort2_cat1_sp"));
	location lCat2Spawn 	= GetLocation(GetObjectByTag("lendol_fort2_cat2_sp"));
	location lCat1GuySpawn	= GetLocation(GetObjectByTag("lendol_fort2_cat1guy_sp"));
	location lCat2GuySpawn 	= GetLocation(GetObjectByTag("lendol_fort2_cat2guy_sp"));	
	string sCatapult 		= "lendol_engine";
	string sCatapulter 		= "lndol_"+IntToString(nEnemyFac)+"_catapulter";
	object oTarget;
	
	object oGuy1 = CreateObject(OBJECT_TYPE_CREATURE,sCatapulter,lCat1GuySpawn);
	GroupAddMember(sGroupName,oGuy1);
	CreateObject(OBJECT_TYPE_PLACEABLE,sCatapult,lCat1Spawn);
	oTarget = GetNearestCreature( CREATURE_TYPE_PLAYER_CHAR, PLAYER_CHAR_IS_PC, oGuy1, 1, CREATURE_TYPE_IS_ALIVE, CREATURE_ALIVE_TRUE, CREATURE_TYPE_REPUTATION, REPUTATION_TYPE_ENEMY);
	SetLocalObject(oGuy1,"AIIntruderObj",oTarget);
	AssignCommand(oGuy1,attackWithCatapult(oTarget));
	
	object oGuy2 = CreateObject(OBJECT_TYPE_CREATURE,sCatapulter,lCat2GuySpawn);
	GroupAddMember(sGroupName,oGuy2);	
	CreateObject(OBJECT_TYPE_PLACEABLE,sCatapult,lCat2Spawn);
	oTarget = GetNearestCreature( CREATURE_TYPE_PLAYER_CHAR, PLAYER_CHAR_IS_PC, oGuy2, 1, CREATURE_TYPE_IS_ALIVE, CREATURE_ALIVE_TRUE, CREATURE_TYPE_REPUTATION, REPUTATION_TYPE_ENEMY);
	SetLocalObject(oGuy2,"AIIntruderObj",oTarget);
	AssignCommand(oGuy2,attackWithCatapult(oTarget));
}

void SpawnInfantry(string sGroupName, object oRep, int nEnemyFac)
{
	object oPCLeader	= GetLocalObject(GetArea(OBJECT_SELF),"oPartyLeader");
	//SendMessageToAllDMs("Spawning Infantry vs. oPCLeader "+GetFirstName(oPCLeader));
	string sSwords 		= "lndol_"+IntToString(nEnemyFac)+"_swordsman";
	string sHalberds 	= "lndol_"+IntToString(nEnemyFac)+"_halberd";
	string sArchers 	= "lndol_"+IntToString(nEnemyFac)+"_archer";
	string sPlayerGroupName = ObjectToString( oPCLeader );
	
	GroupSpawnAtWaypoint(sGroupName,sHalberds,"lendol_fort_inf1_sp",3);
	GroupSpawnAtWaypoint(sGroupName,sSwords,"lendol_fort_inf2_sp",3);
	GroupSpawnAtWaypoint(sGroupName,sArchers,"lendol_fort_inf3_sp",3);
	
	GroupMoveToObject(sGroupName, oPCLeader, MOVE_RUN);
}

void main()
{
	int nEnemyFac;
	string sGroupName = "lendose_ol_fort_enemies";
	object oRep;
	object oArea = OBJECT_SELF;
	int nMetaFaction =GetLocalInt(oArea,"bInUse");
	
	if (nMetaFaction == 3)
	{
		nEnemyFac = 1;		
		oRep = GetObjectByTag("d2_faction_imperial");
	}
	else
	{
		nEnemyFac = 3;
		oRep = GetObjectByTag("d2_faction_canite");
	}
	
	MusicBattlePlay(oArea);
	
	SpawnInfantry(sGroupName, oRep, nEnemyFac);

	DelayCommand(3.0f,SpawnTowers(sGroupName, oRep, nEnemyFac));	

	DelayCommand(5.0f,SpawnCats(sGroupName, oRep, nEnemyFac));	
	
	DelayCommand(10.0f,GroupOnDeathExecuteCustomScript(sGroupName,"lendol_fort2_siege_end"));

}