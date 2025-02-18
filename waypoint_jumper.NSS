void main() {
	
	string wp_tag = GetLocalString(OBJECT_SELF, "wp_tag");
	int wp_count = GetLocalInt(OBJECT_SELF, "wp_count");
	string speech_str = "You feel a strange sensation, as if your body and spirit is momentarily torn from where it was, and melded back together somewhere else...";
	int wp_to_use = Random(wp_count-1) + 1;
	
	// jump all party members in area to randomly
	// selected waypoint.
	wp_tag = wp_tag + IntToString(wp_to_use);
	object oWP = GetObjectByTag(wp_tag);
	effect eZapper = EffectVisualEffect(VFX_SPELL_HIT_CALL_LIGHTNING);
  	object oParty = GetFirstFactionMember(GetEnteringObject(), FALSE);

  	while (GetIsObjectValid(oParty) && GetIsPC(oParty)) {
    	if (GetArea(oParty) == GetArea(GetEnteringObject())) {
			AssignCommand(oParty, ClearAllActions());
        	AssignCommand(oParty, JumpToObject(oWP, 0));
			SendMessageToPC(oParty, speech_str);
			location loc = GetLocation(oWP);
			ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eZapper, loc);
    	}
	
    	oParty = GetNextFactionMember(GetEnteringObject(), FALSE);
  	}
	AssignCommand(GetEnteringObject(), ClearAllActions());
  	AssignCommand(GetEnteringObject(), JumpToObject(oWP, 0));	
	SendMessageToPC(oParty, speech_str);
	location loc = GetLocation(oWP);
	ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eZapper, loc);
}