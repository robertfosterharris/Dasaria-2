void Clearance(object oPC)
{
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
}

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

void main()
{
object oPC = GetExitingObject();
    if (!GetIsPC(oPC))  return;
DelayCommand(5.0,Clearance(oPC));
ExecuteScript("j4acs_ha_exit",OBJECT_SELF);

//HUB RAY EMITTERS:
/////////////////////////////////////
object oClock1 = GetObjectByTag("carc_hub_rayemit01");
object oHub = GetObjectByTag("carc_hub_rayreceiver");
effect eEffect = EffectNWN2SpecialEffectFile("sp_utterdark_ray",oHub);
RemoveRay(oClock1);
DelayCommand(0.5,ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eEffect,oClock1, 900.0));
oClock1 = GetObjectByTag("carc_hub_rayemit02");
RemoveRay(oClock1);
DelayCommand(0.5,ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eEffect,oClock1, 900.0));
oClock1 = GetObjectByTag("carc_hub_rayemit03");
RemoveRay(oClock1);
DelayCommand(0.5,ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eEffect,oClock1, 900.0));


//set up portal scene
if (GetLocalInt(oClock1,"Carcerum_Portal_Scene")) return;
else
{
SetLocalInt(oClock1,"Carcerum_Portal_Scene", 1);
string sNPC = "carcerum_jeremusfin";
ApplyEffectToObject(DURATION_TYPE_PERMANENT,EffectNWN2SpecialEffectFile("sp_gate"),GetObjectByTag("carc_portal_wp"));
CreateObject(OBJECT_TYPE_PLACEABLE,"carc_finalportalobj", GetLocation(GetObjectByTag("carc_portal_wp")));
ApplyEffectToObject(DURATION_TYPE_PERMANENT,EffectVisualEffect(355),GetObjectByTag("carc_hub_rayreceiver"));
ApplyEffectToObject(DURATION_TYPE_PERMANENT,EffectNWN2SpecialEffectFile("fx_portal_gen_small"),GetObjectByTag("carc_hub_rayreceiver"));


location lSpawn = GetLocation(GetWaypointByTag("carc_portalscenespawn"));
CreateObject(OBJECT_TYPE_CREATURE,sNPC,lSpawn);

CreateObject(OBJECT_TYPE_PLACEABLE,"carc_supplywagon",GetLocation(GetWaypointByTag("carc_finalscene_wagon")));

	if (GetJournalEntry("carcerum_journal", oPC) == 11)
	{
	object oTrac = CreateObject(OBJECT_TYPE_CREATURE,"carcerum_traductusfin",GetLocation(GetWaypointByTag("carc_portalscenespaw2")));
	SetPlotFlag(oTrac,FALSE);
	ExecuteScript("gb_spawn_dead_sp",oTrac);
	CreateObject(OBJECT_TYPE_CREATURE,"carcerum_squire",GetLocation(GetWaypointByTag("carc_finalscene_squire")));
	}
}


//Quest's done for this reset.
SetLocalInt(GetObjectByTag("carc_ruinentrance"),"Collapsed",1);
DestroyObject(GetObjectByTag("carc_jeremustatic"));
DestroyObject(GetObjectByTag("carc_static_traduc"));

}