//::///////////////////////////////////////////////
//:: Storm of Vengeance: Heartbeat
//:: NW_S0_StormVenC.nss
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Creates an AOE that decimates the enemies of
    the cleric over a 30ft radius around the caster
	
    Reeron modified on 3-16-07
    Was using wrong duration for stun effect. Should be
    1 round, not 2 rounds, as per the in-game description.
    Lowered electrical damage to 3d6, on a failed save, 
    not the incorrect 6d6 that it was using. Will now 
    cancel the area of effect if the creator of the effect
    is dead. Applies random damage rolls to each target, 
    not one roll per round applied to every target.

    Reeron modified on 6-15-09
    Updated for patch 1.22.5588

*/
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: Nov 8, 2001
//:://////////////////////////////////////////////




#include "X0_I0_SPELLS"
#include "x2_inc_spellhook"

void main()
{

    //Declare major variables
    


    effect eStun = EffectStunned();
    effect eVisAcid = EffectVisualEffect(VFX_HIT_SPELL_ACID);
    effect eVisElec = EffectVisualEffect(VFX_HIT_SPELL_LIGHTNING);
	effect eDur = EffectVisualEffect( VFX_DUR_STUN );
	eStun = EffectLinkEffects( eStun, eDur );
	object oCreator = GetAreaOfEffectCreator();
	
    float fDelay;
	
    //Get first target in spell area
    object oTarget = GetFirstInPersistentObject(OBJECT_SELF,OBJECT_TYPE_CREATURE);
	if (!GetIsObjectValid(oCreator))
	{
	DestroyObject(OBJECT_SELF);
	return;
	}
    while(GetIsObjectValid(oTarget))
    {
        if (spellsIsTarget(oTarget, SPELL_TARGET_SELECTIVEHOSTILE, GetAreaOfEffectCreator()))
        {
            //Fire cast spell at event for the specified target
            SignalEvent(oTarget, EventSpellCastAt(GetAreaOfEffectCreator(), SPELL_STORM_OF_VENGEANCE));
            //Make an SR Check
            fDelay = GetRandomDelay(0.5, 2.0);
            if(MyResistSpell(GetAreaOfEffectCreator(), oTarget, fDelay) == 0)
            {



                //Make a saving throw check
				effect eAcid = EffectDamage(d6(3), DAMAGE_TYPE_ACID);
				effect eElec = EffectDamage(d6(3), DAMAGE_TYPE_ELECTRICAL);
                // * if the saving throw is made they still suffer acid damage.
                // * if they fail the saving throw, they suffer Electrical damage too
                if(MySavingThrow(SAVING_THROW_REFLEX, oTarget, GetSpellSaveDC(), SAVING_THROW_TYPE_ELECTRICITY, GetAreaOfEffectCreator(), fDelay))
                {

                    //Apply the VFX impact and effects
                    DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVisAcid, oTarget));
                    DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eAcid, oTarget));
                    if (d2()==1)
                    {
                        DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVisElec, oTarget));
                    }
                }
                else
                {
                    //Apply the VFX impact and effects
                    DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVisAcid, oTarget));
                    DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eAcid, oTarget));
                    //Apply the VFX impact and effects
                    DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVisElec, oTarget));
                    DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eElec, oTarget));
                    DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eStun, oTarget, RoundsToSeconds(1)));
                }
            }
         }
        //Get next target in spell area
        oTarget = GetNextInPersistentObject(OBJECT_SELF,OBJECT_TYPE_CREATURE);
    }
}