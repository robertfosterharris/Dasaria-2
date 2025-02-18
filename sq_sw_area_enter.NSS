/*

	This script applies a supernatural spell failure effect (and visual)
	to any PC entering the area

	
	2006/1/16	Richard Pavlicek (k9burn@yahoo.com
		Initial revision
*/



#include "j4acs_uglyhack"
#include "sq_sw_area_inc"

const string c_strMagicFailureMsg = "You feel empty inside.";

void main()
{
    //Declare major variables
    object oPC = GetEnteringObject();

	// This spell failure only applies to PC's
	if (GetIsPC(oPC))
    {
    	// First remove any previous supernatural spell failure effects
	    sq_sw_RemoveSpellFailure(oPC);
	
        // Declare effects
	    int nFailure = 25 + GetHitDice(oPC); // Failure % = 25 + character level
    	effect eDur = EffectVisualEffect(VFX_SPELL_DUR_FOUND_STONE);
	    eDur = SupernaturalEffect(eDur);
        effect eFailure = EffectSpellFailure(nFailure); 
        eFailure = SupernaturalEffect(eFailure);

        // Apply effects
        DelayCommand(2.4, FloatingTextStringOnCreature(c_strMagicFailureMsg, oPC, FALSE));
        ApplyEffectToObject(DURATION_TYPE_PERMANENT, eFailure, oPC);
    	ApplyEffectToObject(DURATION_TYPE_PERMANENT, eDur, oPC);
    }
    ExecuteScript("j4acs_ha_enter", OBJECT_SELF);
}