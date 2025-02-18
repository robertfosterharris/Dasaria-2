void spawn_rope(string resref, location loc);
void main() {
// get the variables we need
	string sWP_base = GetLocalString(OBJECT_SELF, "sWP_base");
	int iRespawnLocs = GetLocalInt(OBJECT_SELF, "iRespawnLocs");
	float fRespawn = GetLocalFloat(OBJECT_SELF, "fRespawn");
	DestroyObject(OBJECT_SELF);	
	
	// pick a waypoint at random.  These should exist as waypoints somewhere in the 
	// module, and there should be the same number as defined by num_respawn_locs,
	// and the tag should be WP_length_of_ropeX where X is a number between 1 and
	// num_respawn_locs.
	object oRespawnWP = GetObjectByTag("WP_length_of_rope" + IntToString(Random(iRespawnLocs) +1));
	location loc = GetLocation(oRespawnWP);
	
	AssignCommand(GetModule(), DelayCommand(fRespawn,
     			  spawn_rope("sturdy_length_of_rope", loc))); 
	
	
	
}

void spawn_rope(string resref, location loc) {
	object rope = CreateObject(OBJECT_TYPE_PLACEABLE, resref, loc, TRUE);
}