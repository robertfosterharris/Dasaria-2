//	ON ENTER - TRIGGER CONVERSATION WITH JYLEA THE AMBASSADOR FOR PCS WITH ZERO XP
//
//	ROBERT HARRIS	05/20/2008		ROBERTHARRIS@ROBERTHARRIS.COM
//
void main()
{
	int nJournalState;
	object oNPC;
	object oPC;
	

	oPC = GetEnteringObject();
	if (!GetIsPC(oPC)) return;
	
	if ((GetXP(oPC) <= 150) && (!GetLocalInt(oPC, "bAmbassadorSpeech")))
	{
		oNPC = GetNearestObjectByTag("nc_greeternpc", oPC);
		if (GetObjectSeen(oPC, oNPC))
		{
			SetLocalInt(oPC, "bAmbassadorSpeech", TRUE);
			AssignCommand(oNPC, ClearAllActions(TRUE));
			AssignCommand(oNPC, ActionStartConversation(oPC));
		}
	}
}