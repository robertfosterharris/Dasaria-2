// wp_tag
/*
Basic Template for creating scripted waypoints
when naming the script, replace "tag" with the tag of the creature(s).

This script runs on the creature traversing the waypoints.
*/
// ChazM 1/3/06


#include "ginc_wp"
void main()
{
    int iCurrentWP = GetCurrentWaypoint();
    FaceAndPause(iCurrentWP, 5.0f);
}