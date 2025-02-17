//ka_encounter_end  
//ends an encounter with the encounter walking away and despawning.
#include "ginc_overland"
#include "ginc_overland_ai"

void main()
{
	object oPC = GetPCSpeaker();
	ClearAllActions(TRUE);
	ActionMoveAwayFromObject(oPC, FALSE);
	SetIsDestroyable(TRUE, FALSE, FALSE);
	TransitionFleeingToDespawning();
	DestroyObject(OBJECT_SELF, 3.0f);
}