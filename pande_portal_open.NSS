void spawn_obelisk(string resref, location loc, effect ePortal);
void main() {
	// first, see if we have 5 shards inserted
	// into the obelisk
	object oShard = GetFirstItemInInventory(OBJECT_SELF);
	int iShardCount = 0;
		float fRespawn = GetLocalFloat(OBJECT_SELF, "fRespawn");
	while (GetIsObjectValid(oShard)) {
		string sShardTag = GetTag(oShard);
		if (sShardTag == "crystalline_fragment") {
			iShardCount = iShardCount + GetNumStackedItems(oShard);
		}
		oShard = GetNextItemInInventory(OBJECT_SELF);
	}
	// we need 5 shards
	if (iShardCount > 4) {
		location portal_loc = GetLocation(GetNearestObjectByTag("WP_pande_portal"));
		effect ePortal = EffectVisualEffect(VFX_SPELL_HIT_CALL_LIGHTNING);
		ApplyEffectAtLocation(DURATION_TYPE_INSTANT, ePortal, portal_loc);
		PlaySound("magicportalevil");
		CreateObject(OBJECT_TYPE_PLACEABLE, "open_portal",  portal_loc);
		
		// make sure we destroy the shards that will
		// drop when the obelisk is destroyed.
		oShard = GetFirstItemInInventory(OBJECT_SELF);
		while (GetIsObjectValid(oShard)) {
			DestroyObject(oShard);
			oShard = GetNextItemInInventory(OBJECT_SELF);
		}
		// now destroy the obelisk and set it to reset
		// in 60 seconds.
		DestroyObject(OBJECT_SELF);
		AssignCommand(GetModule(), DelayCommand(fRespawn,
     			  		spawn_obelisk("dormant_tele_stone", portal_loc, ePortal))); 
		
	}
	
}

void spawn_obelisk(string resref, location loc, effect ePortal) {
	ApplyEffectAtLocation(DURATION_TYPE_INSTANT, ePortal, loc);
	object obelisk = CreateObject(OBJECT_TYPE_PLACEABLE, resref, loc, TRUE);
	object oPortal = GetNearestObjectByTag("open_portal", obelisk);
	DestroyObject(oPortal);
}