// 2bridges_athorius_failsafe
void main()
{
	object oPC = GetEnteringObject();	
	if (GetJournalEntry("2bridges_elias",oPC) == 2)
	{
		object oHench = GetAssociate(ASSOCIATE_TYPE_HENCHMAN, oPC);
		if (GetIsObjectValid(oHench))
		{        
			AssignCommand (oHench, ActionJumpToObject (oPC));
		}		
	}
}