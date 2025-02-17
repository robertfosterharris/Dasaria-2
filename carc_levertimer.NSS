// Timed lever system thingschmabob
// frac, Aug 07

// -Timer should be a float variable on the lever/button named "Timer"
// -sID (i.e the door that should open: ****DOOR_keytag/(sID)DOOR_keytag)
// is a string variable named ID on the lever/button.
// -Feedback message played by a string variable named Message

void main()
{

string sID = GetLocalString(OBJECT_SELF,"ID");
float fDelay = GetLocalFloat(OBJECT_SELF,"Timer");
if (GetLocalString(OBJECT_SELF, "Message") != "")
{ AssignCommand(OBJECT_SELF,(ActionSpeakString(GetLocalString(OBJECT_SELF, "Message")))); }
object oObject = OBJECT_SELF;
object oDoor = GetObjectByTag(sID+"DOOR_"+GetLockKeyTag(oObject));

	if (GetLocalInt(oDoor,"IN_USE"))
    { SpeakString("It's stuck right now."); return; }

    SetLocalInt(oDoor,"IN_USE",1);
    // Play sound hint
       PlaySound("as_sw_metalop1");
		
	ActionPlayAnimation(ANIMATION_PLACEABLE_ACTIVATE);
    DelayCommand(2.0, ActionPlayAnimation(ANIMATION_PLACEABLE_DEACTIVATE));

    // Open door
    AssignCommand(oDoor,ActionOpenDoor(oDoor));
    AssignCommand(oDoor,SetLocked(oDoor,FALSE));

	// Close door
    DelayCommand(fDelay,AssignCommand(oDoor,ActionCloseDoor(oDoor)));
    DelayCommand(fDelay,AssignCommand(oDoor,SetLocked(oDoor,TRUE)));
    DelayCommand(fDelay+1.0,DeleteLocalInt(oDoor,"IN_USE"));
}