void main()
{
object oDoor1 = GetObjectByTag("carc_mrlch_archdoor01");
object oDoor2 = GetObjectByTag("carc_mrlch_archdoor02");
AssignCommand(oDoor1,ActionCloseDoor(oDoor1));
SetLocked(oDoor1,TRUE);


AssignCommand(oDoor2,ActionCloseDoor(oDoor2));
SetLocked(oDoor2,TRUE);


DelayCommand(60.0,SetLocked(oDoor1,FALSE));
DelayCommand(60.0,SetLocked(oDoor2,FALSE));

DelayCommand(60.0,AssignCommand(oDoor1,ActionOpenDoor(oDoor1)));
}