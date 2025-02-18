void main()
{
object oPC = GetLastUsedBy();
object oDoor = GetObjectByTag(GetTag(OBJECT_SELF)+"_door");


SetLocked(oDoor,FALSE);
if (!GetIsOpen(oDoor))
{  AssignCommand(OBJECT_SELF,ActionPlayAnimation(ANIMATION_PLACEABLE_ACTIVATE)); 
AssignCommand(oDoor,ActionOpenDoor(oDoor));
}

else
{ AssignCommand(OBJECT_SELF,ActionPlayAnimation(ANIMATION_PLACEABLE_DEACTIVATE));
AssignCommand(oDoor,ActionCloseDoor(oDoor)); }
DelayCommand(0.1,SetLocked(oDoor,TRUE));
}