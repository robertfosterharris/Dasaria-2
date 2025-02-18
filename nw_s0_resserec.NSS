/*
//::///////////////////////////////////////////////
//:: [Ressurection]
//:: [NW_S0_Ressurec.nss]
//:: Copyright (c) 2000 Bioware Corp.
//:://////////////////////////////////////////////
//:: Brings a character back to life with full
//:: health.
//:: When cast on placeables, you get a default error message.
//::   * You can specify a different message in
//::      X2_L_RESURRECT_SPELL_MSG_RESREF
//::   * You can turn off the message by setting the variable
//::     to -1
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: Jan 31, 2001
//:://////////////////////////////////////////////
//:: Last Updated By: Georg Z on 2003-07-31
//:: VFX Pass By: Preston W, On: June 22, 2001


2007/1/15	Jay Four
	Removes mark of death
	Also, actually, I more or less rewrote it from the ground up, to be sane.
	And let me just ask.  What the heck?  Custom error messages on placeables?
	Dude.  Lay off the crack.

*/

#include "x2_inc_spellhook"
#include "std_i0_markofdeath"

void main()
	{

    // If code within the PreSpellCastHook (i.e. UMD) reports FALSE, do not run this spell
    if (!X2PreSpellCastCode())
        return;

    object oTarget = GetSpellTargetObject();

	// Check for invalid target
	if ( !GetIsObjectValid(oTarget))
		return;
	
	// Send event
	SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_RESURRECTION, FALSE));
	
	// Stop if not dead
	if ( !GetIsDead(oTarget) )
		return;

	// Begin raise
	int nHealed = GetMaxHitPoints(oTarget);
	effect eRaise = EffectResurrection();
	effect eHeal = EffectHeal(nHealed + 10);
	effect eVis = EffectVisualEffect(VFX_IMP_HEALING_G);
	ApplyEffectToObject(DURATION_TYPE_INSTANT, eRaise, oTarget);
	ApplyEffectToObject(DURATION_TYPE_INSTANT, eHeal, oTarget);
	ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eVis, GetLocation(oTarget));
			
	// Clear their "mark of death" 
	std_death_mark_remove( oTarget );				
	}



/*
*/