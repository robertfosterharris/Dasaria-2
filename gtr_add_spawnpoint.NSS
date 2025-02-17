#include "std_persist_i0"
#include "ginc_spawnsystem"

void main()
{
	object oPC;
	object oJournal;
// RW 20140202 Needs to be updated to new spawnsystem	
/*	
	int iDasariaSpawnK;
	int iDasariaSpawnS;
	int iDasaria_Spawn_Upperbound;
	int iWPID;
	string sWPID;
	string sSelectedLocationUpdate;
	
	oPC = GetEnteringObject();
	if(!GetIsPC(oPC))return;
	
	oJournal = std_journal_get(oPC);
	iDasariaSpawnK = GetLocalInt(oJournal, "iDasariaSpawnK");
	iDasariaSpawnS = GetLocalInt(oJournal, "iDasariaSpawnS");
	iDasaria_Spawn_Upperbound = (DASARIA_SPAWN_WP1_KNOW<<(DASARIA_SPAWN_MAX_TICKBOXES-1));
	
	// this should be the tag of a waypoint on the trigger
	sSelectedLocationUpdate = GetLocalString(OBJECT_SELF,"sSelectedLocationUpdate");
		
	sWPID = GetStringRight(sSelectedLocationUpdate,2);
	iWPID = StringToInt(sWPID);
	iWPID = (DASARIA_SPAWN_WP1_KNOW << (iWPID-1));
	
	if(( iWPID & iDasariaSpawnK ) == FALSE)
	{
	iDasariaSpawnK |= iWPID;
	SetLocalInt(oJournal,"iDasariaSpawnK",iDasariaSpawnK); 
	
	SendMessageToPC(oPC,"A new spawn point location has become available to you : "+sGet_LocationsName(iWPID, 1));
	}
*/	
}