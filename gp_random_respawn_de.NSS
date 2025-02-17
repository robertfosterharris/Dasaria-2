//  GP_RANDOM_RESPAWN_DE
//  ON DEATH SCRIPT - RESPAWNS A PLACEABLE AT A WAYPOINT RANDOMLY SELECTED FROM A SET
//
//  VARIABLES
//  sWaypointTag  - TAG OF THE WAYPOINT SET
//  fRespawnRate  - SECONDS BEFORE RESPAWN
//
void respawnPlaceable(string sResRef, location locRespawnPoint);
void main()
{
    int nIndex;
    float fRespawnRate;
    object oRespawnPoint;
    string sResRef;
    string sWaypointTag;

    fRespawnRate = GetLocalFloat(OBJECT_SELF, "fRespawnRate");
    sWaypointTag = GetLocalString(OBJECT_SELF, "sWaypointTag");
    sResRef = GetResRef(OBJECT_SELF);
    
//  CYCLE THROUGH ALL WAYPOINTS TO FIND THE TOTAL NUMBER OF WAYPOINTS    
    oRespawnPoint = GetObjectByTag(sWaypointTag, nIndex);
    while (GetIsObjectValid(oRespawnPoint))
    {
        nIndex++;
        oRespawnPoint = GetObjectByTag(sWaypointTag, nIndex);
    }
    
//  FIND A RANDOM WAYPOINT    
    nIndex = Random(nIndex);
    oRespawnPoint = GetObjectByTag(sWaypointTag, nIndex);
    
//  RESPAWN THE PLACEABLE
    if (GetIsObjectValid(oRespawnPoint))
    {
        AssignCommand(GetModule(), DelayCommand(fRespawnRate, respawnPlaceable(sResRef, GetLocation(oRespawnPoint))));
    }        
}
//
//  RESPAWN THE PLACEABLE
//
void respawnPlaceable(string sResRef, location locRespawnPoint)
{
    CreateObject(OBJECT_TYPE_PLACEABLE, sResRef, locRespawnPoint);
}