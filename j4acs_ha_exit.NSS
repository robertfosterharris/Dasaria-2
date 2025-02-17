/*
    04/29/07    RFH     ONLY SWEEP IF THE AREA IS EMPTY
	02/14/09	Wired	Moved RW's spawnsystem code here
	06/14/10	Wired	Move lDefaultAreaRespawn (failsafe) to LastExited
	07/08/10	Wired	Exclude Exiting PC from area empty check
	08/22/10	Wired	Move lDefaultAreaRespawn back to OCE, player location not valid on exit
*/

#include "j4acs_uglyhack"
#include "ginc_spawnsystem"
#include "std_inc_mounts"


void main()
{
    int bAreaEmpty;
    object oArea;
	object oPC;
	object oCharacter;

    oArea = OBJECT_SELF;
	oPC = GetExitingObject();
    
	if (GetIsPC(oPC))
    {
	
		//	set failsafe respawn location 
		//	to spot from which player exited
		//  make sure its a safe location	
		//SetLocalLocation(oPC,"lDefaultAreaRespawn",GetLocation(oPC));
		
		if (GetLocalInt(oPC,"EOS_ENTERED") != 1) ManageDasariaSpawnExit(oPC);
		
		SendMountToLimbo(oPC,oArea);
	
        bAreaEmpty = TRUE;

        oCharacter = GetFirstPC();
        while (GetIsObjectValid(oCharacter) && bAreaEmpty)
        {
			if (oCharacter != oPC) 
			{
           		if (GetArea(oCharacter) == oArea) bAreaEmpty = FALSE;
			}
            oCharacter = GetNextPC();
        }

        if (bAreaEmpty && !GetLocalInt(OBJECT_SELF, "bNoSweep"))
        {
            SetLocalInt(oArea, "bAreaEmpty", bAreaEmpty);
            DelayCommand(90.0, DoSweep(oArea));
        }
//
//	TRANSITION TESTING CODE
//		
		if (!GetIsDM(oPC))
		{
			SetLocalString(oPC, "LastExit", GetName(OBJECT_SELF));
			SetLocalString(oPC, "LastExitTag", GetTag(OBJECT_SELF));
			SetLocalString(oPC, "LastEntry", "CRASHED BEFORE ON ENTER");
			SetLocalInt(oPC, "TransitionState", 1);	
		}			
    }
}

	
/*
*/