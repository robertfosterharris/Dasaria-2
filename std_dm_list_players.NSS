void main() 
{
	object oMrDM = GetPCSpeaker();
	object oPC = GetFirstPC();

	string player_or_dm = "Player ";

	while (OBJECT_INVALID != oPC) {
		if (TRUE == GetIsDM(oPC)) {
			player_or_dm = "DM ";
		} else {
			player_or_dm = "Player ";	
		}
		SendMessageToPC(oMrDM, player_or_dm + GetFirstName(oPC) + " " + GetLastName(oPC) + "("+IntToString(GetHitDice(oPC))+") is in " + GetName(GetArea(oPC)));
		oPC = GetNextPC();
	}
}