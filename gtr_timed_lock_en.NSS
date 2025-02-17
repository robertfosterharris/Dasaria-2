//  TRIGGER ON ENTER SCRIPT
//
//  LOCKS AND UNLOCKS OBJECTS WITH THE TRIGGER 
//  BASED ON THE CURRENT HOUR AND A COMMA DELIMITED LIST OF HOURS
//
//  TRIGGER VARIABLE
//  sHoursLocked    - A COMMA DELIMITED LIST OF HOURS THE OBJECT SHOULD BE LOCKED
//  sObjectTag      - TAG OF THE OBJECT TO BE LOCKED
//
//  ROBERT HARRIS   ROBERTHARRIS@ROBERTHARRIS.COM   05/02/2007
//
void main()
{
    int bLockFlag;
    int bOpenFlag;
    object oObject;
    string sHour;
    string sHoursLocked;
    string sObjectTag;
    
//  INITIALIZE VARIABLES AND CREATE THE SEARCH STRING    
    sHour = "," + IntToString(GetTimeHour()) + ",";
    sHoursLocked = "," + GetLocalString(OBJECT_SELF, "sHoursLocked") + ",";
    sObjectTag = GetLocalString(OBJECT_SELF, "sObjectTag");
    
//  DETERMINE IF OBJECT SHOULD BE LOCKED OR UNLOCKED    
    if (FindSubString(sHoursLocked, sHour) == -1)
    {
        bLockFlag = FALSE;
    }
    else
    {
        bLockFlag = TRUE;
    }
    
//  LOCK OR UNLOCK OBJECT BASED ON OBJECT TYPE  
    oObject = GetObjectByTag(sObjectTag);
    if (GetIsObjectValid(oObject))
    {
        switch (GetObjectType(oObject))
        {
            case OBJECT_TYPE_DOOR:
                bOpenFlag = GetIsOpen(oObject);
                if (bOpenFlag && bLockFlag) AssignCommand(oObject, ActionCloseDoor(oObject));
                AssignCommand(oObject, SetLocked(oObject, bLockFlag));
            break;
            case OBJECT_TYPE_PLACEABLE:
                bOpenFlag = GetIsOpen(oObject);
                if (bOpenFlag && bLockFlag) AssignCommand(oObject, ActionPlayAnimation(ANIMATION_PLACEABLE_CLOSE));
                AssignCommand(oObject, SetLocked(oObject, bLockFlag));
            break;
        }
    }        
}