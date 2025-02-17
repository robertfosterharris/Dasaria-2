//	GLOBAL ON TRIGGER SCRIPT - CASTS SPELL ON TRAP TRIGGER
//
//	ROBERT HARRIS	ROBERTHARRIS@ROBERTHARRIS.COM	11/19/07
//
#include "x0_i0_stringlib"

void main()
{
	int nCasterLevel;
	int nProjectilePath;	
	int nSpell;
	int nType;
	int nTokens;
	int nRandom;
	object oTrapOrigin;
	object oPC;

	nTokens = GetNumberTokens(GetLocalString(OBJECT_SELF, "SpellList"), ",");
	nRandom = Random(nTokens);
	nSpell = StringToInt(GetTokenByPosition(GetLocalString(OBJECT_SELF, "SpellList"), ",", nRandom));
	nCasterLevel = GetLocalInt(OBJECT_SELF, "CasterLevel");
	nType = GetObjectType(OBJECT_SELF);
	oPC = GetEnteringObject();

	switch (nSpell)
	{
		case 487:	//SPELL_TRAP_ARROW
		case 488:	//SPELL_TRAP_BOLT
		case 493:	//SPELL_TRAP_DART
		case 494:	//SPELL_TRAP_SHURIKEN
			nProjectilePath = PROJECTILE_PATH_TYPE_HOMING;
			break;
		default:
			nProjectilePath = PROJECTILE_PATH_TYPE_DEFAULT;
			break;
	} 
	
	if (nType == OBJECT_TYPE_TRIGGER || nType == OBJECT_TYPE_DOOR)
	{
		oTrapOrigin = GetLocalObject(OBJECT_SELF, "TrapOrigin");
	}
	else
	{
		oTrapOrigin = OBJECT_SELF;
	}
	AssignCommand(oTrapOrigin, ActionCastSpellAtObject(nSpell, oPC, METAMAGIC_ANY, TRUE, nCasterLevel, nProjectilePath, TRUE));
}