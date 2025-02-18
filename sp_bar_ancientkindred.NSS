/*
Ancient Kindred

Type of Feat: Heritage
Prerequisite: Baraanman Heritage. Character Level 12.
Specifics: The Baraanmen have an ancient accord with the Dwarves. Such is the trust that they have for your people that they have shared some of their secret defensive techniques.
When he needs to, the Baraanman can become a stalwart bastion of defense. In this defensive stance, a Baraanman gains phenomenal strength and durability but he cannot move from the spot he is defending. He gains the following benefits:
 +2 Strength
 +4 Constitution
 +2 resistance bonus on all saves
 +4 dodge bonus to AC
This ability can be used 1/day for every Baraanman heritage feat possessed.
 Use: Selected
		
on use create an invisable placable that uses an onheatbeat test to remove effects if PC moves!		
		
*/

#include "NW_I0_SPELLS"
#include "x2_inc_spellhook"

void main()
{
	object oPC = OBJECT_SELF;
    object oTarget = GetSpellTargetObject(); 
	object oHB_device;
	
	int iFeatUsed = GetSpellFeatId();
	int iSpellID = GetSpellId();
	int x;
	
	location lLocation;

    effect eSpellEffect_Str;
    effect eSpellEffect_Con;
    effect eSpellEffec_AC;
    effect eSpellEffect_ST;
    effect eSpellEffect;			

	if (!X2PreSpellCastCode())
    {
	// If code within the PreSpellCastHook (i.e. UMD) reports FALSE, do not run this spell
        return;
    }
	
    if (!GetHasSpellEffect(iSpellID, OBJECT_SELF)) // 201 = Protective Aura
	{
	
		lLocation = GetLocation(oPC);
		SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, iSpellID, FALSE));

		//Build effect
		eSpellEffect = SetEffectSpellId(eSpellEffect, iSpellID);
		eSpellEffect_Str = EffectAbilityIncrease(ABILITY_STRENGTH, 2);
		eSpellEffect_Con = EffectAbilityIncrease(ABILITY_CONSTITUTION, 4);
		eSpellEffec_AC = EffectACIncrease(4, AC_DODGE_BONUS);
		eSpellEffect_ST = EffectSavingThrowIncrease(SAVING_THROW_ALL,2);
		
		eSpellEffect = EffectLinkEffects(eSpellEffect, eSpellEffect_Str);
		eSpellEffect = EffectLinkEffects(eSpellEffect, eSpellEffect_Con);
		eSpellEffect = EffectLinkEffects(eSpellEffect, eSpellEffec_AC);
		eSpellEffect = EffectLinkEffects(eSpellEffect, eSpellEffect_ST);						
		
		
		oHB_device = CreateObject(OBJECT_TYPE_PLACEABLE, "bar_ancientlindred_hb", lLocation );
		
		ActionDoCommand(SetLocalString(oHB_device, "oCreator", GetName(oPC)+GetPCPlayerName(oPC))); 		
		ActionDoCommand(SetLocalLocation(oHB_device, "lCreatorLocation", lLocation));
		ApplyEffectToObject(DURATION_TYPE_PERMANENT, eSpellEffect, oPC);
 
				
	}
}