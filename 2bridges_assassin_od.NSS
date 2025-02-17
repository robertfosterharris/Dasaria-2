// wired 12/18/2007
// 2bridges_assassin_death
// re-write of the old script
#include "ginc_journal"
void checkBonus(int nBungled, object oPC);

void main()
{	
	object oPC;
	int nEntry;
	int nKills;
	int nBungled;
	
	oPC = GetLastKiller();	
	
	if (GetIsObjectValid(GetMaster(oPC)) == TRUE)
	{
            oPC = GetMaster(oPC);
	}	
	
	nEntry = GetJournalEntry("2bridges_assassin",oPC);
	nBungled = GetLocalInt(oPC,"nBungled");
	
	switch (nEntry)
	{
		case 1: 
		{
			nKills = GetLocalInt(oPC,"wounded_kills");
			nKills = nKills+1;
			SetLocalInt(oPC,"wounded_kills",nKills);
			if (nKills == 4)
			{
				AddJournalQuestEntry("2bridges_assassin",3,oPC,FALSE); 
				//checkBonus(nBungled,oPC); 
				AdjustAlignment(oPC,-1,0);
				RewardPartyQuestXP(oPC,"2bridges_assassin",20);
			}
		}
		break; 
		case 6: 
		{
			AddJournalQuestEntry("2bridges_assassin",7,oPC,FALSE);
			checkBonus(nBungled,oPC); 
			AdjustAlignment(oPC,-1,0); 
			RewardPartyQuestXP(oPC,"2bridges_assassin",50);
		}
		break; // killed third victim
	}
	// don't leave the witnesses/guards wandering around after the target dies
	DeleteLocalInt(oPC,"bluffed");
	DeleteLocalInt(oPC,"nBungled");
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