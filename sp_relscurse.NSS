#include "nw_i0_spells"


void main()
{
object oPC = OBJECT_SELF;
object oArea;
int iAreaIndoors;
int iIsItNight;
effect eRelsCurse;
effect eSkills = EffectSkillDecrease(SKILL_ALL_SKILLS , 1);
effect eCon = EffectCurse(0, 0, 1, 0, 0, 0);
effect eSaves = EffectSavingThrowDecrease(SAVING_THROW_ALL, 1);
effect eAttacks = EffectAttackDecrease(1);

//remove old effect here!!

oArea = GetArea(oPC);
iAreaIndoors = GetIsAreaInterior(oArea);
iIsItNight = GetIsNight(); //dawn - dusk apply penalty


SendMessageToPC(oPC,"<i>You feel a weight upon your soul as the curse of Rel, Lord of the Healing Dawn, decends upon you.</i>");

if(iAreaIndoors == FALSE && iIsItNight == FALSE)
{ 

	eRelsCurse = EffectEffectIcon(233);
	eRelsCurse = EffectLinkEffects(eRelsCurse ,  eSkills );
	//eRelsCurse = EffectLinkEffects(eRelsCurse , eCon );
	//eRelsCurse = EffectLinkEffects(eRelsCurse , eSaves );
	//eRelsCurse = EffectLinkEffects(eRelsCurse , eAttacks );
	
	eRelsCurse = ExtraordinaryEffect(eRelsCurse );
	ApplyEffectToObject(DURATION_TYPE_PERMANENT, eRelsCurse, oPC);
}
else{
	RemoveEffectsFromSpell(oPC , 1803 );

}

}