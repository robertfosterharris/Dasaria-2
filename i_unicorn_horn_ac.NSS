//i_unicorn_horn_ac

#include "nwn2_inc_spells"

void main()
{
	object oPC = GetItemActivator();
	
	int bIsHealingSpell = TRUE;
	int nSpellID = SPELL_HEAL;
	HealHarmTarget(oPC, 9, nSpellID, bIsHealingSpell );
	
	SendMessageToPC(oPC,"Your body is healed, but somehow it leaves you feeling empty inside, like something magical has gone out of the world.");
	GiveXPToCreature(oPC,-250);
}