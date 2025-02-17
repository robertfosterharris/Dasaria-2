// Wired 01/22/11 DEPRECATED: Use gb_imprvd_statue_sp instead


// gb_statue_sp
/*
    Causes creature to spawn in as a statue.
	
	Clears all creature scripts, sets as plot, applies petrify, etc.
	
	Local vars used with this script:
	(variable set "b_effect")
	int EFFECT - the visual duration effect (defualts to 0 - VFX_DUR_BLUR)
				Example duration effect values:
					int VFX_NONE                        = -1;
					int VFX_DUR_BLUR                    = 0;
					int VFX_DUR_SPELL_FLESH_TO_STONE    = 721;
					int VFX_SPELL_DUR_BODY_SUN			= 924;
	
*/
// ChazM 3/28/07

// Wired 04/19/2010 work around dasaria default spawn setting ambients
//					in a way that screws up statue creatures

#include "NW_I0_GENERIC"
#include "ginc_event_handlers"

void main()
{
    object oTarget = OBJECT_SELF;
	effect eDur;
	SetOrientOnDialog(oTarget, FALSE);
	
	// do eet here!
	SetCreatureFlag(OBJECT_SELF, CREATURE_VAR_USE_SPAWN_AMBIENT, FALSE);
	SetCommandable(FALSE,oTarget);
	
    effect ePetrify = EffectPetrify();
	
	int iEffect = GetLocalInt(oTarget, "EFFECT");
	
	if (iEffect != VFX_NONE)
	{
		eDur = EffectVisualEffect( iEffect );
	    //ePetrify = EffectLinkEffects(eDur, ePetrify);
	}	
	
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, ePetrify, oTarget);
	ApplyEffectToObject(DURATION_TYPE_PERMANENT, eDur, oTarget);
    PrettyDebug(GetName(oTarget) + " - petrified by spawn");
	
	// prevent from being bumpable
	SetBumpState(oTarget, BUMPSTATE_UNBUMPABLE);
	
	// No need to have event handlers if we are just standing here
	// (Actually, the empty set defualts to something.  To get truly 
	// nothing we must use the nothing scripts).
	SetAllEventHandlers(oTarget, SCRIPT_OBJECT_NOTHING);
	
	// except for dialog in case we want to talk. (need special conv. script)
    SetEventHandler(oTarget, CREATURE_SCRIPT_ON_DIALOGUE, "gb_statue_conv");
	
	// make plot so creature is indestructable	
	SetPlotFlag(oTarget, TRUE);
	
	// Don't run the standard script since all we want is for the creature
	// to be permanently paralyzed like a statue, so no treasure generation,
	// setting AI flags, etc.
	
    // ===================================================================
    // now run the standard spawn.  This may run other scripts, create treasure, and set various flags
    //ExecuteScript(SCRIPT_DEFAULT_SPAWN, OBJECT_SELF);
	
}