// turn the tyrak faction hostile to this party

void main()
{
	object oPC = GetLastHostileActor();
	AdjustAlignment(oPC,ALIGNMENT_EVIL,5);
	object oMember = GetFirstFactionMember(oPC);
	
	while (GetIsObjectValid(oMember))
	{
		AdjustReputation(oMember,GetObjectByTag("d2_faction_tyrak"),-100);
		oMember = GetFirstFactionMember(oPC);
	}
}