#include "std_persist_i0"
#include "ginc_spawnsystem"

int StartingConditional(string sDasariaSpawnVal, int iValueToCheck)
{
return TRUE;
}
/* RW 20140202 Disabled
	object oDM = GetPCSpeaker();
	object oWidget = GetItemPossessedBy(oDM,"rw_spawnsys_widget");
	
	int iDasariaSpawnVal;
	
	if(sDasariaSpawnVal == "iDasariaSpawnK")
	{
	iDasariaSpawnVal = GetLocalInt(oWidget,"iDasariaSpawnK");

	iValueToCheck = ( DASARIA_SPAWN_WP1_KNOW << (iValueToCheck-1)); 

	
	}
	else
	{
	iDasariaSpawnVal = GetLocalInt(oWidget,"iDasariaSpawnS");	
	}
	
	
	if(iDasariaSpawnVal & iValueToCheck )
	{
		return TRUE;	
	}
	else{
		return FALSE;
	}
}	