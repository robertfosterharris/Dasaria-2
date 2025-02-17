// wired 11/09/2007
// assassin_death

void checkBonus(int nBungled, object oPC);

void main()
{	
	// Advance quest state on PC
	object oLastKiller = GetLastKiller();
	int nEntry = GetJournalEntry("assassin",oLastKiller);
	int nBungled = GetLocalInt(oLastKiller,"nBungled");
	switch (nEntry)
	{
		case 1: AddJournalQuestEntry("assassin",4,oLastKiller,FALSE); checkBonus(nBungled,oLastKiller); break; // killed first victim
		case 5: AddJournalQuestEntry("assassin",6,oLastKiller,FALSE); checkBonus(nBungled,oLastKiller); break; // killed second victim
		case 7: AddJournalQuestEntry("assassin",8,oLastKiller,FALSE); checkBonus(nBungled,oLastKiller); break; // killed third victim
		case 9: AddJournalQuestEntry("assassin",10,oLastKiller,FALSE);checkBonus(nBungled,oLastKiller); break; // killed final victim
		
		// killed the savant
		case 14: AddJournalQuestEntry("assassin",15,oLastKiller,FALSE); GiveXPToCreature(oLastKiller, 250); break;
		// killed stalkinghorse
		case 15: AddJournalQuestEntry("assassin",16,oLastKiller,FALSE); GiveXPToCreature(oLastKiller, 500); break; 
	}
	// don't leave the witnesses/guards wandering around after the target dies
	DeleteLocalInt(oLastKiller,"bluffed");
	DeleteLocalInt(oLastKiller,"nBungled");
	object oWitness1 = GetLocalObject(oLastKiller,"oWitness1");
	object oWitness2 = GetLocalObject(oLastKiller,"oWitness2");
	object oWitness3 = GetLocalObject(oLastKiller,"oWitness3");
	AssignCommand(oWitness1,DelayCommand(90.0,DestroyObject(oWitness1)));
	AssignCommand(oWitness2,DelayCommand(90.0,DestroyObject(oWitness2)));
	AssignCommand(oWitness3,DelayCommand(90.0,DestroyObject(oWitness3)));
}

void checkBonus(int nBungled, object oPC)
{
	if (nBungled != 1)
	{
		string sBonusMsg = "BONUS XP! <i>You have approached unseen.</i>";
		FloatingTextStringOnCreature(sBonusMsg,oPC);
		GiveXPToCreature(oPC, 50);
	}
}