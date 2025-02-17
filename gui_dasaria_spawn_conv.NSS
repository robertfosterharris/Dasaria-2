#include "ginc_spawnsystem"

int StartingConditional(int iLocationToCheck)
{
	object oPC = GetPCSpeaker();
	object oJournal = std_journal_get(oPC);
	
	string sWP_Known = sConstruct_WP_TAG_String(iLocationToCheck);

	string sIs_WP_Known;
	int iWP_Known = FALSE;
		
	if(!GetIsPC(oPC))return FALSE;

	sIs_WP_Known = GetLocalString(oJournal, sWP_Known);
			
	if(sIs_WP_Known == sWP_Known)
	{
		iWP_Known = TRUE;
	}

	return iWP_Known;
}	

/*
#include "ginc_spawnsystem"

int StartingConditional(int iLocationToCheck)
{
	object oPC = GetPCSpeaker();
	object oJournal;
	
	int iDasariaSpawnK;
	
	if(!GetIsPC(oPC))return FALSE;

	oJournal = GetItemPossessedBy( oPC,"std_journal");	
	iDasariaSpawnK = GetLocalInt(oJournal, "iDasariaSpawnK");
	
	iLocationToCheck = ( DASARIA_SPAWN_WP1_KNOW << (iLocationToCheck-1));
	
	if(iDasariaSpawnK & iLocationToCheck )
	{
		return TRUE;	
	}
	else{
		return FALSE;
	}
}			