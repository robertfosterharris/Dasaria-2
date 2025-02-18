//	RFH		03/03/2007	MOVED ExportSingleCharacter FROM REST_START TO MAIN FUNCTION
//	WIRED 	10/02/2008 	Delete Spells String on Rest
//	RFH		06/12/2009	CLEANED UP CODE
//						MOVED SAVE TO REST FINISH TO ENSURE NOBODY IS SHAPECHANGED WHEN ATTEMPTING A SAVE
//	WIRED	10/03/2009	WIRED REMOVED SPELL CODE
// Wired 11/21/2009 Restore Spell Code

#include "std_i0_misc"
#include "std_i0_time"

string	kRest = "std_request_rest";

void rest_start(object oPC);

void main()	
{
	float fFacing;
	object oPC;
	
	oPC = GetLastPCRested();
		
	switch (GetLastRestEventType()) 
	{
		case REST_EVENTTYPE_REST_STARTED:

			if(GetLocalInt(oPC, kRest ) == 0)
       		{
				fFacing = GetFacing(oPC);
          		AssignCommand(oPC, ClearAllActions(TRUE));
				AssignCommand(oPC, ActionStartConversation(oPC, "mod_rest", TRUE, FALSE, TRUE, TRUE));	
				AssignCommand(oPC,	SetFacing(fFacing, TRUE));
			}
			else		
			{
				DeleteLocalInt(oPC, kRest);
				rest_start(oPC);
			}
			break;
		
		case REST_EVENTTYPE_REST_CANCELLED:
		    // Careful, because ANY menu option causes a cancel
			break;
				
		case REST_EVENTTYPE_REST_FINISHED:
			SaveSingleCharacter(oPC);
			break;		
	}
}
void rest_start(object oPC)
{	
	float fTimer;
	float fRemaining;
	int nElapsed;
	
	// Time since last rest
	nElapsed = time_stamp_seconds_elapsed(oPC, "LastRest");
	
	// Rest fTimer in RL seconds
	fTimer = 4.0 + IntToFloat(GetHitDice(oPC)) / 1.5;
	fTimer *= 60.0;

	// Check time fRemaining
	fRemaining = fTimer - nElapsed;
	if (fRemaining > 0.0)
	{
		SendMessageToPC(oPC, "You can not rest for " + FloatToString( fRemaining, 0, 0 ) + " more seconds.");
		AssignCommand(oPC, ClearAllActions(TRUE));
	}
	else
	{
		time_stamp_seconds_set( oPC, "LastRest" );
		DeleteLocalString(oPC,"Spells");
	}
}