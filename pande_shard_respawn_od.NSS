void spawn_placeable(string sResRef, location loc);

void main() {
	float fRespawn = GetLocalFloat(OBJECT_SELF, "fRespawn");
	string sResRef = GetResRef(OBJECT_SELF);
	location loc = GetLocation(OBJECT_SELF);
	

	AssignCommand(GetModule(), DelayCommand(fRespawn,
     			  spawn_placeable(sResRef, loc))); 
	
	DestroyObject(OBJECT_SELF);
	CreateObject(OBJECT_TYPE_ITEM, "crystalline_fragment", loc);
}

void spawn_placeable(string sResRef, location loc) {
	object oPlaceable = CreateObject(OBJECT_TYPE_PLACEABLE, sResRef, loc, TRUE);
}