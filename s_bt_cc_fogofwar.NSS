#include "i_battle_setting"

// Get Is Fog Of War On/Off
int StartingConditional(int iBol){
	return (GetFogOfWar() == iBol);
}