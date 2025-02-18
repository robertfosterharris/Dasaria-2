#include "std_wild_magic"

void main()
{
	int nSpell = GetLocalInt(OBJECT_SELF,"LASTSPELL");

	if (
		nSpell 	== 	SPELL_RESIST_ENERGY ||
		nSpell	== 	SPELL_ENERGY_IMMUNITY_COLD)
		//nSpell	== 	SPELL_SPELL_RESISTANCE ||
		//nSpell	==	SPELL_LEAST_SPELL_MANTLE ||
		//nSpell	==	SPELL_LESSER_SPELL_MANTLE ||
		//nSpell	==	SPELL_SPELL_MANTLE)
		{
			SendMessageToPC(OBJECT_SELF, "Spell Failed!");
			SetModuleOverrideSpellScriptFinished();
		}
		else
		{
			GenerateWildMagicEffect(OBJECT_SELF, nSpell);
		}
}