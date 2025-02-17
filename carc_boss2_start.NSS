//Boss fight #2!
//This is a no brainer, simply fight the dragon.
//However, the rays zap random location around the arena that may invoke damage
//Additionally, every 10 rounds the dragon will return to the center and explode in one
//big sonic boom PCs will want to avoid. He will also heal some of his HP this way.
//-frac
#include "NW_I0_SPELLS"
//Const objects
//////////////////////////////////////////////////////////
object oSource1=GetObjectByTag("carc_abelis_oblsk_src01");
object oSource2=GetObjectByTag("carc_abelis_oblsk_src02");
object oSource3=GetObjectByTag("carc_abelis_oblsk_src03");
object oSource4=GetObjectByTag("carc_abelis_oblsk_src04");
object oSource5=GetObjectByTag("carc_abelis_oblsk_src05");
object oPoint1=GetObjectByTag("carc_abelis_oblsk_pnt01");
object oPoint2=GetObjectByTag("carc_abelis_oblsk_pnt02");
object oPoint3=GetObjectByTag("carc_abelis_oblsk_pnt03");
object oPoint4=GetObjectByTag("carc_abelis_oblsk_pnt04");
object oPoint5=GetObjectByTag("carc_abelis_oblsk_pnt05");
object oPoint6=GetObjectByTag("carc_abelis_oblsk_pnt06");
object oPoint7=GetObjectByTag("carc_abelis_oblsk_pnt07");
object oPoint8=GetObjectByTag("carc_abelis_oblsk_pnt08");
//////////////////////////////////////////////////////////
//ray functions
void FiveRays();
void FourRays();
void TwoRays();
void OneRay();
void Blast(float fRadius, object oLander, int nDmgType, string sRay);
//////////////////////////////////////////////////////////
int nDmgType; string sRay; object oLander; string sBoom;
//////////////////////////////////////////////////////////
void SpawnBoss(object oPoint1)
{ 
object oXal = CreateObject(OBJECT_TYPE_CREATURE,"carcerum_xalathros",GetLocation(oPoint1)); 
ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectCutsceneImmobilize(),oXal, 3.0);
DelayCommand(1.0,AssignCommand(oXal,ActionSpeakString("<color=#E0B855><b>MY LORD! YOU HAVE RE- ...")));
DelayCommand(2.0,AssignCommand(oXal,ActionSpeakString("<color=#E0B855><b>WHO ARE YOU? WHAT IS THIS?! INTERLOPERS! I WILL OBLITERATE EACH AND EVERY ONE OF YOU!")));
DelayCommand(13.0,AssignCommand(oXal,ActionSpeakString("<color=#E0B855><b>YOU MEDDLE WITH FORCES YOU CANNOT COMPREHEND, MORTALS!")));
}
//////////////////////////////////////////////////////////
void SpawnImp()
{
CreateObject(OBJECT_TYPE_CREATURE,"c_imp",GetLocation(GetWaypointByTag("carc_abelis_impspawn01"))); 
CreateObject(OBJECT_TYPE_CREATURE,"c_imp",GetLocation(GetWaypointByTag("carc_abelis_impspawn02"))); 
CreateObject(OBJECT_TYPE_CREATURE,"c_imp",GetLocation(GetWaypointByTag("carc_abelis_impspawn03"))); 
CreateObject(OBJECT_TYPE_CREATURE,"c_imp",GetLocation(GetWaypointByTag("carc_abelis_impspawn04"))); 
}
//////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////

void main()
{
object oPC = GetEnteringObject();
if (!GetIsPC(oPC)) return;
if (GetLocalInt(OBJECT_SELF,"DONE")) return;
SetLocalInt(OBJECT_SELF,"DONE",1);
FiveRays();

DelayCommand(18.0,OneRay());
DelayCommand(24.0,TwoRays());
DelayCommand(41.9,FourRays());

}

void FiveRays()
{
//Begin:
ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectNWN2SpecialEffectFile("sp_beshadowed_ray",oPoint1),oSource1,RoundsToSeconds(2));
ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectNWN2SpecialEffectFile("sp_darkness_ray",oPoint1),oSource2,RoundsToSeconds(2));
ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectNWN2SpecialEffectFile("sp_beshadowed_ray",oPoint1),oSource3,RoundsToSeconds(2));
ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectNWN2SpecialEffectFile("sp_beshadowed_ray",oPoint1),oSource4,RoundsToSeconds(2));
ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectNWN2SpecialEffectFile("sp_darkness_ray",oPoint1),oSource5,RoundsToSeconds(2));
//11.0:
DelayCommand(11.0,ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectNWN2SpecialEffectFile("sp_shades_summon"),oPoint1));
DelayCommand(11.5,ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectNWN2SpecialEffectFile("sp_beshadowed_doom"),oPoint1));
DelayCommand(12.25,SpawnBoss(oPoint1));

MusicBattleChange(GetArea(oPoint1),72);
DelayCommand(0.5,MusicBattlePlay(GetArea(oPoint1)));

}


void FourRays()
{
if (GetLocalInt(oSource1,"BOSS_DEAD")) return;
SetLocalInt(oSource1,"FourRays",1);
oLander = oPoint1;
nDmgType=DAMAGE_TYPE_SONIC;
sBoom = "sp_sonic_aoe_2";
string sBoom2 = "sp_shades_tgt_aoe";

ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectNWN2SpecialEffectFile("sp_beshadowed_ray",oLander),oSource2,RoundsToSeconds(2));
ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectNWN2SpecialEffectFile("sp_brimstone_ray",oLander),oSource3,RoundsToSeconds(2));
ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectNWN2SpecialEffectFile("sp_conjuration_ray",oLander),oSource4,RoundsToSeconds(2));
ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectNWN2SpecialEffectFile("sp_magic_ray",oLander),oSource5,RoundsToSeconds(2));

object oXalath = GetObjectByTag("carcerum_xalathros");
if (GetIsObjectValid(oXalath))
{

int nHP = GetCurrentHitPoints(oXalath); int nMaxHP = GetMaxHitPoints(oXalath);
nHP = nMaxHP-nHP; 
//replenish spells but not hp
//DelayCommand(0.5, ForceRest(oXalath));
//DelayCommand(0.51,ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectDamage(nHP,DAMAGE_TYPE_MAGICAL,DAMAGE_POWER_ENERGY,TRUE),oXalath));

ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectNWN2SpecialEffectFile("sp_shades_summon"),GetLocation(oXalath));
DelayCommand(0.5,ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectNWN2SpecialEffectFile("sp_beshadowed_doom"),oPoint1));

AssignCommand(oXalath,ClearAllActions());
ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectCutsceneImmobilize(),oXalath, RoundsToSeconds(2)-0.5);
DelayCommand(0.1,AssignCommand(oXalath,ActionJumpToLocation(GetLocation(oPoint1))));
ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectRegenerate(50+Random(21),6.0),oXalath, RoundsToSeconds(2));
DelayCommand(0.2,AssignCommand(oXalath,ActionPlayAnimation(ANIMATION_FIREFORGET_TAUNT)));
}

DelayCommand(RoundsToSeconds(2)+0.1, ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectNWN2SpecialEffectFile(sBoom),oLander));
DelayCommand(RoundsToSeconds(2)+0.1, ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectNWN2SpecialEffectFile(sBoom2),oLander));
DelayCommand(RoundsToSeconds(2)+0.5,Blast(12.5,oLander,nDmgType,sRay));
DelayCommand(RoundsToSeconds(2)+1.0,SpawnImp());
DelayCommand(RoundsToSeconds(2)-0.5,DeleteLocalInt(oSource1,"FourRays"));
DelayCommand(RoundsToSeconds(10),FourRays());

}
void TwoRays()
{
if (GetLocalInt(oSource1,"BOSS_DEAD")) return;
if (!GetLocalInt(oSource1,"FourRays"))//no 4-ray in progress, shoot.
{
SetLocalInt(oSource1,"TwoRays",1);
nDmgType = d8(1);
if (nDmgType == 1) { nDmgType = DAMAGE_TYPE_COLD; sRay="sp_ice_ray"; sBoom="sp_ice_aoe";}
if (nDmgType == 2) { nDmgType = DAMAGE_TYPE_FIRE; sRay="sp_brimstone_ray";sBoom="sp_fire_aoe";}
if (nDmgType == 3) { nDmgType = DAMAGE_TYPE_ACID; sRay="sp_acid_ray";sBoom="sp_acid_aoe";}
if (nDmgType == 4) { nDmgType = DAMAGE_TYPE_ELECTRICAL; sRay="sp_lightning_ray";sBoom="sp_lightning_aoe";}
if (nDmgType == 5) { nDmgType = DAMAGE_TYPE_POSITIVE; sRay="sp_conjuration_ray";sBoom="fx_magical_explosion";}
if (nDmgType == 6) { nDmgType = DAMAGE_TYPE_NEGATIVE; sRay="sp_beshadowed_ray";sBoom="fx_kos_teleport_small";}
if (nDmgType == 7) { nDmgType = DAMAGE_TYPE_MAGICAL; sRay="sp_magic_ray";sBoom="fx_magical_explosion";}
if (nDmgType == 8) { nDmgType = 10987; sRay="sp_prismatic_ray";sBoom="sp_illusion_aoe";}//CONFUSION

int nShooter1 = d3(1)+1; int nShooter2 = nShooter1+1;
string sShooter1 = "carc_abelis_oblsk_src0"+IntToString(nShooter1); 
string sShooter2 = "carc_abelis_oblsk_src0"+IntToString(nShooter2);

int nLander;
if (nShooter1 == 2) { nLander =  d3(1)+1; }
if (nShooter1 == 3) { nLander =  d3(1)+3; }
if (nShooter1 == 4) { nLander =  d3(1)+5; }
oLander = GetObjectByTag("carc_abelis_oblsk_pnt0"+IntToString(nLander));
ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectNWN2SpecialEffectFile(sRay,oLander),GetObjectByTag(sShooter1),5.0);
ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectNWN2SpecialEffectFile(sRay,oLander),GetObjectByTag(sShooter2),5.0);
DelayCommand(5.1, ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectNWN2SpecialEffectFile(sBoom),oLander));
DelayCommand(5.5,Blast(9.0,oLander,nDmgType,sRay));
DelayCommand(5.45,DeleteLocalInt(oSource1,"TwoRays"));
}
DelayCommand(RoundsToSeconds(4),TwoRays());
}

void OneRay()
{
if (GetLocalInt(oSource1,"BOSS_DEAD")) return;
if (!GetLocalInt(oSource1,"FourRays"))//no 4-ray in progress, shoot.
{
if (!GetLocalInt(oSource1,"TwoRays"))//no2-ray in progress either
{
/*
sp_ice_ray - FROST DAMAGE
sp_prismatic_ray - MAGICAL DAMAGE
sp_acid_ray- ACID DAMAGE
sp_beshadowed_ray - NEGATIVE DAMAGE
sp_brimstone_ray - FIRE DAMAGE
sp_conjuration_ray (green) - POSITIVE DAMAGE
sp_lightning_ray - LIGHTNING DAMAGE
sp_magic_ray - CONFUSION
*/
nDmgType = d6(1);
if (nDmgType == 1) { nDmgType = DAMAGE_TYPE_COLD; sRay="sp_ice_ray"; sBoom="sp_ice_aoe";}
if (nDmgType == 2) { nDmgType = DAMAGE_TYPE_FIRE; sRay="sp_brimstone_ray";sBoom="sp_fire_aoe";}
if (nDmgType == 3) { nDmgType = DAMAGE_TYPE_ACID; sRay="sp_acid_ray";sBoom="sp_acid_aoe";}
if (nDmgType == 4) { nDmgType = DAMAGE_TYPE_ELECTRICAL; sRay="sp_lightning_ray";sBoom="sp_lightning_aoe";}
if (nDmgType == 5) { nDmgType = DAMAGE_TYPE_POSITIVE; sRay="sp_conjuration_ray";sBoom="fx_magical_explosion";}
if (nDmgType == 6) { nDmgType = DAMAGE_TYPE_NEGATIVE; sRay="sp_beshadowed_ray";sBoom="fx_kos_teleport_small";}

int nShooter = d4(1)+1; string sShooter = "carc_abelis_oblsk_src0"+IntToString(nShooter); int nLander;
if (nShooter == 2) { nLander =  d2(1)+1; }
if (nShooter == 3) { nLander =  d3(1)+2; }
if (nShooter == 4) { nLander =  d3(1)+4; }
if (nShooter == 5) { nLander =  d2(1)+6; }
oLander = GetObjectByTag("carc_abelis_oblsk_pnt0"+IntToString(nLander));

ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectNWN2SpecialEffectFile(sRay,oLander),GetObjectByTag(sShooter),3.0);
DelayCommand(3.1, ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectNWN2SpecialEffectFile(sBoom),oLander));
DelayCommand(3.5,Blast(6.5,oLander,nDmgType,sRay));
}
}
DelayCommand(RoundsToSeconds(1),OneRay());
}

void Blast(float fRadius, object oLander, int nDmgType, string sRay)
{


if (nDmgType == 10987) //confusion!
{
effect eConfuse = EffectLinkEffects(EffectNWN2SpecialEffectFile("fx_confusion"), EffectConfused());
object oTarget = GetFirstObjectInShape(SHAPE_SPHERE,fRadius,GetLocation(oLander),FALSE,OBJECT_TYPE_CREATURE);
while (GetIsObjectValid(oTarget))
{
if (GetTag(oTarget) != "carcerum_xalathros")
{
	if (!MySavingThrow(SAVING_THROW_WILL, oTarget, 30, SAVING_THROW_TYPE_MIND_SPELLS))
	{
	ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eConfuse, oTarget, RoundsToSeconds(10));
	}
oTarget = GetNextObjectInShape(SHAPE_SPHERE,fRadius,GetLocation(oLander),FALSE,OBJECT_TYPE_CREATURE);
}
}
}
else //normal damage
{
if (sRay == "sp_ice_ray") sRay = "sp_ice_hit";
if (sRay == "sp_brimstone_ray") sRay = "sp_fire_hit";
if (sRay == "sp_acid_ray") sRay = "sp_acid_hit";
if (sRay == "sp_lightning_ray") sRay = "sp_lightning_hit";
if (sRay == "sp_conjuration_ray") sRay = "sp_holy_hit";
if (sRay == "sp_beshadowed_ray") sRay = "sp_beshadowed_hit";
if (nDmgType == DAMAGE_TYPE_SONIC) { sRay="sp_sonic_hit"; }

effect eVis = EffectNWN2SpecialEffectFile(sRay);

int nDamage;
if (fRadius == 6.5)//small explosion means small damage!
{ nDamage = d6(6)+10; }

if (fRadius == 9.0)
{ nDamage = d6(12)+15; }

if (fRadius > 9.0) { nDamage = d10(12)+30; }

effect eDam = EffectDamage(nDamage, nDmgType);

object oTarget = GetFirstObjectInShape(SHAPE_SPHERE,fRadius,GetLocation(oLander),FALSE,OBJECT_TYPE_CREATURE);

while (GetIsObjectValid(oTarget))
{
if (GetTag(oTarget) != "carcerum_xalathros")
{
float fDelay = GetDistanceBetweenLocations(GetLocation(oLander), GetLocation(oTarget))/20;
DelayCommand(fDelay,ApplyEffectToObject(DURATION_TYPE_INSTANT, eDam, oTarget));
DelayCommand(fDelay,ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget));
oTarget = GetNextObjectInShape(SHAPE_SPHERE,fRadius,GetLocation(oLander),FALSE,OBJECT_TYPE_CREATURE);
}
}

}//end else
}//end void