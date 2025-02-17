// assassin_remember
// turn local strings on the PC into a conversation token
void main()
{
	object oPC = GetPCSpeaker();
	string sAreaName = GetLocalString(oPC,"sTargetArea");
	string sVictimName = GetLocalString(oPC,"sTargetName");
	SetCustomToken(6663, sAreaName);
	SetCustomToken(6664, sVictimName);
}
	