//event_nelina_exit
void main()
{
    object oNelina = GetNearestObjectByTag("nelina");
    object oExit = GetNearestObjectByTag("WP_Trades_to_Docks");
    AssignCommand(oNelina,ActionMoveToObject(oExit));
}