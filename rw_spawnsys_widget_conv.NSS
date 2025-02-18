#include "std_persist_i0"
#include "ginc_spawnsystem"

void main(int iSpawnWidgetAction=0, int iUpdatedValue=0, int iDMLock=4)
{
}
/* RW 20140202 disabled

object oDM      = GetPCSpeaker();
object oItem    = GetObjectByTag("rw_spawnsys_widget");
object oTarget  = GetLocalObject(oItem,"oTarget");
object oJournal;

int iDasariaSpawnK;
int iDasariaSpawnS;
int	iDasaria_Spawn_Upperbound = (DASARIA_SPAWN_WP1_KNOW<<(DASARIA_SPAWN_MAX_TICKBOXES-1));

string sSWA = IntToString(iSpawnWidgetAction);

oJournal = std_journal_get(oTarget);

iDasariaSpawnK = GetLocalInt(oJournal,"iDasariaSpawnK");
iDasariaSpawnS = GetLocalInt(oJournal,"iDasariaSpawnS");	

SetLocalObject(oItem, "oTarget", oTarget);
SetLocalInt(oItem,"iDasariaSpawnK",iDasariaSpawnK);
SetLocalInt(oItem,"iDasariaSpawnS",iDasariaSpawnS);

//remove?
SendMessageToPC(oDM,"target selected: "+GetName(oTarget));
//

switch(iSpawnWidgetAction)
{
case 1: //set up tokens
SetCustomToken(1830,GetName(oTarget));
Display_AllSpawnTargetNames_w(iDasariaSpawnK, 1830, oDM);
SetCustomToken(1860,"construct list");
Display_AllSelections_w(iDasariaSpawnK, iDasariaSpawnS, 1860, oDM);
break;

case 2://toggle GUI/Conv selection for player
Set_Method_w(oDM,oTarget,oJournal,iUpdatedValue,iDasariaSpawnS);
break;

case 3://change options
Set_Options_w(oDM, oTarget, oJournal, iUpdatedValue, iDMLock, iDasariaSpawnK, iDasariaSpawnS, iDasaria_Spawn_Upperbound);
break;

case 4: //add a spawnpoint
Set_WP_w (oJournal, iSpawnWidgetAction, iUpdatedValue, iDMLock, iDasariaSpawnK, iDasariaSpawnS, iDasaria_Spawn_Upperbound);
break;

case 5: //remove a spawnpoint
Set_WP_w (oJournal, iSpawnWidgetAction, iUpdatedValue, iDMLock, iDasariaSpawnK, iDasariaSpawnS, iDasaria_Spawn_Upperbound);
break; 

case 6://end convo and tidy up...
DeleteLocalObject(oItem, "oTarget");
DeleteLocalInt(oItem,"iDasariaSpawnK");
DeleteLocalInt(oItem,"iDasariaSpawnS");
break;

default:
break;

}
	

}