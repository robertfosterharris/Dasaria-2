//	ON RESTED - ISMAY BUFFS HIMSELF
//
//	10/03/2012	ROBERT HARRIS	ROBERTHARRIS@ROBERTHARRIS.COM
//
#include "ginc_debug"

void main()
{
	object oPC = GetLastPCRested();
	int nType = GetLastRestEventType();
	float fRound = 0.0;
	
	DelayCommand(fRound += 6.0, ActionSpeakString("Allow me a moment to prepare myself."));
	DelayCommand(fRound += 1.0, ActionCastSpellAtObject(SPELL_LIGHT, OBJECT_SELF, METAMAGIC_NONE, TRUE));
	DelayCommand(fRound += 1.0, ActionCastSpellAtObject(SPELL_STONESKIN, OBJECT_SELF, METAMAGIC_NONE, TRUE));
	DelayCommand(fRound += 1.0, ActionCastSpellAtObject(SPELL_IMPROVED_MAGE_ARMOR, OBJECT_SELF, METAMAGIC_NONE, TRUE));
	DelayCommand(fRound += 1.0, ActionCastSpellAtObject(SPELL_SHIELD, OBJECT_SELF, METAMAGIC_NONE, TRUE));
	DelayCommand(fRound += 1.0, ActionSpeakString("I am ready."));
}