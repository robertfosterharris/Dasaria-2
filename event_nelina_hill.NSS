//event_nelina_hill
void main()
{
    object oNelina = GetNearestObjectByTag("nelina");
    object oExit = GetNearestObjectByTag("door_governors_residence");
    AssignCommand(oNelina,ActionMoveToObject(oExit));
}