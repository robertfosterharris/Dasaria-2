void RonPotionEffects(object oPC)
{
effect eACPlus;
effect eDexMinus;
effect eVisual_1;
effect eVisual_2;

eACPlus = EffectACIncrease(4, AC_NATURAL_BONUS, AC_VS_DAMAGE_TYPE_ALL);
eDexMinus = EffectAbilityDecrease(ABILITY_DEXTERITY, 2);
eVisual_1 = EffectVisualEffect(VFX_DUR_BLAZING_AURA);
eVisual_2 = EffectVisualEffect(VFX_DUR_SPELL_SPIDERSKIN);
ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eACPlus,oPC,900.00);
ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eDexMinus,oPC,900.00);
ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eVisual_1,oPC,5.00);
ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eVisual_2,oPC,900.00);
}


void main()
{
object oPC = GetItemActivator();

effect eEffect = GetFirstEffect(oPC);

int iACPlus = FALSE;
int DexMinus = FALSE;
int iEffectType;

AssignCommand(oPC, ClearAllActions());
AssignCommand(oPC,ActionPlayAnimation(ANIMATION_FIREFORGET_DRINK,1.0));

while(GetIsEffectValid(eEffect))
{
int iEffectType = GetEffectType(eEffect);
if(iEffectType == EFFECT_TYPE_AC_INCREASE )
iACPlus = TRUE;
else if(iEffectType == EFFECT_TYPE_ABILITY_DECREASE)
DexMinus = TRUE;
eEffect = GetNextEffect(GetFirstPC());
}

if ( iACPlus ==TRUE && DexMinus == TRUE) return;

//apply effects here 

DelayCommand(5.0,RonPotionEffects(oPC));

SendMessageToPC(oPC, "As you swallow the thick liquid, you feel a wave of heat surge through your body. You feel the sensation of bugs crawling on your skin as it hardens.");

} 