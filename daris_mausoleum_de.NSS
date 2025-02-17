//	ON DEATH - ONE OF THE MAUSOLEUM INTRUDERS HAS DIED.  ADVANCE THE JOURNAL.
//
//	11/25/2012	ROBERT HARRIS	ROBERTHARRIS@ROBERTHARRIS.COM
//
#include "std_i0_misc"

void main()
{
	int nState;
	object oPC;
	string sTag;

	oPC = GetNearestCreature(CREATURE_TYPE_PLAYER_CHAR, PLAYER_CHAR_IS_PC);
	
	if (GetJournalEntry("daris_marlee", oPC) > 0 && GetJournalEntry("daris_marlee", oPC) < 99)
	{
		SetPartyInt(oPC, GetTag(OBJECT_SELF) + "_done", 1);
		
		nState = 1;
		nState += GetLocalInt(oPC, "daris_egan_done");
		nState += GetLocalInt(oPC, "daris_ismay_done");
		nState += GetLocalInt(oPC, "daris_maeve_done");
		nState += GetLocalInt(oPC, "daris_maseth_done");
		
		AddJournalQuestEntry("daris_marlee", nState, oPC, TRUE, FALSE, FALSE);
		
		if (GetJournalEntry("daris_ismay", oPC) > 0 && GetJournalEntry("daris_ismay", oPC) < 99 && GetTag(OBJECT_SELF) == "daris_ismay")
		{
			AddJournalQuestEntry("daris_ismay", 2, oPC, TRUE, FALSE, FALSE);
		}
	}
}