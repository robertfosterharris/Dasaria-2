//	ON ENTER - TRIGGER CONVERSATION WITH GUARD IF PC USED INTIMIDATION TO GET BOOKS
//
//	ROBERT HARRIS	11/30/2007		ROBERTHARRIS@ROBERTHARRIS.COM
//
const int INTIMIDATION_SUCCESS = 30;
const int INTIMIDATION_FAILURE = 40;

void main()
{
	int nJournalState;
	object oGuard;
	object oPC;
	

	oPC = GetEnteringObject();
	nJournalState = GetJournalEntry("remembrance" , oPC);
	if ((nJournalState == INTIMIDATION_SUCCESS || nJournalState == INTIMIDATION_FAILURE) && !GetLocalInt(oPC, "bRemembranceGuardSpeech"))
	{
		oGuard = GetNearestObjectByTag("remembrance_guard", oPC);
		if (GetObjectSeen(oPC, oGuard))
		{
			AssignCommand(oGuard, ClearAllActions(TRUE));
			AssignCommand(oGuard, ActionSpeakString("Halt!"));
			AssignCommand(oGuard, ActionStartConversation(oPC));
		}
	}
}