//Failsafe for gate so that people don't close it manually
//Will reopen the gate if it was closed by a person

void main()
{
object oDoor = OBJECT_SELF;
object oPC = GetLastClosedBy();
if (GetIsPC(oPC))
{
SetLocked(oDoor,FALSE);
AssignCommand(oDoor,ActionOpenDoor(oDoor));
DelayCommand(0.1,SetLocked(oDoor,TRUE));
}

}