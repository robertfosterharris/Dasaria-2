// This script is for the drunk's OnCombatRoundEnd event.
void main()
{
    ExecuteScript("nw_c2_default3", OBJECT_SELF);
    ClearPersonalReputation( GetLastHostileActor());
    ClearPersonalReputation( GetLastDamager());
    ClearPersonalReputation( GetLastAttacker());
    ForceRest( OBJECT_SELF);
    SetLocalString( OBJECT_SELF, "Activity", "Idle");
}
