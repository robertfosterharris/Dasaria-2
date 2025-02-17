//aw_exit
//Sets quest position and spawns NPCs for parties leaving the Animal Warren.
//Quest: When Animals Attack
//Loki - 06/08/12


void main()
{
	object oPC = GetEnteringObject();
	int iQuestEntry = GetJournalEntry("aw_quest", oPC);
	//string sMsg = "iQuestEntry: " + IntToString(iQuestEntry);//Debug
	//FloatingTextStringOnCreature(sMsg, oPC, TRUE);//Debug
	
	if ((iQuestEntry > 240 && iQuestEntry <= 260))
		{
		//string sCreature = GetLocalString(OBJECT_SELF, "NPC_Tag");
		//FloatingTextStringOnCreature("Encounter Fire", oPC, TRUE);//Debug
		//FloatingTextStringOnCreature(sCreature, oPC, TRUE);//Debug
		location lNPC = GetLocation(GetWaypointByTag("wp_waa_soldier"));
		object oNPC = CreateObject(OBJECT_TYPE_CREATURE, "aw_fleet", lNPC, FALSE, "aw_fleet");
		AssignCommand(oNPC, DestroyObject(OBJECT_SELF, 120.f));
		AssignCommand(oNPC, ActionStartConversation(oPC, "aw_soldier_convo", FALSE, FALSE, TRUE, TRUE));
		}
	return;
}