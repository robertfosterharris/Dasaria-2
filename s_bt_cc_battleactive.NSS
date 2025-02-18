#include "i_battle_setting"

// Get Is Battle Active
// iBol : 1 for TRUE, 0 for FALSE
int StartingConditional(int iBol){
	return (GetIsBattleActive() == iBol);
}