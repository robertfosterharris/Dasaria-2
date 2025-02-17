

void main()
{
    //Get PC who used Door
    object oPC = GetLastUsedBy();
    //Get the door to open
    object oDoor = GetObjectByTag("thayad_gate_2a");
	
    //Get stored Door state (activated 0, deactivated 1) first use yields 0
    int nDoorState = GetLocalInt (OBJECT_SELF,"sDoorStateStored");

    //roll the Door state from activated 0 to deactivated 1
    nDoorState = nDoorState + 1;


    //if the roll changes value to 2 then set it to activated 0
    if (nDoorState == 2)(nDoorState = 0);

    //store the Door state for next time it's used
    SetLocalInt(OBJECT_SELF,"sDoorStateStored",nDoorState);

    //if Door deactivated
    if (nDoorState == 0)
        {
         //deactivated commands
         PlaySound("as_sw_Door1");
         AssignCommand (oPC,SpeakString("Sound Played"));
         //lock and close the door
         AssignCommand (oDoor, ActionCloseDoor (oDoor));
//         AssignCommand (oDoor, ActionLockObject (oDoor)); 
         SetLocked(oDoor, TRUE);
         //swing the Door to deactivated
         PlayAnimation (ANIMATION_PLACEABLE_DEACTIVATE);
         //have the using PC call the state
         AssignCommand (oPC,SpeakString("Door seems to have locked."));
        } //end if

    //if Door activated
     if (nDoorState == 1)
        {
         //activated commands
         PlaySound("as_sw_Door1");
         // unlock and open the door
         SetLocked(oDoor, FALSE);
//         AssignCommand (oDoor, ActionUnlockObject (oDoor));  
         AssignCommand (oDoor, ActionOpenDoor (oDoor));
         //swing the Door to activated
         PlayAnimation (ANIMATION_PLACEABLE_ACTIVATE);
         
  
		
	
    //Get the door to open
    object oDoor2b= GetObjectByTag("thayad_gate_2b");
	
    //Get stored Doorbstate (activated 0, deactivated 1) first use yields 0
    int nDoor2bState = GetLocalInt (OBJECT_SELF,"sDoor2bStateStored");

    //roll the Door state from activated 0 to deactivated 1
    nDoor2bState = nDoor2bState + 1;


    //if the roll changes value to 2 then set it to activated 0
    if (nDoor2bState == 2)(nDoor2bState = 0);

    //store the Door state for next time it's used
    SetLocalInt(OBJECT_SELF,"sDoor2bStateStored",nDoor2bState);

    //if Door deactivated
    if (nDoor2bState == 0)
        {
         //deactivated commands
         PlaySound("as_sw_Door1");
         AssignCommand (oPC,SpeakString("Sound Played"));
         //lock and close the door
         AssignCommand (oDoor2b, ActionCloseDoor (oDoor2b));
//         AssignCommand (oDoor, ActionLockObject (oDoor)); 
         SetLocked(oDoor2b, TRUE);
         //swing the Door to deactivated
         PlayAnimation (ANIMATION_PLACEABLE_DEACTIVATE);
                  
        } //end if

    //if Door activated
    if (nDoor2bState == 1)
        {
         //activated commands
         PlaySound("as_sw_Door1");
         // unlock and open the door
         SetLocked(oDoor2b, FALSE);
//         AssignCommand (oDoor, ActionUnlockObject (oDoor)); 
         AssignCommand (oDoor2b, ActionOpenDoor (oDoor2b));
         //swing the Door to activated
         PlayAnimation (ANIMATION_PLACEABLE_ACTIVATE);
		 } //end if
	}		
}				