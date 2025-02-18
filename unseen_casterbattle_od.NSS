// unseen_casterbattle_od
void main()
{
	object oLastKiller = GetLastKiller();
	object oPCFighting = GetLocalObject(OBJECT_SELF,"oPCFighting");  
	object oPig = GetObjectByTag("blue_pig");
	location lLoc = GetLocation(GetNearestObjectByTag("casterbattle_end"));
	
	if (oLastKiller == oPCFighting)
	{
		// Debug Message
		FloatingTextStringOnCreature("You Win!",oLastKiller);
		
		// Make blue un-hate the PC
		AdjustReputation(oLastKiller,oPig,50);
		AdjustReputation(oPig,oLastKiller,50);
		
		// Advance quest state on PC
		int nEntry1 = GetJournalEntry("ravenswatch_casterbattle",oLastKiller);
		switch (nEntry1)
		{
			case 10:
			case 11: AddJournalQuestEntry("ravenswatch_casterbattle",12,oLastKiller,FALSE); break; // killed in first round
			case 20:
			case 21: AddJournalQuestEntry("ravenswatch_casterbattle",22,oLastKiller,FALSE); break; // killed in second round
			case 30:
			case 31: AddJournalQuestEntry("ravenswatch_casterbattle",32,oLastKiller,FALSE); // killed in third round
				AssignCommand(oPCFighting, DelayCommand(5.0,SetEncounterActive(TRUE,GetNearestObjectByTag("ravenswatch_casterbattle"))));
				break; 
		}
	
		// Preen
		DelayCommand(2.0,AssignCommand(oLastKiller, ActionPlayAnimation(ANIMATION_FIREFORGET_BOW)));
		DelayCommand(3.0,ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(566),oLastKiller));
		FloatingTextStringOnCreature("There can be only one!",oLastKiller);
	}
	else
	{
		SendMessageToPC(oPCFighting, "Forfeit! A battlemage must be defeated by his intended opponent.");
	}
		
	// Return the PC -- put these on the PC	as we might be destroyed already
	AssignCommand(oPCFighting, DelayCommand(4.0,ActionJumpToLocation(lLoc)));
	AssignCommand(oPCFighting, DelayCommand(4.0,ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(99), oPCFighting)));
	MusicBattleStop(GetArea(OBJECT_SELF));
	AssignCommand(oPCFighting, DelayCommand(5.0,DeleteLocalInt(GetNearestObjectByTag("unseen_fightmaker"),"activefight")));
	PlayCustomAnimation(GetNearestObjectByTag("unseen_fightmaker"),"clapping", 0);
}