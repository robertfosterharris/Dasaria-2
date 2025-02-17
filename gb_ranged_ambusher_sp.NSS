// * Ranged attacker
// * Will attempt to stay at ranged distance from their
// * target.
#include "x0_i0_anims"
void main()
{
	SetCombatCondition(X0_COMBAT_FLAG_RANGED);
	SetCombatCondition(X0_COMBAT_FLAG_AMBUSHER);
}