/*
	Determine if PC Speaker's skill roll is successful.
	
	This is a customised version of gc_skill_dc to include 
	a few additional checks, based on possessing an item, 
	as well a racial adjuster.
	
	Parameters:
		int nSkill 			= skill int to check
		int nDC				= difficulty class to beat
		int nRacialtype		= racial type that racial bonus is applied for
		int nRacialBonus	= bonus to be applied if PC's racial type is the same as nRacialType
		string sItem		= tag of item that PC must have in inventory for item bonus to be applied
		int nItemBonus		= bonus to be applied if PC possesses sItem.
	
	Remarks:
		skill ints
		0	APPRAISE
		1	BLUFF
		2	CONCENTRATION
		3	CRAFT ALCHEMY
		4	CRAFT ARMOR
		5	CRAFT WEAPON
		6	DIPLOMACY
		7	DISABLE DEVICE
		8	DISCIPLINE
		9	HEAL
		10	HIDE
		11	INTIMIDATE
		12	LISTEN
		13	LORE
		14	MOVE SILENTLY
		15	OPEN LOCK
		16	PARRY
		17	PERFORM
		18	RIDE
		19	SEARCH
		20	CRAFT TRAP
		21	SLEIGHT OF HAND
		22	SPELL CRAFT
		23	SPOT
		24	SURVIVAL
		25	TAUNT
		26	TUMBLE
		27	USE MAGIC DEVICE
		
		Racial ints:
		00	DWARF
		01	ELF
		02	GNOME
		03	HALFLING
		04	HALF-ELF
		05	HALF-ORC
		06	HUMAN
		
*/

#include "ginc_param_const"

int StartingConditional(int nSkill, int nDC, int nRacialtype, int nRacialBonus, string sItem, int nItemBonus)
{
	object oPC = GetPCSpeaker();
	int nSkillVal = GetSkillConstant(nSkill);
	// apply racial bonus if applicable
	int pcRacialType = GetRacialType(oPC);
	int adjustedDC = nDC;
	if (pcRacialType == nRacialtype) {
		SendMessageToPC(oPC, "Your racial heritage aids you in whatever you are trying to do.");
		nDC = nDC - nRacialBonus;
	}
	
	// apply item bonus if applicable
	object oItem = GetItemPossessedBy(oPC, sItem);
	if (oItem != OBJECT_INVALID) {
	SendMessageToPC(oPC, "You possess an item which aids you in whatever you are trying to do.");
		adjustedDC = adjustedDC - nItemBonus;	
	}
	
	// do skill check

	if (GetIsSkillSuccessful(oPC, nSkillVal, adjustedDC) == TRUE)
	{
		SendMessageToPC(oPC, "You were successful in whatever you are trying to do.");
		return TRUE;
	}
	else
	{
		SendMessageToPC(oPC, "You failed in whatever you are trying to do.");
		return FALSE;
	}
}