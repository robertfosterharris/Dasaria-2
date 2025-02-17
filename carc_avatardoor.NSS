void main()
{
ActionPlayAnimation( ANIMATION_PLACEABLE_ACTIVATE );
DelayCommand(5.0, ActionPlayAnimation( ANIMATION_PLACEABLE_DEACTIVATE ));
	
object oMaster = GetObjectByTag("carc_coliel_avatardoor");
if (GetLocalInt(oMaster,"Combo") == 4)
{
AssignCommand(OBJECT_SELF,ActionSpeakString("<i>The heavy door slides open."));
SetLocked(oMaster,FALSE);
DelayCommand(1.0,AssignCommand(oMaster,ActionOpenDoor(oMaster)));
}
else
{
AssignCommand(OBJECT_SELF,ActionSpeakString("<i>Nothing happens."));
}}