#include "ginc_spawnsystem"

/*

Spawn System V2 ~RW~
Add as an action to the convo and copy the TAG for the spawn WP you wish to have added to the characters spawn options.
*/
void main(string sSpawnWP_Tag)
{


object 	oPC = GetPCSpeaker();
object oJournal;

if(!GetIsPC(oPC))return;

oJournal = GetItemPossessedBy( oPC,"std_journal");
SetLocalString(oJournal, sSpawnWP_Tag ,sSpawnWP_Tag); 
SendMessageToPC(oPC,"A new spawn point location has become available to you : "+sGet_NameorWaypoint( sSpawnWP_Tag ));

}



/*
#include "ginc_spawnsystem"

/*

30/6/09 ~RW~
Replaces the case 3 section of code from gui_dasaria_spawn_loc which is failing to run correctly first time it is called via a conversation.
Add as an action to the convo and copy the TAG for the spawn WP you wish to have added to the characters spawn options.
*/
/*
void main(string sSpawnWP_Tag)
{
object 	oPC = GetPCSpeaker();
object oJournal;
int iDasariaSpawnK, iDasariaSpawnS, iDasaria_Spawn_Upperbound, iWPID;
string sWPID;


if(!GetIsPC(oPC))return;

oJournal = GetItemPossessedBy( oPC,"std_journal");
iDasariaSpawnK = GetLocalInt(oJournal, "iDasariaSpawnK");
iDasariaSpawnS = GetLocalInt(oJournal, "iDasariaSpawnS");
iDasaria_Spawn_Upperbound = (DASARIA_SPAWN_WP1_KNOW<<(DASARIA_SPAWN_MAX_TICKBOXES-1));
sWPID = GetStringRight(sSpawnWP_Tag,2);
iWPID = StringToInt(sWPID);
iWPID = (DASARIA_SPAWN_WP1_KNOW << (iWPID-1));
if(iWPID > iDasaria_Spawn_Upperbound)
	{
	SendMessageToPC(oPC,"The spawn point being passed : "+sSpawnWP_Tag+" is returning a value greater than iDasaria_Spawn_Upperbound. Please report his error on the Dasaria2 forums");
	return;
	}

iDasariaSpawnK |= iWPID;
SetLocalInt(oJournal,"iDasariaSpawnK",iDasariaSpawnK); 

SendMessageToPC(oPC,"A new spawn point location has become available to you : "+sGet_LocationsName(iWPID, 1));




}