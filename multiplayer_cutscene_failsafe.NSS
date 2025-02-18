// wired 09/30/08
// because players mysteriously went invulnerable and i
// have no way to explain it other than a glitch in cutscene mode
void main()
{
	object oPlayer = GetPCSpeaker();
	SetCutsceneMode(oPlayer,FALSE);
	SetPlotFlag(oPlayer,FALSE);
	object oMember = GetFirstFactionMember(oPlayer,TRUE);
	
	while (GetIsObjectValid(oMember))
	{
		SetCutsceneMode(oMember,FALSE);
		SetPlotFlag(oMember,FALSE);
		oMember = GetNextFactionMember(oMember,TRUE);
	}
}