/*

wired 2/21/15

Trip

You can try to trip an opponent as an unarmed melee attack. You can only trip an opponent
who is one size category larger than you, the same size, or smaller.

Making a Trip Attack

Make an unarmed melee touch attack against your target. This provokes an attack of opportunity
from your target as normal for unarmed attacks.

If your attack succeeds, make a Strength check opposed by the defender’s Dexterity or Strength
check (whichever ability score has the higher modifier). A combatant gets a +4 bonus for every
size category he is larger than Medium or a -4 penalty for every size category he is smaller than
Medium. 

The defender gets a +4 bonus on his check if he has more than two legs or is otherwise more
stable than a normal humanoid. If you win, you trip the defender. If you lose, the defender may
immediately react and make a Strength check opposed by your Dexterity or Strength check to try to
trip you.

Avoiding Attacks of Opportunity

If you have the Improved Trip feat, or if you are tripping with a weapon (see below), you don’t provoke
an attack of opportunity for making a trip attack.

Being Tripped (Prone)

A tripped character is prone. Standing up is a move action.

Tripping a Mounted Opponent

You may make a trip attack against a mounted opponent. The defender may make a Ride check in place
of his Dexterity or Strength check. If you succeed, you pull the rider from his mount.

Tripping with a Weapon

Some weapons can be used to make trip attacks. In this case, you make a melee touch attack with the
weapon instead of an unarmed melee touch attack, and you don’t provoke an attack of opportunity.

If you are tripped during your own trip attempt, you can drop the weapon to avoid being tripped. 

*/

#include "X0_I0_SPELLS"
#include "x2_inc_spellhook" 
#include "std_inc_mounts"

void main()
{

	//object oCaster = OBJECT_SELF;
	//object oTarget = GetSpellTargetObject();
	
	object oCaster = GetItemActivator();
	object oTarget = GetItemActivatedTarget();
	
	
	if (!GetIsObjectValid(oTarget)) 
	{
		SendMessageToPC(oCaster,"Target not valid.");
		return;
	}
	
	int nCasterSize = GetCreatureSize(oCaster);
	int nTargetSize = GetCreatureSize(oTarget);
	int nSizeDiff = nCasterSize - nTargetSize;
	
	effect eTrip = EffectKnockdown();
	
	// check size
	if (nSizeDiff < -1)
	{
		FloatingTextStringOnCreature("Cannot trip an opponent more than one size larger than yourself.",oCaster,TRUE);
	}
	
	// figure bonus	
	int nBonus = nSizeDiff * 4;
	
	// make a touch attack
	int nTouch = TouchAttackRanged(oTarget);
	if (nTouch > 0)
	{
	
		// other wisee roll vs strength		
		int nTargetDEXMod = GetAbilityModifier(ABILITY_DEXTERITY,oTarget);
		int nTargetSTRMod = GetAbilityModifier(ABILITY_STRENGTH,oTarget);
		
		int nCheck = nTargetDEXMod;
		
		if (nTargetSTRMod > nTargetDEXMod)
		{
			nCheck = nTargetSTRMod;
		}		
		
		// special case for mounted opponent		
		if (GetIsMounted(oTarget))
		{
			if (GetAbilityModifier(28,oTarget) > nCheck)
			{
				nCheck = GetAbilityModifier(28,oTarget);
			}
			
			nBonus = nBonus - 4;
		}
		
		if (d20() + GetAbilityModifier(ABILITY_STRENGTH,oCaster) + nBonus >=  d20() + nCheck )
        {
			// special case for mounted opponent		
			if (GetIsMounted(oTarget))
			{
				ActionDismount(oTarget);
			}
		
		 	// Apply effects to the currently selected target.
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eTrip, oTarget, 6.0);
		}
	}
}