// gb_imprvd_statue_sp
// by Brendan Bellina
// June, 2008
// Based partly on gb_statue_sp
// Use this to spawn a creature in as a statue or frozen.
// Set creature variables:
//   SpawnScript to this script
//   InAbnormalState to 1 (stone) or 2 (frozen)
//   ud_script to a user defined script like bb_unstatue_ud to allow reversal
// In the creature conversation have the first node of the conversation exit if InAbnormalState is not 0
// Creatures should be set to a neutral faction so that cannot be attacked by anyone,
// and should be set to Plot so that they cannot be harmed. Use the local object variables
// SetHostile and PlotOff in conjunction with the bb_unstatue_ud script to make them
// unfrozen, hostile, and attack. bb_unstatue_ud will also use a local variable UnstatueScript
// to call a script like bb_startconv (to initiate a conversation) or other scripts.
#include "NW_I0_GENERIC"
void main()
{
    object oTarget = OBJECT_SELF;
	// Set the following local int on the creature to determine the initial state
	int nAbnormalState = GetLocalInt(oTarget, "InAbnormalState");
	// Allows using a user defined script to check for a spell to undo the abnormal state
   	SetSpawnInCondition(NW_FLAG_SPELL_CAST_AT_EVENT, TRUE);
	
	if (nAbnormalState == 1) // if stone
	{
		effect eStoneskin = SupernaturalEffect( EffectVisualEffect( VFX_DUR_SPELL_FLESH_TO_STONE ) );
		ApplyEffectToObject( DURATION_TYPE_PERMANENT, eStoneskin, OBJECT_SELF );
	}
	if (nAbnormalState == 1 || nAbnormalState == 2 || !nAbnormalState) // if stone or just frozen
	{
		// This is needed to keep the creature from moving around
		effect eFreeze = SupernaturalEffect( EffectVisualEffect( VFX_DUR_FREEZE_ANIMATION ) );
		ApplyEffectToObject( DURATION_TYPE_PERMANENT, eFreeze, OBJECT_SELF );
		// Needed to prevent turning when spoken to
		SetOrientOnDialog(oTarget, FALSE);
		// Needed to prevent moving when bumped into
		SetBumpState(oTarget, BUMPSTATE_UNBUMPABLE);
	}
}