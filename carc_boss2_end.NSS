//placeholder for Tier 2 restoration.
//see zz_reset

//void Clearance(object oPC);

void RemoveRay(object oObject);
void main()
{
object oPC = GetClickingObject();
if(!GetIsPC(oPC)) return;
object oWP2 = GetWaypointByTag("carc_abelis_finalexit");
AssignCommand(oPC,ClearAllActions());
DelayCommand(0.1,
AssignCommand(oPC,ActionJumpToLocation(GetLocation(oWP2))));

if (GetLocalInt(OBJECT_SELF,"Done")) return;
SetLocalInt(OBJECT_SELF,"Done",1);
DelayCommand(600.0,DeleteLocalInt(OBJECT_SELF,"Done"));


//Restore music to original:
MusicBattleChange(GetArea(oPC),97);
MusicBattleStop(GetArea(oPC));
///////////////////////////////////

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

//DelayCommand(5.0,Clearance(oPC));
}
/////////////////////////////////////
//Ray removal just in case:
////////////////////////////////////
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
////////////////////////////////////
////////////////////////////////////
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
		if (GetTag(oObject) == "c_imp") { DestroyObject(oObject); }
		}
        oObject = GetNextObjectInArea(OBJECT_SELF);
    }

DeleteLocalInt(GetObjectByTag("carc_abelisgastrigger"),"DONE");
DeleteLocalInt(GetObjectByTag("carc_abelisbosstrigger"),"DONE");
DeleteLocalInt(GetObjectByTag("carc_abelis_oblsk_src01"),"BOSS_DEAD");
}