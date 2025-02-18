// rnvw_enc_enable
// two inactive encounters inside this trigger
// enable one of them, depending on journal state
void main()
{
	object oPC = GetEnteringObject();
	object oMember;
	
	if ( !GetIsPC(oPC) )
		return;
	
	object oDefender 	= GetObjectByTag("d2_faction_rvnwd_defender");
	object oAttacker 	= GetObjectByTag("d2_faction_rvnwd_attacker");
	object oDefenderEnc	= GetNearestObjectByTag("rvnwd_enc_defenders");	// belongs to defender PC Party (e.g., filled with attackers)
	object oAttackerEnc	= GetNearestObjectByTag("rvnwd_enc_attackers"); // belongs to attacker PC Party (e.g., filled with defenders)
	
	// i am an attacker
	if (GetReputation(oPC,oDefender)<50)
	{
		MusicBattlePlay(GetArea(OBJECT_SELF));
		
		SetEncounterActive(TRUE, oAttackerEnc);
		SetEncounterActive(FALSE, oDefenderEnc);
	}
//	return;
	
	// i am a defender
	if (GetReputation(oPC,oDefender)>50)
	{
		MusicBattlePlay(GetArea(OBJECT_SELF));
		
		SetEncounterActive(TRUE, oDefenderEnc);
		SetEncounterActive(FALSE, oAttackerEnc);
	}
	return;
	
	SendMessageToPC(oPC,"There was an error determining your faction, defaulting to 'defender.'");
	
	oMember = GetFirstFactionMember(oPC,TRUE);
	while (GetIsObjectValid(oMember))
	{
		AdjustReputation(oMember, oDefender, 100);
		AdjustReputation(oMember, oAttacker, -100);
		
		oMember = GetNextFactionMember(oPC,TRUE);
	}
	
	MusicBattlePlay(GetArea(OBJECT_SELF));
		
	SetEncounterActive(TRUE, oDefenderEnc);
	SetEncounterActive(FALSE, oAttackerEnc);

}