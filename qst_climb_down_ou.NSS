#include "sj_armor_i"

void climb_down();

void climb_down() {
	object oPC = GetLastUsedBy();
	int iStrModifier = GetAbilityModifier(ABILITY_STRENGTH, oPC);
	int iDexModifier = GetAbilityModifier(ABILITY_DEXTERITY, oPC);
	int iPCWeight = GetWeight(oPC);
	object oArmor = GetItemInSlot(INVENTORY_SLOT_CHEST, oPC);
	object oWP = GetObjectByTag(GetLocalString(OBJECT_SELF, "WP_jump_to"));
	location loc = GetLocation(oWP);
	int iACP = SJ_Armor_GetItemArmorCheckPenalty(oArmor);
	int iClimbDC = 15; // dc to climb an unknotted rope, as per PHB
	int iClimbCheck = d20() + iStrModifier - iACP;
	if (iClimbCheck >= iClimbDC) {
		// made it safely down, so transition.
		AssignCommand(oPC, ClearAllActions());
  		AssignCommand(oPC, ActionJumpToLocation(loc));
		if (iDexModifier > 4 && iPCWeight < 500) {
			FloatingTextStringOnCreature("You climb down safely to the bottom.", oPC);
		} else if (iPCWeight < 500) {
			FloatingTextStringOnCreature("You climb down rather clumsily, but safely to the bottom.", oPC);
		} else {
			FloatingTextStringOnCreature("Your over-burdened self clumsily climbs down, as you near the bottom, you can bear your own weight no more and your grip slips, and you land in an undignified fashion on your rear, bruising yourself slightly.", oPC);
			effect eDamage = EffectDamage(Random(25), DAMAGE_TYPE_BLUDGEONING);
			ApplyEffectToObject(DURATION_TYPE_INSTANT, eDamage, oPC);
		}
			
	} else {
		// falling, so transition, then take damage.
		AssignCommand(oPC, ClearAllActions());
  		AssignCommand(oPC, ActionJumpToLocation(loc));
		
		// now apply damage
		effect eDamage = EffectDamage(Random(75), DAMAGE_TYPE_BLUDGEONING);
		ApplyEffectToObject(DURATION_TYPE_INSTANT, eDamage, oPC);
		FloatingTextStringOnCreature("You slip, and fall to the cave floor below, injuring yourself in the process.", oPC);
	}
	
}