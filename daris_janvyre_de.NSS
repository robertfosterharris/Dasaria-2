//	ON DEATH - SPAWNS A DEAD JANVYRE IF NEEDED AND ADVANCES JOURNAL
//
//	12/02/2011	ROBERT HARRIS	ROBERTHARRIS@ROBERTHARRIS.COM
//
void main()
{
	location lLocation;
	object oJanvyre;
	object oPC;

	if (GetResRef(OBJECT_SELF) == "daris_janvyre_howling")
	{
		lLocation = GetLocation(OBJECT_SELF);
		oJanvyre = CreateObject(OBJECT_TYPE_CREATURE, "daris_janvyre", lLocation);
		ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectDeath(FALSE, TRUE, TRUE, TRUE), oJanvyre);
	}

	oPC = GetLastKiller();
	AdjustAlignment(oPC, ALIGNMENT_EVIL, 1);
	AddJournalQuestEntry("daris_janvyre", 3, oPC, TRUE);
}