// unseen_casterbattle_failsafe
void main()
{
	object oPC = GetLastUsedBy();	
	location lLoc = GetLocation(GetObjectByTag("casterbattle_end"));
	object oPig = GetObjectByTag("blue_pig");
	object oCaster1 = GetNearestObjectByTag("unseen_battlemage_01");
	object oCaster2 = GetNearestObjectByTag("unseen_battlemage_02");
	object oCaster3 = GetNearestObjectByTag("unseen_battlemage_03");

	DestroyObject(oCaster1);
	DestroyObject(oCaster2);
	DestroyObject(oCaster3);
			
	// if you definitely killed someone last entry, you get a pass
	int nEntry = GetJournalEntry("ravenswatch_casterbattle",oPC);
	if (	nEntry != 12
		&& 	nEntry != 22
		&& 	nEntry != 33	)
	{
		AddJournalQuestEntry("ravenswatch_casterbattle",99,oPC,FALSE);
	}	
	AdjustReputation(oPC,oPig,50);
	//AdjustReputation(oPig,oPC,50);
	
	DelayCommand(5.0f,SetEncounterActive(TRUE,GetNearestObjectByTag("ravenswatch_casterbattle")));
	AssignCommand(oPC, ActionJumpToLocation(lLoc));
	MusicBattleStop(GetArea(oPC));
	DelayCommand(5.0f,DeleteLocalInt(GetNearestObjectByTag("unseen_fightmaker"),"activefight"));	
}