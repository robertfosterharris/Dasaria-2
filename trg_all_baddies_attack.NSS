// trg_all_baddies_attack

// ga_bad rep
// wired: this probably exists but i can't find it right now
#include "NW_I0_GENERIC"

void main()
{
	int n;
	object oTarget;
	object oTest;
	
	// whole area hostile
	n = 1;
	oTarget = GetNearestCreature(CREATURE_TYPE_PLAYER_CHAR, PLAYER_CHAR_NOT_PC, OBJECT_SELF, n);
	while (GetIsObjectValid(oTarget))
	{
		AssignCommand(oTarget, ClearAllActions(TRUE));
		//ChangeToStandardFaction(oTarget, STANDARD_FACTION_HOSTILE);
		oTest = GetNearestCreature(CREATURE_TYPE_PLAYER_CHAR, PLAYER_CHAR_IS_PC, oTarget, 1);
		if (GetIsObjectValid(oTest))
		DelayCommand(1.0, AssignCommand(oTarget, ActionAttack(oTest, FALSE)));
		n++;
		oTarget = GetNearestCreature(CREATURE_TYPE_PLAYER_CHAR, PLAYER_CHAR_NOT_PC, OBJECT_SELF, n);
	}
    DetermineCombatRound();
	// and shout to my allies in the vicinity to join me
    SpeakString ("NW_ATTACK_MY_TARGET", TALKVOLUME_SILENT_TALK);
}