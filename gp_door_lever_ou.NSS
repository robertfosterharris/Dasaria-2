

void main()
{
    //Get PC who used lever
    object oPC = GetLastUsedBy();
    //Get the door to open
    object oDoor = GetObjectByTag("id_Door2");

    //Get stored lever state (activated 0, deactivated 1) first use yields 0
    int nLeverState = GetLocalInt (OBJECT_SELF,"sLeverStateStored");

    //roll the lever state from activated 0 to deactivated 1
    nLeverState = nLeverState + 1;


    //if the roll changes value to 2 then set it to activated 0
    if (nLeverState == 2)(nLeverState = 0);

    //store the lever state for next time it's used
    SetLocalInt(OBJECT_SELF,"sLeverStateStored",nLeverState);

    //if lever deactivated
    if (nLeverState == 0)
        {
         //deactivated commands
         PlaySound("as_sw_lever1");
         AssignCommand (oPC,SpeakString("Sound Played"));
         //lock and close the door
         AssignCommand (oDoor, ActionCloseDoor (oDoor));
//         AssignCommand (oDoor, ActionLockObject (oDoor));  // I had origiannly included this... worked for open
         SetLocked(oDoor, TRUE);
         //swing the lever to deactivated
         PlayAnimation (ANIMATION_PLACEABLE_DEACTIVATE);
         //have the using PC call the state
         AssignCommand (oPC,SpeakString("Door seems to have locked."));
        } //end if

    //if lever activated
    else if (nLeverState == 1)
        {
         //activated commands
         PlaySound("as_sw_lever1");
         // unlock and open the door
         SetLocked(oDoor, FALSE);
//         AssignCommand (oDoor, ActionUnlockObject (oDoor));  // I had origiannly included this... this line was crashing the app
         AssignCommand (oDoor, ActionOpenDoor (oDoor));
         //swing the lever to activated
         PlayAnimation (ANIMATION_PLACEABLE_ACTIVATE);
         //have the using PC call the state
         AssignCommand (oPC,SpeakString("Door seems to have unlocked."));
        }; //end if
}