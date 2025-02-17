//Automatically shuts oDoor1 after a set amount of time. If oDoor1 is
//connected to oDoor2 via a transition, it will close oDoor2 at the same time.

//default timer is at 10 seconds
//to change default timer, add float variable called DELAY
//if DELAY is -1.0, the door will never auto close.

// edit@Feb 2008:
// You may now set this on a trigger. To specify your desired door, simply
// add a string variable labeled "TargetDoor" with the proper door tag.

// If you don't want the door to lock, add an int variable named NOLOCK
// -frac */
void main()
{
	object 	oDoor1 			= OBJECT_SELF;
	//new trigger hook:
	if (GetObjectType(OBJECT_SELF) == OBJECT_TYPE_TRIGGER)
	{ oDoor1 = GetObjectByTag(GetLocalString(OBJECT_SELF, "TargetDoor"));
	if (!GetIsOpen(oDoor1)) return; }
	//end trigger hook
	object 	oDoor2 			= GetTransitionTarget(oDoor1);
	float	fShutDefault	= 10.0;
	float  	fShutDelay 		= GetLocalFloat(oDoor1, "DELAY");
	
	if(fShutDelay == -1.0)
		return;
	else if(fShutDelay == 0.0)
		fShutDelay = fShutDefault;
SetLocked(oDoor1, FALSE);		
	AssignCommand(oDoor1, DelayCommand(fShutDelay, ActionCloseDoor(oDoor1)));
	AssignCommand(oDoor2, DelayCommand(fShutDelay, ActionCloseDoor(oDoor2)));

	//lock the door
	if (!GetLocalInt(oDoor1,"NOLOCK"))
	{ DelayCommand(fShutDelay, SetLocked(oDoor1, TRUE)); }
}