// //i_rw_portkey_conv
//Used for in game teleporting of NPCs

void main(string sEffectPackage)
{

object oPC      = GetPCSpeaker();
object oItem    = GetLocalObject(oPC,"PortKey");
int iVFXDisappear1;
int iVFXDisappear2;
int iVFXAppear1;
int iVFXAppear2;

SetLocalInt(oItem,"iVFXDisappear1",0);
SetLocalInt(oItem,"iVFXDisappear2",0);
SetLocalInt(oItem,"iVFXAppear1",0);
SetLocalInt(oItem,"iVFXAppear2",0);

if(sEffectPackage == "JiLyn")
{
iVFXDisappear1 = VFX_FNF_IMPLOSION;
iVFXAppear1 = VFX_FNF_SUMMON_MONSTER_1;
iVFXAppear2 = VFX_IMP_FLAME_M;
}
if(sEffectPackage == "Hellfire")
{
iVFXDisappear1 =VFX_FNF_GAS_EXPLOSION_EVIL;
iVFXAppear1 = VFX_FNF_SUMMON_UNDEAD;
iVFXAppear2 = VFX_FNF_GAS_EXPLOSION_EVIL;
}
if(sEffectPackage == "Divine")
{
iVFXDisappear1 = VFX_FNF_STRIKE_HOLY;
iVFXAppear1 = VFX_FNF_SUMMON_CELESTIAL;
}

if(sEffectPackage == "Arcane")
{

iVFXDisappear1 =VFX_FNF_ELECTRIC_EXPLOSION;
iVFXDisappear2 =VFX_FNF_SUMMON_MONSTER_1;
iVFXAppear1 = VFX_FNF_ELECTRIC_EXPLOSION;
iVFXAppear2 = VFX_FNF_SUMMON_MONSTER_1;
}

SetLocalInt(oItem,"iVFXDisappear1",iVFXDisappear1);
SetLocalInt(oItem,"iVFXDisappear2",iVFXDisappear2);
SetLocalInt(oItem,"iVFXAppear1",iVFXAppear1);
SetLocalInt(oItem,"iVFXAppear2",iVFXAppear2);

DeleteLocalObject(oPC,"PortKey");
   
}
/*

VFX_FEAT_TURN_UNDEAD 740
VFX_FNF_ELECTRIC_EXPLOSION 459
VFX_FNF_HOWL_MIND 278
VFX_FNF_HOWL_ODD 279
VFX_FNF_SOUND_BURST_SILENT 446
VFX_FNF_MYSTICAL_EXPLOSION 477
VFX_FNF_IMPLOSION 24
VFX_FNF_SUMMON_CELESTIAL 219
VFX_FNF_STRIKE_HOLY 184
VFX_FNF_SCREEN_SHAKE 286
VFX_FNF_SUMMON_EPIC_UNDEAD 496
VFX_FNF_SUMMON_GATE 32
VFX_FNF_SUMMON_MONSTER_1 33
VFX_FNF_SUMMON_UNDEAD 36
VFX_INVOCATION_FRIGHTFUL_CONE 788
VFX_INVOCATION_HELLRIME_DOOM 796
VFX_INVOCATION_HELLRIME_CONE 795
VFX_INVOCATION_UTTERDARK_DOOM 818