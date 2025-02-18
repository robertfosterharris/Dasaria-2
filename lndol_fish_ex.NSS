// lndol_fish_oe

#include "ginc_ai"
#include "ginc_combat"

void main()
{
	object oFish = GetExitingObject();
	
	if (GetLocalInt(oFish,"nAquatic") == 1)
	{
		//SendMessageToPC(GetFirstPC(),GetName(oFish)+" is a fish.  Sending it back to the drink");
		AssignCommand(oFish, ClearAllActions(TRUE));
		SuspendAI(oFish, TRUE, 6.0f);	
		AssignCommand(oFish, ClearAllActions(TRUE));
		AssignCommand(oFish, JumpToLocation(GetLocation(GetNearestObjectByTag("wp_thalweg"))) );
		AIResetType(oFish);
	}
}