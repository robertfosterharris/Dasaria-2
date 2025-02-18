/*
//::///////////////////////////////////////////////
//:: [Raise Dead]
//:: [NW_S0_RaisDead.nss]
//:: Copyright (c) 2000 Bioware Corp.
//:://////////////////////////////////////////////
//:: Brings a character back to life with 1 HP.
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: Jan 31, 2001
//:://////////////////////////////////////////////
//:: Last Updated By: Preston Watamaniuk, On: April 11, 2001
//:: VFX Pass By: Preston W, On: June 22, 2001


2007/1/15	Jay Four
	Removes mark of death

*/

#include "x2_inc_spellhook" 
#include "std_i0_markofdeath"

void main()
	{
	
	// If code within the PreSpellCastHook (i.e. UMD) reports FALSE, do not run this spell
    if (!X2PreSpellCastCode())
    	{
        return;
    	}

	
    //Declare major variables
    object oTarget = GetSpellTargetObject();
    effect eRaise = EffectResurrection();
    effect eVis = EffectVisualEffect( VFX_HIT_SPELL_CONJURATION );

    //Fire cast spell at event for the specified target
    SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_RAISE_DEAD, FALSE));
    if(GetIsDead(oTarget))
	    {
        //Apply raise dead effect and VFX impact
        ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eVis, GetLocation(oTarget));
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eRaise, oTarget);
		
		// Clear their "mark of death" 
		std_death_mark_remove(oTarget);	
    	}
	

	}
	
	
/*
*/