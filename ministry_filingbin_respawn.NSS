void spawn_bin(string resref, location loc);
void main() {
// get the variables we need
	string sWP = GetLocalString(OBJECT_SELF, "sWP_base");
	float fRespawn = GetLocalFloat(OBJECT_SELF, "fRespawn");
	DestroyObject(OBJECT_SELF);	
	
	object oRespawnWP = GetObjectByTag(sWP);
	location loc = GetLocation(oRespawnWP);
	
	AssignCommand(GetModule(), DelayCommand(fRespawn,
     			  spawn_bin("ministry_filing_bin", loc))); 	
}

void spawn_bin(string resref, location loc) {
	object bin = CreateObject(OBJECT_TYPE_PLACEABLE, resref, loc, TRUE);
}