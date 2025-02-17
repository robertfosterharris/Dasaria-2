void main()
{
	int nUser = GetUserDefinedEventNumber();
	int nRandom = d8();
	object oCustomer = GetLocalObject(OBJECT_SELF, "CUSTOMER");
	object oBar = GetWaypointByTag("WP_BAR");
	
	if (nUser == EVENT_HEARTBEAT) // This is a heartbeat event, every 6 sec
	{
		if (!GetIsObjectValid(oCustomer))
		{
			// Randomly seek out up to the 8th-nearest non-PC
			oCustomer = GetNearestCreature(CREATURE_TYPE_PLAYER_CHAR, PLAYER_CHAR_NOT_PC, OBJECT_SELF, nRandom);
			if (oCustomer != OBJECT_SELF && GetIsObjectValid(oCustomer) )
			{
				// Move to Customer
				SetLocalInt(OBJECT_SELF, "BARMAID_STATE", 1);
				SetLocalObject(OBJECT_SELF, "CUSTOMER", oCustomer);
				ActionMoveToObject(oCustomer);
				ActionDoCommand(SpeakOneLinerConversation("waitress_wait_tables"));
				ActionWait(1.0);
				
				// Move to Bar
				ActionDoCommand(SetLocalInt(OBJECT_SELF, "BARMAID_STATE", 2));
				ActionMoveToObject(oBar);
				ActionDoCommand(SpeakOneLinerConversation("waitress_wait_tables"));
				ActionWait(1.0);
				
				// Move back to the customer
				ActionDoCommand(SetLocalInt(OBJECT_SELF, "BARMAID_STATE", 3));
				ActionMoveToObject(oCustomer);
				ActionDoCommand(SpeakOneLinerConversation("waitress_wait_tables"));
				ActionWait(3.0);
				ActionDoCommand(SetLocalObject(OBJECT_SELF, "CUSTOMER", OBJECT_INVALID));
			}
		}
	}
	
	if (nUser == EVENT_DIALOGUE) // this is the OnDialogue event
	{
		// Reset my actions
		SetLocalObject(OBJECT_SELF, "CUSTOMER", OBJECT_INVALID);
		SetLocalInt(OBJECT_SELF, "BARMAID_STATE", 0);
	}
}