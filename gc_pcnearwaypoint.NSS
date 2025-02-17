// gc_pcnearwaypoint
// is anyone standing within x meters of this waypoint?

int StartingConditional(string sWPTag, float fSearchRadius)
{   
	object oPCSpeaker = GetPCSpeaker();
	object oWayPoint = GetWaypointByTag(sWPTag);
	object oPC = GetNearestCreature(CREATURE_TYPE_PLAYER_CHAR, PLAYER_CHAR_IS_PC, oWayPoint, 1);
	// exclude PCSpeaker from this check
	if (oPC != OBJECT_INVALID)
	{	
		// what is the distance of the PC to the waypoint?
        float fDist = GetDistanceBetween(oWayPoint,oPC);
        if (fDist <= fSearchRadius)
        {
			return TRUE;
		}
		return FALSE;	
	}
	else
	{
		return FALSE;
	}
}