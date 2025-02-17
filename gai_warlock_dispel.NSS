// AI - 25% CHANCE THE WARLOCK WILL USE A DISPEL
//
//	05/30/2008	ROBERT HARRIS	ROBERTHARRIS@ROBERTHARRIS.COM
//
#include "nw_i0_generic"
	
void main()
{
	effect eEffect;
	object oCaster;
    object oEnemy;
	int bDispeled;
	int nDispel;
//
//	ACQUIRE A TARGET
//	
	oEnemy = GetCreatureOverrideAIScriptTarget();
    ClearCreatureOverrideAIScriptTarget();
	if (!GetIsObjectValid(oEnemy)) oEnemy = bkAcquireTarget();
//
//	DETERMINE MOST POWERFUL DISPEL
//		
	nDispel = 0;
	if (GetHasSpell(SPELL_I_DEVOUR_MAGIC)) nDispel = SPELL_I_DEVOUR_MAGIC;
	if (GetHasSpell(SPELL_I_VORACIOUS_DISPELLING)) nDispel = SPELL_GREATER_DISPELLING;
//
//	IF WE HAVE A VALID LIVING ENEMY AND A DeEffect SPELL
//	
	bDispeled = FALSE;
	if (GetIsObjectValid(oEnemy) && !GetIsDead(oEnemy) && nDispel > 0 && d100() <= 25)
	{
//
//	CHECK TO MAKE SURE THE ENEMY HAS EFFECTS TO DISPEL
//	
		eEffect = GetFirstEffect(oEnemy);
		while(GetIsEffectValid(eEffect) && !bDispeled)
		{
//
//	MAKE SURE THE EFFECT WAS CAST BY AN ALLY WHICH MEANS IT IS MOST LIKELY A BUFF
//
			oCaster = GetEffectCreator(eEffect);
			if (GetReputation(oCaster, oEnemy) > 10)
			{
				__TurnCombatRoundOn(TRUE);
				ActionCastSpellAtObject(nDispel, oEnemy, METAMAGIC_ANY);	
				__TurnCombatRoundOn(FALSE);
				bDispeled = TRUE;
			}
			eEffect = GetNextEffect(oEnemy);
		}
	}
//
//	IF WE CAST THE DISPEL TELL THE DEFAULT AI THAT WE HANDLED THE ROUND
//	
if (bDispeled) SetCreatureOverrideAIScriptFinished();
}