// gtr_plc_trap_enter
//

#include "X0_I0_POSITION"

void main()
{
	object oPC = GetEnteringObject();
	string sPlcTag = GetLocalString(OBJECT_SELF,"sPlcTag");
	int nDmg = GetLocalInt(OBJECT_SELF,"nDmg");

	object oTrap = GetNearestObjectByTag(sPlcTag);
	AssignCommand(oTrap,PlaySound("sfx_linger_blades.WAV"));
	AssignCommand(oTrap,PlayAnimation(ANIMATION_PLACEABLE_OPEN)); 
	PlayVoiceChat(VOICE_CHAT_PAIN1,oPC);
	ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectDamage(Random(nDmg),DAMAGE_TYPE_SLASHING,DAMAGE_POWER_NORMAL,TRUE),oPC);
	AssignCommand(oPC,JumpToLocation(GetBehindLocation(oPC)));
	ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectKnockdown(),oPC);
}