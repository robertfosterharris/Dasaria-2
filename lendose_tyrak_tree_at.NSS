// 	lendose_tyrak_tree_at
//	OnAttacked for Lendose Tree
//	wired 02/25/2010
void main()
{
	object oPC = GetLastHostileActor();
	
	if (GetIsObjectValid(GetMaster(oPC)) == TRUE)
	{
            oPC = GetMaster(oPC);
	}		
	object oDaphne = GetObjectByTag("lendose_tyrak_dryad");
	
	if (GetJournalEntry("lendose_tree",oPC)== 0)
	{
		AddJournalQuestEntry("lendose_tree",1,oPC,TRUE);	
	
		if (!GetIsObjectValid(oDaphne))
		{
			oDaphne = CreateObject(OBJECT_TYPE_CREATURE,"lendose_tyrak_dryad",GetLocation(GetObjectByTag("wp_lendose_daphne_sp")));
		}
		ChangeToStandardFaction(oDaphne,STANDARD_FACTION_HOSTILE);		
		AssignCommand(oDaphne,SpeakString("Earthfriends! Defend the tree!"));				
		
		CreateObject(OBJECT_TYPE_CREATURE,"c_shamblingmound",GetLocation(GetObjectByTag("sp_daphne_posse1")));
		CreateObject(OBJECT_TYPE_CREATURE,"c_shamblingmound",GetLocation(GetObjectByTag("sp_daphne_posse2")));
		CreateObject(OBJECT_TYPE_CREATURE,"c_treant",GetLocation(GetObjectByTag("sp_daphne_posse3")));
	}
}