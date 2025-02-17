// carc_boss1_exit
void Clearance(object oPC);
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
object oPC = GetExitingObject();
if(!GetIsPC(oPC)) return;
DelayCommand(5.0,Clearance(oPC));
ExecuteScript("j4acs_ha_exit",OBJECT_SELF);
}


void Clearance(object oPC)
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
		string sLeft = GetStringLeft(GetTag(oObject),14);
		if (sLeft == "misc_carcerum_") { DestroyObject(oObject); }
		
MusicBattleChange(GetArea(oPC),107);
MusicBattleStop(GetArea(oPC));
		}
    oObject = GetNextObjectInArea(OBJECT_SELF);
    }

DelayCommand(30.0,Restore());
DeleteLocalInt(GetObjectByTag("carc_boss1startrigger"),"Done");
}