// gc_spawn_newplayer
// wired 02/22/2009
// temporary fix, ID a new player and fire spawn system setup
int StartingConditional()
{
	object oPC = GetPCSpeaker();
	object oJournal = GetItemPossessedBy( oPC,"std_journal");	
	int iDasariaSpawnS = GetLocalInt(oJournal, "iDasariaSpawnS");
	if (iDasariaSpawnS == 0)
	{
		return TRUE;
	}
	return FALSE;
}

/*
// gc_spawn_newplayer
// wired 02/22/2009
// temporary fix, ID a new player and fire spawn system setup
int StartingConditional()
{
	object oPC = GetPCSpeaker();
	object oJournal = GetItemPossessedBy( oPC,"std_journal");	
	int iDasariaSpawnS = GetLocalInt(oJournal, "iDasariaSpawnS");
	if (iDasariaSpawnS == 0)
	{
		return TRUE;
	}
	return FALSE;
}