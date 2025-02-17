// i_temp_ci
/*
   Template for Casting Spell on item script.
   This script runs when a spell is cast on an item.
	
   How to use this script:
   Replace the word "temp" (in line 1) with the tag of the item.  Rename the script with this name.  
    
   Additional Info:
   In general, all the item "tag-based" scripts will be named as follows:
   - a prefix ("i_" by defualt)
   - the tag of the item
   - a postfix indicating the item event.
   
   This script will be called automatically (by defualt) whether it exists or not.  If if does not exist, nothing happens.
   
   Note: this script runs on the character who cast the spell on the item.
   -ChazM
*/
// Name_Date
	
#include "x2_inc_switches"
	
void main()
{
	object oPC = OBJECT_SELF;               	// The player who cast the spell
	object oItem  = GetSpellTargetObject();     // The item targeted by the spell
	int iSpell = GetSpellId();                  // The id of the spell that was cast
                                            	// See the list of SPELL_* constants
 	//Your code goes here
	
	switch (iSpell)
	{
		case SPELL_PROTECTION_FROM_EVIL:
			FloatingTextStringOnCreature(GetFirstName(oPC)+" casts <i>Protection from Evil</i> on the device.",oPC);
		break;		
		case SPELL_UNDEATH_TO_DEATH:
			FloatingTextStringOnCreature(GetFirstName(oPC)+" casts <i>Undeath to Death</i> on the device.",oPC);
		break;
		case SPELL_PLANAR_BINDING:
			FloatingTextStringOnCreature(GetFirstName(oPC)+" casts <i>Planar Binding</i> on the device.",oPC);
		break;
		case SPELL_CONTROL_UNDEAD:
			FloatingTextStringOnCreature(GetFirstName(oPC)+" casts <i>Control Undead</i> on the device.",oPC);
		break;
		case SPELL_MORDENKAINENS_DISJUNCTION:
			FloatingTextStringOnCreature(GetFirstName(oPC)+" casts <i>Mordenkainen's Disjunction</i> on the device.",oPC);
		break;
		case SPELL_STORM_OF_VENGEANCE:
			FloatingTextStringOnCreature(GetFirstName(oPC)+" casts <i>Storm of Vengence</i> on the device.",oPC);
		break;									
	}
	
	effect eVis = EffectVisualEffect(VFX_SPELL_DUR_COCOON);
	ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eVis,oItem,5.0f);

	SetExecutedScriptReturnValue(X2_EXECUTE_SCRIPT_END); // prevent spell that was cast from taking effect
	//SetExecutedScriptReturnValue(X2_EXECUTE_SCRIPT_CONTINUE); // this will allow spell to take effect
}