#include "i_battle_setting"

// wired 08/15/2011 

void nixVar(object oPC)
{
	if (!GetIsObjectValid(oPC))
	{
		DeleteLocalInt(oPC,"bKoboldBattleFired");
	}
}

void main()
{

	object oPC = GetEnteringObject();
	if (!GetIsPC(oPC)) return;
	
	object oLeader = GetFactionLeader(oPC);
	
	if (GetLocalInt(oLeader,"bKoboldBattleFired") != 1)
	{
		SetLocalInt(oLeader,"bKoboldBattleFired",1);
		DelayCommand(1800.0,	nixVar(oLeader)	);

		// ==================================================
		//Enemy
		
		//Enemy Faction 0(Hostile), 100 troops, 15 allowed at one time
		CreateArmy("Enemy", 0, 50, 10);
		//50% orc, Lv = 40% of Avg PC Lv
		AddSoldier("Enemy", "kobold_archer", 20, 60);
		//10% chief, Lv = 50% of Avg PC Lv
		AddSoldier("Enemy", "kobold_spear", 20, 60);
		//40% goblin, Lv = 40% of Avg PC Lv
		AddSoldier("Enemy", "kobold_ranger", 15, 60);
		//40% goblin, Lv = 40% of Avg PC Lv
		AddSoldier("Enemy", "kobold_rogue", 15, 60);
		//40% goblin, Lv = 40% of Avg PC Lv
		AddSoldier("Enemy", "kobold_assassin", 15, 60);
		//40% goblin, Lv = 40% of Avg PC Lv
		AddSoldier("Enemy", "kobold_warleader", 5, 60);	
		//40% goblin, Lv = 40% of Avg PC Lv
		AddSoldier("Enemy", "kobold_cleric", 10, 60);		
		
		//Fire 20 arrows every 3 round, damage = 1d6 (Piercing), reflex save 
		//DC = 15 (Optional)
		SetBarrage("Enemy", 4, 6, 1, 10);
		//Fire 4 catapult every 5 round, damage = 5d6 (Blugeoning and fire) 
		//+ knock down, reflex save DC = 15 (Optional)
		SetCatapult("Enemy", 10, 1, 2, 15);
		//Battle standard (Optional)
		//SetBattleStandard("Enemy", "w_battlestandard_02");
		
		// ==================================================
		//Fog of war On (Optional)
		//SetFogOfWar(TRUE);
		//Start the battle
		BeginBattle();
	
	}
}