#include "i_battle_setting"
#include "dasolm_inc"

// battle1

void main()
{
	object oLeader = GetFactionLeader(GetPCSpeaker());
	int nMetaFaction = getMetaFaction(	oLeader	);
	int nArmy = DasOL_GetMaxAllies(oLeader)*6;
	string sMetaFaction = IntToString(	nMetaFaction	);
	string sRef1 = "lndol_"+sMetaFaction+"_swordsman";
	string sRef2 = "lndol_"+sMetaFaction+"_archer";
	string sRef3 = "lndol_"+sMetaFaction+"_halberd";

	// ==================================================
	//Ally

	//Ally Faction 3(Defender), 100 troops, 15 allowed at one time
	CreateArmy("Ally", 3, nArmy, 15);
	//50% human, Lv = 40% of Avg PC Lv
	AddSoldier("Ally", sRef1, 50, 40);
	//50% elf, Lv = 40% of Avg PC Lv
	AddSoldier("Ally", sRef2, 30, 40);
	//50% dwarf, Lv = 40% of Avg PC Lv
	AddSoldier("Ally", sRef3, 20, 40);
	//Fire 20 arrows every 3 round, damage = 1d6 (Piercing), reflex save 
	//DC = 15 (Optional)
	SetBarrage("Ally", 3, 20, 1, 15);
	//Fire 4 catapult every 5 round, damage = 5d6 (Blugeoning and fire) 
	//+ knock down, reflex save DC = 15 (Optional)
	SetCatapult("Ally", 5, 4, 5, 15);
	//Battle standard (Optional)
	//SetBattleStandard("Ally", "w_battlestandard_01"); 
	
	// ==================================================
	//Enemy
	
	if (nMetaFaction == 3)
	{
		nMetaFaction = 2;
	}
	else
	{
		nMetaFaction = 3;
	}
	sMetaFaction = IntToString(	nMetaFaction	);
	sRef1 = "lndol_"+sMetaFaction+"_swordsman";
	sRef2 = "lndol_"+sMetaFaction+"_archer";
	sRef3 = "lndol_"+sMetaFaction+"_halberd";
	
	//Enemy Faction 0(Hostile), 100 troops, 15 allowed at one time
	CreateArmy("Enemy", 0, 100, 15);
	//50% orc, Lv = 40% of Avg PC Lv
	AddSoldier("Enemy", sRef1, 50, 40);
	//10% chief, Lv = 50% of Avg PC Lv
	AddSoldier("Enemy", sRef2, 10, 50);
	//40% goblin, Lv = 40% of Avg PC Lv
	AddSoldier("Enemy", sRef3, 40, 40);
	//Fire 20 arrows every 3 round, damage = 1d6 (Piercing), reflex save 
	//DC = 15 (Optional)
	SetBarrage("Enemy", 3, 20, 1, 15);
	//Fire 4 catapult every 5 round, damage = 5d6 (Blugeoning and fire) 
	//+ knock down, reflex save DC = 15 (Optional)
	SetCatapult("Enemy", 5, 4, 5, 15);
	//Battle standard (Optional)
	//SetBattleStandard("Enemy", "w_battlestandard_02");
	
	// ==================================================
	//Fog of war On (Optional)
	//SetFogOfWar(TRUE);
	//Start the battle
	BeginBattle("dasolm_victorydefeat");
}