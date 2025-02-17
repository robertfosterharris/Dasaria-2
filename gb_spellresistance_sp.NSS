//	ONSPAWN SCRIPT 	APPLIES SUPER-NATURAL SPELL RESISTANCE TO THE CREATURE
//					SINCE ITEMS, LIKE SKINS, WITH SPELL RESISTANCE DO NOT WORK
//
//	OBJECT VARIABLES
//	int SpawnScript 		- THE NAME OF THIS SCRIPT (CALLED FROM NW_C2_DEFAULT9)
//	int iSpellResistance	- THE AMOUNT OF SPELL RESISTANCE
//	
//	11/16/2009		ROBERT HARRIS		ROBERTHARRIS@ROBERTHARRIS.COM

#include "x2_inc_switches"

void main()
{
	effect eSpellResistance;
	int iSpellResistance;

	iSpellResistance = GetLocalInt(OBJECT_SELF, "iSpellResistance");
	eSpellResistance = SupernaturalEffect(EffectSpellResistanceIncrease(iSpellResistance, -1));
	ApplyEffectToObject(DURATION_TYPE_PERMANENT, eSpellResistance, OBJECT_SELF);
}