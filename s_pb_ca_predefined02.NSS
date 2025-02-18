#include "i_battle_setting"

//This is an example of predefined battle

void main(){

	// ==================================================
	//Ally

	//Ally Faction 3(Defender), 100 troops, 15 allowed at one time
	CreateArmy("Ally", 3, 100, 15);
	//50% human, Lv = 40% of Avg PC Lv
	AddSoldier("Ally", "c_human", 50, 40);
	//50% elf, Lv = 40% of Avg PC Lv
	AddSoldier("Ally", "c_elf", 30, 40);
	//50% dwarf, Lv = 40% of Avg PC Lv
	AddSoldier("Ally", "c_dwarf", 20, 40);
	//Fire 20 arrows every 3 round, damage = 1d6 (Piercing), reflex save 
	//DC = 15 (Optional)
	SetBarrage("Ally", 3, 20, 1, 15);
	//Fire 4 catapult every 5 round, damage = 5d6 (Blugeoning and fire) 
	//+ knock down, reflex save DC = 15 (Optional)
	SetCatapult("Ally", 5, 4, 5, 15);
	//Battle standard (Optional)
	SetBattleStandard("Ally", "w_battlestandard_01"); 
	
	// ==================================================
	//Enemy
	
	//Enemy Faction 0(Hostile), 100 troops, 15 allowed at one time
	CreateArmy("Enemy", 0, 100, 15);
	//50% skeleton, Lv = 40% of Avg PC Lv
	AddSoldier("Enemy", "c_skeleton", 50, 40);
	//10% skeleton blackguard, Lv = 50% of Avg PC Lv
	AddSoldier("Enemy", "c_skeleton7", 10, 50);
	//40% zombie, Lv = 40% of Avg PC Lv
	AddSoldier("Enemy", "c_zombie", 40, 40);
	//Fire 20 arrows every 3 round, damage = 1d6 (Piercing), reflex save 
	//DC = 15 (Optional)
	SetBarrage("Enemy", 3, 20, 1, 15);
	//Fire 4 catapult every 5 round, damage = 5d6 (Blugeoning and fire) 
	//+ knock down, reflex save DC = 15 (Optional)
	SetCatapult("Enemy", 5, 4, 5, 15);
	//Battle standard (Optional)
	SetBattleStandard("Enemy", "w_battlestandard_02");
	
	// ==================================================
	//Fog of war On (Optional)
	SetFogOfWar(TRUE);
	//Start the battle
	BeginBattle();
}