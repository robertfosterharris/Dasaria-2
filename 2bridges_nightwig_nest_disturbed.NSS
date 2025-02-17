// 2bridges_nightwig_nest_disturbed
void main()
{
    object oItem=GetInventoryDisturbItem();
    object oPC=GetLastDisturbed();
    int nType=GetInventoryDisturbType();
	int nEntry = GetJournalEntry("2bridges_dragon",oPC);
	object oCreature = GetNearestObjectByTag("2bridges_nightwig");
	object oNest = OBJECT_SELF;
	
	// we're supposed to be putting the egg in the nes and we do so
	if (	(GetTag(oItem) == "2bridges_dragonegg") &&
			(nEntry == 3) &&
			(nType == INVENTORY_DISTURB_TYPE_ADDED)	)
	{
		AddJournalQuestEntry("2bridges_dragon",4,oPC,TRUE,FALSE,FALSE);
		DestroyObject(oItem);
	}
	else if (GetIsObjectValid(oCreature))
	{
		// if we're not on the quest and just screwing with 
		// the nest, mark mortal before attacking
		if (nEntry < 0 || nEntry > 4)
		{
			SetImmortal(oCreature,FALSE);
		}
		// otherwise rely on the conversation to mark her mortal and...
		// attack		
		AssignCommand(oCreature,ActionSpeakString("Who dares disturb my nest?!"));
		AssignCommand(oCreature,ActionForceMoveToObject(oNest,TRUE));		
	}
}