#include "i_battle_setting"

// Starts the battle
// sVD : Victory/Defeat script 
//
// Default will be used if sVD is empty
// Default Victory Condition is enemy Annihilation
// Default Victory Action is show a battle report
// Default Defeat Condition is ally Annihilation
// Default Defeat Action is show a battle report
void main(string sVD){
	BeginBattle(sVD);
}