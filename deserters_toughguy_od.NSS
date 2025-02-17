//deserters_toughguy_od
//advances journal state ondeath
void main()
{
	object oPC = GetLastKiller();
	
     if (GetIsObjectValid(GetMaster(oPC)) == TRUE)
     {
     	oPC = GetMaster(oPC);
     }
			
	if ( GetJournalEntry("docks_deserters",oPC) == 3)
	{
		AddJournalQuestEntry("docks_deserters",5,oPC,TRUE);
	}
}