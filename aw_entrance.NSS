//aw_entrance
//Sets quest position for parties entering the Animal Warren.
//Quest: When Animals Attack
//Loki - 07/27/12
//v2.4

void main()
{
	object oPC = GetEnteringObject();
	int iQuestEntry = GetJournalEntry("aw_quest", oPC);
	//string sMsg = "iQuestEntry: " + IntToString(iQuestEntry);//Debug
	//FloatingTextStringOnCreature(sMsg, oPC, TRUE);//Debug
	//FloatingTextStringOnCreature("You slide down a steep dirt slope and land some distance away.", oPC, TRUE);
	if ((iQuestEntry >= 100) && (iQuestEntry <= 200))
		{
		AddJournalQuestEntry("aw_quest", 240, oPC, TRUE, FALSE);
		} else {return;}
}