/*

	This script applies a supernatural spell failure effect (and visual)
	to any PC entering the area

	
	2006/1/16	Richard Pavlicek (k9burn@yahoo.com
		Initial revision
		
	Wired 10/23/2008  This is just the Shai Quest script without the VFX/messages, I needed it for an event
*/

#include "j4acs_uglyhack"
#include "sq_sw_area_inc"

void main()
{
    //Declare major variables
    object oPC = GetEnteringObject();
	
	if (GetIsDM(oPC)) return;

	// This spell failure only applies to PC's
	if (GetIsPC(oPC))
    {
    	// First remove any previous supernatural spell failure effects
	    sq_sw_RemoveSpellFailure(oPC);
	
        // Declare effects
	    int nFailure = 100; 
    	effect eFailure = EffectSpellFailure(nFailure); 
        eFailure = SupernaturalEffect(eFailure);

        // Apply effects
        ApplyEffectToObject(DURATION_TYPE_PERMANENT, eFailure, oPC);
    	
    }
    ExecuteScript("j4acs_ha_enter", OBJECT_SELF);
}