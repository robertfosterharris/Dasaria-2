//siegeengine_fire
//fire on a random waypoint
void main()
{
    // randomly pick one of five waypoints	
	int nRand = Random(5);
	int nTarget = nRand+1;
	string sWaypoint = "WP_target_0" + IntToString(nTarget);
	object oWaypoint = GetNearestObjectByTag(sWaypoint);
	location lTargetLocation = GetLocation(oWaypoint);
	ActionCastSpellAtLocation(SPELL_FIREBALL, lTargetLocation, METAMAGIC_ANY, TRUE, PROJECTILE_PATH_TYPE_BALLISTIC_LAUNCHED, TRUE);
}