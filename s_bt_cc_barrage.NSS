#include "i_battle_setting"

// Get Is barrage Set
// sArmy : Army Name
// iBol  : 1 for TRUE, 0 for FALSE
int StartingConditional(string sArmy, int iBol){
	return (GetIsBarrageSet(sArmy) == iBol);
}