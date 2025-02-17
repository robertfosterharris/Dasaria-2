#include "std_i0_misc"
#include "nw_i0_plot"
#include "std_faction_i0"
#include "std_i0_markofdeath"
#include "death_i0_respawn"
#include "ginc_das_jail"
#include "dasolm_inc"
#include "std_inc_mounts"

void useBandage(object oPC, object oTarget);

void main()
{
	object oPC;
	object oTarget;
	
	oPC = GetItemActivator();
	oTarget = GetItemActivatedTarget();

	SendMessageToPC(oPC, "You apply pressure to " + GetName(oTarget) + "'s wounds to stop the bleeding.");
	useBandage(oPC, oTarget);
}

void useBandage(object oPC, object oTarget)
{
	if (GetCurrentHitPoints(oTarget) < 1 && GetCurrentHitPoints(oTarget) > -10)
	{
		ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectHeal(1), oTarget);
		DelayCommand(6.0, useBandage(oPC, oTarget));
	}
	
	if(GetCurrentHitPoints(oTarget) < -10 && !GetIsInCombat(oPC))
	{
		if(GetIsStaff(oPC))
		{
			SendMessageToPC(oPC, "Staff Bandage Test");
		}

		MountedPCCleanUp(oTarget);
		std_death_mark_remove(oTarget);
		SetLocalInt(oTarget, "bNoGoldLoss", 1);
		ApplyPenalty(oTarget);
	    ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectResurrection(),oTarget);
		RemoveEffects(oTarget);
	}
}