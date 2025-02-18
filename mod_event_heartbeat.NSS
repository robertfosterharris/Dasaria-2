//	RFH		10/31/2008	PING MYSQL TO KEEP CONNECTION ALIVE
//	RFH		06/12/2009	CHANGED THE WAY CHARACTERS ARE SAVED
//						*	SAVING A SHAPECHANGED CHARACTER CAUSES THE SHAPECHANGE DURATION TO BE RESET
//						*	SAVING A SHAPECHANGED CHARACTER WHO IS TRANSITIONING CAUSES THE SERVER TO CRASH
//						*	EXPORTSINGLECHARACTER ONLY WORKS IN THE REST EVENT SO EXPORTALLCHARACTERS IS OUR ONLY OPTION ON HEARTBEAT
//						*	THEREFORE, EXPORTALLCHARACTERS EVERY 180 SECONDS IF NOBODY IS SHAPECHANGED
//
#include "death_i0_bleed"
#include "nwnx_include"
#include "nwnx_sql"
#include "std_i0_misc"
#include "std_persist_i0"

void main()
{
	int bCanSave;
	int bShouldSave;	
	int nTick;
	object oPC;

	nTick = GetLocalInt(GetModule(), "tick");
	SetLocalInt(GetModule(), "tick", nTick + 1);
	
	if (nTick % 30 == 0)				//	EVERY 180 SECONDS
	{
		bShouldSave = TRUE;				//	WE SHOULD SAVE CHARACTERS
		SQLExecDirect("SELECT 1");		//	KEEP DATABASE CONNECTION ALIVE
	}
	else
	{
		bShouldSave = FALSE;
	}

	bCanSave = TRUE;									//	CAN WE SAVE CHARACTERS?
	oPC = GetFirstPC();
	while (GetIsObjectValid(oPC))
	{
		death_event_OnHeartbeat(oPC);					//	APPLY DEATH EFFECT TO DEAD CHARACTERS
		if (GetIsShapechanged(oPC)) bCanSave = FALSE;	// CAN'T SAVE SHAPECHANGED CHARACTERS
		oPC = GetNextPC();
	}
	
	if (bShouldSave && bCanSave) ExportAllCharacters();
	std_persist_time_save();
}