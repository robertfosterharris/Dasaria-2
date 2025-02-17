#include "std_persist_i0"
#include "ginc_spawnsystem"

int StartingConditional(int iWPID)//iWPID is the WP number from the WP name
{



	object oPC;
	object oJournal;

	string sWP_Known = sConstruct_WP_TAG_String(iWPID);

	string sIs_WP_Known;
	int iWP_Known = TRUE;
		
	oPC = GetPCSpeaker();
	oJournal = std_journal_get(oPC);

	sIs_WP_Known = GetLocalString(oJournal, sWP_Known);

	if(sIs_WP_Known == sWP_Known)
	{
		iWP_Known = FALSE;
	}

	return iWP_Known;
	
}

/* 
#include "std_persist_i0"
#include "ginc_spawnsystem"

int StartingConditional(int iWPID)//iWPID is the WP number 1 - x (currently 15)
{
	object oPC;
	object oJournal;
	int iDasariaSpawnK;
	
	oPC = GetPCSpeaker();
	oJournal = std_journal_get(oPC);
	iDasariaSpawnK = GetLocalInt(oJournal, "iDasariaSpawnK");

	iWPID = (DASARIA_SPAWN_WP1_KNOW << (iWPID-1));
		
	if( iWPID & iDasariaSpawnK )
	{
	return FALSE;
	}
	return TRUE;
	
	
}