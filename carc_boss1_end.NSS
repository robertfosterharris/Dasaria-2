//We finished Boss #1. Tier 2 opens.
//also, ominous ray at the hub.
//Clients crash if transitioning while the pods are cutscene invisible! Strangeness!
//We'll restore everything here then.
//frac.
void Clearance(object oPC);
void RemoveRay(object oObject)
{
    effect eEffect = GetFirstEffect(oObject);
    while(GetIsEffectValid(eEffect))
    {
        if(GetEffectType(eEffect) == EFFECT_TYPE_VISUALEFFECT)
        { RemoveEffect(oObject, eEffect); }
        eEffect = GetNextEffect(oObject);
    }
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

void Restoration2(object oOrb, string sColor="blu")
{
	SetLocalInt(OBJECT_SELF,"DamageTaken",0);
	DeleteLocalInt(oOrb,"Destroyed");
	RemoveCutsceneInvisibility(oOrb);
	string sWhich = GetLocalString(oOrb,"Num");
	object oLight = CreateObject(OBJECT_TYPE_PLACED_EFFECT,"carc_mrlochorb_"+sColor+"_glow",GetLocation(GetWaypointByTag("podvfx_"+sWhich+sColor+"0"+sWhich)), FALSE,"carc_mrlochorb_"+sWhich+sColor+"_glow");
	object oVFX = CreateObject(OBJECT_TYPE_LIGHT,"carc_mrlochorb_"+sColor+"_light",GetLocation(GetWaypointByTag("podlight_"+sWhich+sColor+"0"+sWhich)),FALSE,"carc_mrlochorb_"+sWhich+sColor+"_light");
	ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectHeal(9999),oOrb);
}

void Restore()
{
object oOrb = GetObjectByTag("carc_mrlochorb_1red");
Restoration2(oOrb,"red");
oOrb = GetObjectByTag("carc_mrlochorb_2red");
Restoration2(oOrb,"red");
oOrb = GetObjectByTag("carc_mrlochorb_3red");
Restoration2(oOrb,"red");
oOrb = GetObjectByTag("carc_mrlochorb_1blu");
Restoration2(oOrb);
oOrb = GetObjectByTag("carc_mrlochorb_2blu");
Restoration2(oOrb);
oOrb = GetObjectByTag("carc_mrlochorb_3blu");
Restoration2(oOrb);
}

void main()
{

if (!GetLocalInt(OBJECT_SELF,"Done")) { Restore(); }

object oPC = GetClickingObject();
//object oWP1 = GetWaypointByTag("carc_maerlc_fakeexitwp");
object oWP2 = GetWaypointByTag("carc_maerloch_begin_outwp");
AssignCommand(oPC,ClearAllActions());
//AssignCommand(oPC,ActionJumpToLocation(GetLocation(oWP1)));
DelayCommand(0.1,
AssignCommand(oPC,ActionJumpToLocation(GetLocation(oWP2))));

if(!GetIsPC(oPC)) return;
if (GetLocalInt(OBJECT_SELF,"Done")) return;
SetLocalInt(OBJECT_SELF,"Done",1);
DelayCommand(600.0,DeleteLocalInt(OBJECT_SELF,"Done"));


object oClock1 = GetObjectByTag("carc_hub_rayemit01");
object oHub = GetObjectByTag("carc_hub_rayreceiver");
effect eEffect = EffectNWN2SpecialEffectFile("sp_utterdark_ray",oHub);
RemoveRay(oClock1);
DelayCommand(0.5,ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eEffect,oClock1, 900.0));

//DelayCommand(5.0,Clearance(oPC));
}
/*
//finished Abelis level as well.
if (GetLocalInt(OBJECT_SELF,"Level2"))
{
oClock1 = GetObjectByTag("carc_hub_rayemit02");
ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eEffect,oClock1, 900.0);
}


//and the last level too..
if (GetLocalInt(OBJECT_SELF,"Level3"))
{
oClock1 = GetObjectByTag("carc_hub_rayemit03");
ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eEffect,oClock1, 900.0);
}
}*/

/*void Clearance(object oPC)
{
    if (!GetIsPC(oPC))  return;
    oPC = GetFirstPC();
while (oPC != OBJECT_INVALID)
    {
        if (OBJECT_SELF == GetArea(oPC)) return;
        else oPC = GetNextPC();
    }
    // If we've made it this far, we know that there aren't any PCs in the area
	//We now resume our scheduled despawning.
    object oObject = GetFirstObjectInArea(OBJECT_SELF);
    while (oObject != OBJECT_INVALID)
    {	
		if (GetObjectType(oObject) == OBJECT_TYPE_CREATURE)
		{
		string sLeft = GetStringLeft(GetTag(oObject),9);
		if (sLeft == "carcerum_") { DestroyObject(oObject); }
		}
    oObject = GetNextObjectInArea(OBJECT_SELF);
    }

DeleteLocalInt(GetObjectByTag("carc_boss1startrigger"),"Done");
}*/