#include "X0_I0_POSITION"

void main()
{
	object oPC = GetEnteringObject();
	object oTrap = GetNearestObjectByTag("plc_mincer_trap");
	AssignCommand(oTrap,PlaySound("sfx_linger_blades.WAV"));
	AssignCommand(oTrap,PlayAnimation(ANIMATION_PLACEABLE_OPEN)); 
	PlayVoiceChat(VOICE_CHAT_PAIN1,oPC);
	ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectDamage(d20(2),DAMAGE_TYPE_SLASHING,DAMAGE_POWER_NORMAL,TRUE),oPC);
	AssignCommand(oPC,JumpToLocation(GetBehindLocation(oPC)));
	ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectKnockdown(),oPC);
}