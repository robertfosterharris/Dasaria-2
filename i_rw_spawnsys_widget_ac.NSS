#include "std_persist_i0"
#include "ginc_spawnsystem"

void main()
{
object oDM      = GetItemActivator();
object oItem    = GetItemActivated();
object oTarget  = GetItemActivatedTarget();
object oJournal;

//Your code goes here

int iDasariaSpawnK;
int iDasariaSpawnS;
int iJumpToLocationDisabled;
int iJumper;

oJournal = std_journal_get(oTarget);

iDasariaSpawnK = GetLocalInt(oJournal,"iDasariaSpawnK");
iDasariaSpawnS = GetLocalInt(oJournal,"iDasariaSpawnS");	

SetLocalObject(oItem, "oTarget", oTarget);
SetLocalInt(oItem,"iDasariaSpawnK",iDasariaSpawnK);
SetLocalInt(oItem,"iDasariaSpawnS",iDasariaSpawnS);

AssignCommand(oDM,ActionStartConversation(oDM,"rw_spawnsys_widget",TRUE,FALSE));

}