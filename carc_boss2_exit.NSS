// carc_boss2_exit
void Clearance(object oPC);

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
		if (GetTag(oObject) == "c_imp") { DestroyObject(oObject); }
//Restore music to original:
MusicBattleChange(GetArea(oPC),97);
MusicBattleStop(GetArea(oPC));

		}
        oObject = GetNextObjectInArea(OBJECT_SELF);
    }

DeleteLocalInt(GetObjectByTag("carc_abelisgastrigger"),"DONE");
DeleteLocalInt(GetObjectByTag("carc_abelisbosstrigger"),"DONE");
DeleteLocalInt(GetObjectByTag("carc_abelis_oblsk_src01"),"BOSS_DEAD");
}