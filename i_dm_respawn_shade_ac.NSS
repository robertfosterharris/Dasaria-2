//	ON ACTIVATE - RAISE DEAD PLAYER WITH PENALTIES PER DM SHADE'S PREFERENCES
//
//	07/02/2008	ROBERT HARRIS	ROBERTHARRIS@ROBERTHARRIS.COM

#include "nw_i0_plot"
#include "std_faction_i0"
#include "std_i0_markofdeath"

void main()
{
	effect eEffect;
	object oPC;

	oPC = GetFirstPC();
	while (GetIsObjectValid(oPC))
	{
		if (GetIsDead(oPC) && GetDistanceToObject(oPC) < 10.0)
		{
			std_death_mark_remove(oPC);
			std_reputation_reset(oPC, "cearguard");
			SetXP(oPC, GetXP(oPC) - (GetHitDice(oPC) * 50));
	
			RemoveEffects(oPC);
		
			eEffect = EffectCurse(2, 2, 2, 2, 2, 2);
			eEffect = SupernaturalEffect(eEffect);
			ApplyEffectToObject(DURATION_TYPE_PERMANENT, eEffect, oPC);

			eEffect = EffectResurrection();
    		ApplyEffectToObject(DURATION_TYPE_INSTANT, eEffect, oPC);
		}
		oPC = GetNextPC();
	}
}