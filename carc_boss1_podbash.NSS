//Boss fight #1!
//PCs must destroy all three red pods to make the boss monster vulnerable.
//Destroying a blue pod will regenerate a red pod
//if no red pods have been destroyed and a blue pod has been destroyed,
//the PC takes a faceful of mixed energy damage.
//-frac

void PlotOrbs()
{
object oOrb = GetObjectByTag("carc_mrlochorb_1red");
SetPlotFlag(oOrb,TRUE);
oOrb = GetObjectByTag("carc_mrlochorb_2red");
SetPlotFlag(oOrb,TRUE);
oOrb = GetObjectByTag("carc_mrlochorb_3red");
SetPlotFlag(oOrb,TRUE);
oOrb = GetObjectByTag("carc_mrlochorb_1blu");
SetPlotFlag(oOrb,TRUE);
oOrb = GetObjectByTag("carc_mrlochorb_2blu");
SetPlotFlag(oOrb,TRUE);
oOrb = GetObjectByTag("carc_mrlochorb_3blu");
SetPlotFlag(oOrb,TRUE);
}

void KillEveryone(object oBoss)
{
object oTarget=GetFirstObjectInShape(SHAPE_SPHERE,500.0,GetLocation(oBoss),
FALSE,OBJECT_TYPE_CREATURE);
while (GetIsObjectValid(oTarget))
{

		if ((GetTag(oTarget) == "carcerum_lochtus01") ||
		(GetTag(oTarget) == "carcerum_druagoth01"))
		{ SetImmortal(oTarget,FALSE);
		ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectDeath(FALSE,TRUE,TRUE,TRUE),oTarget); }
oTarget=GetNextObjectInShape(SHAPE_SPHERE,500.0,GetLocation(oBoss),FALSE,OBJECT_TYPE_CREATURE);
}

PlotOrbs();
CreateObject(OBJECT_TYPE_ITEM,"carc_key_abelis",GetLocation(oBoss));
}
void RemoveCutsceneInvisibility(object oObject)
{
    effect eEffect = GetFirstEffect(oObject);
    while(GetIsEffectValid(eEffect))
    {
        if(GetEffectType(eEffect) == EFFECT_TYPE_VISUALEFFECT
        && GetEffectInteger(eEffect, 0) == VFX_DUR_CUTSCENE_INVISIBILITY)
        {
            RemoveEffect(oObject, eEffect);
        }
        eEffect = GetNextEffect(oObject);
    }

}

void MyShoutDisturbed(object oAttacker) {
  if (GetLocalInt(OBJECT_SELF,"DamageTaken") > 0)
    {
        object oTarget = GetFirstObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_COLOSSAL, GetLocation(OBJECT_SELF), FALSE, OBJECT_TYPE_CREATURE);
        //Cycle through the targets within the spell shape until an invalid object is captured.
        while (GetIsObjectValid(oTarget))
        {
           if (GetFactionEqual(oTarget, OBJECT_SELF) == TRUE)
           {
        // * Make anyone who is a member of my faction hostile if I am violated
             SetIsTemporaryEnemy(oAttacker,oTarget,TRUE,60.0);
             AssignCommand(oTarget, ActionAttack(oAttacker));
           }
           oTarget = GetNextObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_COLOSSAL, GetLocation(OBJECT_SELF), FALSE, OBJECT_TYPE_CREATURE);
        }
    }
}

void Penalty(object oRed,int nTotal,object oPC)
{
//SendMessageToPC(oPC,"Total is "+IntToString(nTotal));
	DeleteLocalInt(oRed,"Destroyed");
	RemoveCutsceneInvisibility(oRed);
	string sWhich = GetLocalString(oRed,"Num");
ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectNWN2SpecialEffectFile("fx_kos_beam"),GetLocation(oRed));
ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectNWN2SpecialEffectFile("sp_shades_summon"),GetLocation(oRed));
	CreateObject(OBJECT_TYPE_PLACED_EFFECT,"carc_mrlochorb_red_glow",GetLocation(GetWaypointByTag("podvfx_"+sWhich+"red0"+sWhich)),FALSE,"carc_mrlochorb_"+sWhich+"red_glow");
	CreateObject(OBJECT_TYPE_LIGHT,"carc_mrlochorb_red_light",GetLocation(GetWaypointByTag("podlight_"+sWhich+"red0"+sWhich)),FALSE,"carc_mrlochorb_"+sWhich+"red_light");
	nTotal = nTotal-1;
	SetLocalInt(GetObjectByTag("carcerum_bossguardian01"),"total",nTotal);
	return;
}

void DestroyOrb(object oOrb,object oPC)
{
string sColor = GetStringRight(GetTag(oOrb),3);
object oBoss = GetObjectByTag("carcerum_bossguardian01");
object oFlash2 = GetObjectByTag(GetTag(oOrb)+"_light");
object oFlash = GetObjectByTag(GetTag(oOrb)+"_glow");

ApplyEffectToObject(DURATION_TYPE_PERMANENT,EffectVisualEffect(355),oOrb);
ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectNWN2SpecialEffectFile("fx_magical_explosion"),GetLocation(oFlash));

DelayCommand(1.0,DestroyObject(oFlash));
DelayCommand(1.0,DestroyObject(oFlash2));

int nTotal = GetLocalInt(GetObjectByTag("carcerum_bossguardian01"),"total");

//boss isnt even around!
if (!GetIsObjectValid(oBoss))
{
effect eDam=EffectDamage(d10(2)+10,DAMAGE_TYPE_POSITIVE,DAMAGE_POWER_ENERGY);
effect eVis=EffectNWN2SpecialEffectFile("fx_hit_damage02");
ApplyEffectToObject(DURATION_TYPE_INSTANT,eVis,oPC);
ApplyEffectToObject(DURATION_TYPE_INSTANT,eDam,oPC);
return;
}

//Red orb is destroyed
if (sColor =="red")
{ SetLocalInt(oOrb,"Destroyed",1); 
nTotal = nTotal+1;
SetLocalInt(GetObjectByTag("carcerum_bossguardian01"),"total",nTotal);

SendMessageToPC(oPC,"Total is "+IntToString(nTotal));

if (nTotal == 1)
{
//spawn 3 druagoth
ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectNWN2SpecialEffectFile("sp_summon_creature_1"),GetLocation(GetWaypointByTag("carc_mrloch_bossfght1_spn1")));
ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectNWN2SpecialEffectFile("sp_summon_creature_1"),GetLocation(GetWaypointByTag("carc_mrloch_bossfght1_spn2")));
ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectNWN2SpecialEffectFile("sp_summon_creature_1"),GetLocation(GetWaypointByTag("carc_mrloch_bossfght1_spn7")));
CreateObject(OBJECT_TYPE_CREATURE,"carcerum_druagoth01",GetLocation(GetWaypointByTag("carc_mrloch_bossfght1_spn1")));
CreateObject(OBJECT_TYPE_CREATURE,"carcerum_druagoth01",GetLocation(GetWaypointByTag("carc_mrloch_bossfght1_spn2")));
CreateObject(OBJECT_TYPE_CREATURE,"carcerum_druagoth01",GetLocation(GetWaypointByTag("carc_mrloch_bossfght1_spn7")));
ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectDamage(300,DAMAGE_TYPE_MAGICAL,DAMAGE_POWER_PLUS_TWENTY,TRUE),GetObjectByTag("carcerum_bossguardian01"));
}
if (nTotal == 2)
{
//spawn 2 druagoth 1 lochtus
CreateObject(OBJECT_TYPE_CREATURE,"carcerum_lochtus01",GetLocation(GetWaypointByTag("carc_mrloch_bossfght1_spn4")));
ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectNWN2SpecialEffectFile("sp_shades_summon"),GetLocation(GetWaypointByTag("carc_mrloch_bossfght1_spn4")));
CreateObject(OBJECT_TYPE_CREATURE,"carcerum_druagoth01",GetLocation(GetWaypointByTag("carc_mrloch_bossfght1_spn5")));
ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectNWN2SpecialEffectFile("sp_summon_creature_1"),GetLocation(GetWaypointByTag("carc_mrloch_bossfght1_spn5")));
CreateObject(OBJECT_TYPE_CREATURE,"carcerum_druagoth01",GetLocation(GetWaypointByTag("carc_mrloch_bossfght1_spn6")));
ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectNWN2SpecialEffectFile("sp_summon_creature_1"),GetLocation(GetWaypointByTag("carc_mrloch_bossfght1_spn6")));
ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectDamage(400,DAMAGE_TYPE_MAGICAL,DAMAGE_POWER_PLUS_TWENTY,TRUE),GetObjectByTag("carcerum_bossguardian01"));

}
if (nTotal == 3)
{
ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectNWN2SpecialEffectFile("fx_kos_death_fx"),oBoss);
ApplyEffectToObject(DURATION_TYPE_PERMANENT,EffectCutsceneParalyze(),oBoss);
DelayCommand(17.0,
ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectNWN2SpecialEffectFile("fx_kos_explosion"),GetLocation(GetObjectByTag("carcerum_bossguardian01"))));
SetPlotFlag(GetObjectByTag("carcerum_bossguardian01"), FALSE);
DelayCommand(16.2,DestroyObject(oBoss));
PlaySound("cs_kos_death", TRUE);
//DelayCommand(14.3,PlaySound("m_kos_cradle_release",TRUE));

DelayCommand(15.0,KillEveryone(oBoss));

DelayCommand(18.1, MusicBattleStop(GetArea(oPC)));
DelayCommand(18.0, MusicBattleChange(GetArea(oPC),107));
//DelayCommand(16.0,SetLocked(GetObjectByTag("carc_boss1room_exitdoor"),FALSE));
//DelayCommand(16.5,AssignCommand(GetObjectByTag("carc_boss1room_exitdoor"),
//ActionOpenDoor(GetObjectByTag("carc_boss1room_exitdoor"))));

}
}

//Blue orb is destroyed
if (sColor == "blu")
{
ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectHeal(300),GetObjectByTag("carcerum_bossguardian01"));

object oRed1 = GetObjectByTag("carc_mrlochorb_1red");
if (GetLocalInt(oRed1,"Destroyed"))
{ Penalty(oRed1,nTotal,oPC); return; }
object oRed2 = GetObjectByTag("carc_mrlochorb_2red");
if (GetLocalInt(oRed2,"Destroyed"))
{ Penalty(oRed2,nTotal,oPC); return; }
object oRed3 = GetObjectByTag("carc_mrlochorb_3red");
if (GetLocalInt(oRed3,"Destroyed"))
{ Penalty(oRed3,nTotal,oPC); return; }

else
{
//SendMessageToPC(oPC,"NO Red pod has been destroyed!");
effect eDam=EffectDamage(d10(2)+10,DAMAGE_TYPE_POSITIVE,DAMAGE_POWER_ENERGY);
effect eVis=EffectNWN2SpecialEffectFile("fx_hit_damage02");
ApplyEffectToObject(DURATION_TYPE_INSTANT,eVis,oPC);
ApplyEffectToObject(DURATION_TYPE_INSTANT,eDam,oPC);
return;
}
}
}

void main()
{
  int iDC = GetLockLockDC(OBJECT_SELF);
  int iDamage = GetLocalInt(OBJECT_SELF,"DamageTaken");
  object oPC = GetLastAttacker();

  MyShoutDisturbed(oPC);

        if (iDamage < 0)  iDamage = 0;
        iDamage = iDamage + 1;
       FloatingTextStringOnCreature("Damage done: " + IntToString(iDamage) + " of " + IntToString(iDC), oPC, FALSE);

//ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectHealOnZeroHP(9999),OBJECT_SELF);

//Pod is destroyed!
        if (iDamage ==  iDC) 
		{
          iDamage = iDC;
          AssignCommand(oPC,ClearAllActions());
		  DestroyOrb(OBJECT_SELF, oPC);
		  DelayCommand(1.5, SetLocalInt(OBJECT_SELF,"DamageTaken",0));
        }
  SetLocalInt(OBJECT_SELF,"DamageTaken",iDamage);
   

}