// wired 10/20/201 made edits for readability, area re-use, updated area tags

void main()
{

	object oPC = GetFirstEnteringPC();
	//object oPC = GetEnteringObject();//testing
	
	//REMOVE ME:
	/*if (GetLocalInt(OBJECT_SELF, "Done")) return;
	SetLocalInt(OBJECT_SELF,"Done",1);*/
	//end remove me
	
	int nJournalEntry = GetJournalEntry("carcerum_journal", oPC);
	
	// a DM might be using the area, so
	// do nothing if PC didn't get here
	// by taking the quest
	if (nJournalEntry == 0) return;
	
	string sNPC = "carcerum_traductusfin"; //traductus resref
	
	//If PCs sided with Traductus, spawn Jeremus
	if (nJournalEntry == 11)
	{ 
		sNPC = "carcerum_jeremusfin"; 
	} 
	
	if ((GetLocalInt(GetObjectByTag("carc_hub_rayemit03"),"Carcerum_Portal_Scene")) &&
	(GetTag(GetArea(oPC)) == "darisforest_carcerum_hub")) //Portal scene
	{
		sNPC = "carcerum_jeremusfin";
		object oTraduc = GetObjectByTag(sNPC);
		AssignCommand(oTraduc,ActionStartConversation(oPC,"carc_portal_scene",FALSE,FALSE,TRUE,FALSE));
		return;
	}
	
	if (GetTag(GetArea(oPC)) == "darisforest_carcerum_finale") //Finale scene
	{	
		object oCrackle=GetObjectByTag("carc_fin_cracklelight");
		SetLightActive(oCrackle,TRUE);
		
		location lLoc = GetLocation(GetWaypointByTag("carc_fin_traducspn"));
		object oTraduc = CreateObject(OBJECT_TYPE_CREATURE,sNPC,lLoc);
		
		ApplyEffectToObject(DURATION_TYPE_PERMANENT,
		EffectNWN2SpecialEffectFile("sp_stormrage"),oTraduc);
		ApplyEffectToObject(DURATION_TYPE_PERMANENT,
		EffectNWN2SpecialEffectFile("fx_wraith_eyes"),oTraduc);
		ApplyEffectToObject(DURATION_TYPE_PERMANENT,
		EffectNWN2SpecialEffectFile("sp_invisibility_purge"),oTraduc);
		
		AssignCommand(oTraduc,ActionStartConversation(oPC,"carc_finale",FALSE,FALSE,TRUE,FALSE));
	}
	
	else
	{
		ExecuteScript("j4acs_ha_oce",GetFirstEnteringPC());
	}

}