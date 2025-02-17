void main() {
	
	string speech_str = "You feel a strange sensation, as if your body and spirit is momentarily torn from where it was, and melded back together somewhere else...";
	string sActiveAreaTag = "pandemonium";
	object oActivator = GetItemActivator();
	
	// if we aren't in Pande, then we just want to destroy the amulet and go nowhere.
	if (sActiveAreaTag != GetTag(GetArea(oActivator))) {
		FloatingTextStringOnCreature("You briefly feel a slight tugging sensation within the pit of your chest, before it dissipates.  The amulet around your neck crumbles into dust.", oActivator);
		DestroyObject(OBJECT_SELF);
		return;
	}
	
	object oWP = GetObjectByTag("WP_ammy_jump_to_ministry");
	effect eZapper = EffectVisualEffect(VFX_SPELL_HIT_CALL_LIGHTNING);
  	object oParty = GetFirstFactionMember(oActivator);
	
	// jump all party members in area to selected waypoint.

  	while (GetIsObjectValid(oParty) && GetIsPC(oParty)) {
    	if (GetArea(oParty) == GetArea(oActivator)) {
			AssignCommand(oParty, ClearAllActions());
        	DelayCommand(3.0, AssignCommand(oParty, JumpToObject(oWP, 0)));
			FloatingTextStringOnCreature(speech_str, oParty);
			location loc = GetLocation(oParty);
			ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eZapper, loc);
    	}
	
    	oParty = GetNextFactionMember(oActivator);
  	}
	AssignCommand(oActivator, ClearAllActions());
  	DelayCommand(3.0, AssignCommand(oActivator, JumpToObject(oWP, 0)));	
	FloatingTextStringOnCreature(speech_str, oActivator);
	location loc = GetLocation(oParty);
	ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eZapper, loc);
	DestroyObject(OBJECT_SELF);
}