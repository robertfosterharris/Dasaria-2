#include "i_battle_setting"
// -------------------------------------------------------
// Add a soldier type to the army
//
// sArmy  : Army Name
// sRes   : ResRef for the type
// iPrcnt : The percentage of this type in the army 
//          If total percentage (include previously added type)
//          exceeds 100, the excess will be ignored
// iLvAdj : Level adjustment (relative to PC), -1 for no adjustment
//
// e.g. AddSolider("Enemy", "c_skeleton", 50); 
//      AddSolider("Enemy", "c_zombie", 55); 
// makes the Enemy Army consists of skeletons and zombies (50/50)
// the 5% excess of zombie is ignored
void main(string sArmy, string sRes, int iPrcnt, int iLvAdj){
	AddSoldier(sArmy, sRes, iPrcnt, iLvAdj);
}