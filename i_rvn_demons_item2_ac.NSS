int GetIsInTrigger( object oTrigger, object oPC )
{
    object oTarget = GetFirstInPersistentObject( oTrigger, OBJECT_TYPE_CREATURE ) ;
    while ( GetIsObjectValid( oTarget ) )
    {
        if ( oTarget == oPC ) return TRUE ;
        oTarget = GetNextInPersistentObject( oTrigger, OBJECT_TYPE_CREATURE ) ;
    }
    return FALSE ;
}

void main()
{
	object oPC = GetItemActivator();
	object oItem = GetItemActivated();
	object oTarget = GetItemActivatedTarget();
	object oTrigger = GetNearestObjectByTag("unseen_demon_trg",oPC);
	// you're in the right place
	if (GetIsInTrigger(oTrigger,oPC))
	{
		// you're at the right point in the quest
		int nEntry = GetJournalEntry("ravenswatch_demons",oPC);
		if (nEntry == 6)
		{
			// remove hench
			object oHench = GetObjectByTag("ravenswatch_demons_virgin");
			RemoveHenchman(oPC,oHench);
			
			// cleanup needless NPCs
			SetEncounterActive(FALSE,GetNearestObjectByTag("ravenswatch_casterbattle"));
			DestroyObject(GetNearestObjectByTag("ravenswatch_caster1"));
			DestroyObject(GetNearestObjectByTag("ravenswatch_caster2"));
			DelayCommand(120.0f,SetEncounterActive(TRUE,GetNearestObjectByTag("ravenswatch_casterbattle")));
				
			// run like hell
			AssignCommand(oHench, SpeakString("Uh oh. This doesnt look good.  I'm outta here!"));
			AssignCommand(oHench, ActionForceMoveToObject(GetNearestObjectByTag("std_respawn_area_wp"),TRUE));
			DestroyObject(oHench,15.0f);
		
			object oDemon1 = GetNearestObjectByTag("ravenswatch_demon1",oPC);
			object oDemon2 = GetNearestObjectByTag("ravenswatch_demon2",oPC);
			
			// and the petrified demons exist
			if (!GetIsObjectValid(oDemon1) || !GetIsObjectValid(oDemon2) )
			{
				SendMessageToPC(oPC,"<i>Nothing happens.</i>");
				return;
			}
			// ok, depetrify
			location lDemon1 = GetLocation(GetWaypointByTag("unseen_demonspawn1"));
			location lDemon2 = GetLocation(GetWaypointByTag("unseen_demonspawn2"));
			DestroyObject(oDemon1);
			DestroyObject(oDemon2);	
			object oLiveDemon1 = CreateObject(1,"ravenswatch_demon_live",lDemon1);
			object oLiveDemon2 = CreateObject(1,"ravenswatch_demon_live",lDemon2);
			
			//advance journal
			AddJournalQuestEntry("ravenswatch_demons",7,oPC,TRUE);
			
			// destroy the wand
			DestroyObject(oItem);
			DestroyObject(OBJECT_SELF);	
		}
		else
		{	
			// you're not at the right point in the quest
			SendMessageToPC(oPC,"<i>The wand fizzles. You're probably missing something necessary for its operation.</i>");
		}
	}
	else
	{
		// you're not where you're supposed to be
		SendMessageToPC(oPC,"<i>The wand fizzles.  You're probably targetting the wrong thing.</i>");
	}
}