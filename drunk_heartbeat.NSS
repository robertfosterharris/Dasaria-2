// This script is for the drunk's OnHeartbeat event.
void main()
{   string sActivity = GetLocalString( OBJECT_SELF, "Activity");
    if( sActivity == "Idle") SignalEvent( OBJECT_SELF, EventUserDefined( 1));
}