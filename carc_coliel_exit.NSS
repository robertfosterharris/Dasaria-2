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
	
//I'm reusing this script for the finale exit event, so the following is put in condition
//in the case this is the coliel level.
if (GetTag(OBJECT_SELF)=="misc_carcerum_coliel")
{
DeleteLocalInt(GetObjectByTag("carc_coliel_avatardoor"),"Combo");
object oAvatar = GetObjectByTag("carc_coliel_avtable01");
SetCreatureAppearanceType(oAvatar, 81); //Set to frost giant
oAvatar = GetObjectByTag("carc_coliel_avtable02");
SetCreatureAppearanceType(oAvatar, 547); //Set to Kistrel
oAvatar = GetObjectByTag("carc_coliel_avtable03");
SetCreatureAppearanceType(oAvatar, 184); //Set to winter wolf
oAvatar = GetObjectByTag("carc_coliel_avtable04");
SetCreatureAppearanceType(oAvatar, 497); //Set to nightwalker
}

//woops, added some stuff to finale. Adding it here
if (GetTag(OBJECT_SELF)=="misc_carcerum_finale")
{
object oObject = GetObjectByTag("carc_fin_lightemit02");
effect eEffect = GetFirstEffect(oObject);
    while(GetIsEffectValid(eEffect))
    {
        if(GetEffectType(eEffect) == EFFECT_TYPE_VISUALEFFECT)
        { RemoveEffect(oObject, eEffect); }
        eEffect = GetNextEffect(oObject);
    }
}
}


void main()
{
object oPC = GetExitingObject();
    if (!GetIsPC(oPC))  return;
DelayCommand(5.0,Clearance(oPC));
ExecuteScript("j4acs_ha_exit",OBJECT_SELF);
}