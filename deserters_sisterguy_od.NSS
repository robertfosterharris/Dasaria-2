//deserters_sisterguy_od
//advances journal state ondeath
void main()
{
	object oPC = GetLastKiller();
	
     if (GetIsObjectValid(GetMaster(oPC)) == TRUE)
     {
     	oPC = GetMaster(oPC);
     }	
	if ( GetJournalEntry("docks_deserters",oPC) == 9)
	{
		AddJournalQuestEntry("docks_deserters",15,oPC,TRUE);
	}
}