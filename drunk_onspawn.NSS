// This script is for the drunk's OnSpawn event.
void main()
{   SetLocalString( OBJECT_SELF, "Activity", "Idle");

    string sTag = GetTag( OBJECT_SELF);
    if( sTag == "") return;

    object oPost = GetWaypointByTag( sTag +"_Post");
    if( GetIsObjectValid( oPost)) ActionJumpToObject( oPost);
}
