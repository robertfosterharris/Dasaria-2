void ApplyAoeAtLocation(int nAOE, location lLocation, string sOnEnter, float fDuration=0.0, string sOnHeartbeat="", string sOnExit="", string sTag="")
{
    int nDurationType = (fDuration == 0.0) ? DURATION_TYPE_PERMANENT : DURATION_TYPE_TEMPORARY;
    effect eAOE = EffectAreaOfEffect(nAOE, sOnEnter, sOnHeartbeat, sOnExit, sTag);
    ApplyEffectAtLocation(nDurationType, eAOE, lLocation, fDuration);
}

void main()
{
	object oItem;
	object oCreature;
	object oObject;
    int nCastDuration   = 20;
	
	oItem = GetItemActivated();
	oCreature = CreateObject(OBJECT_TYPE_CREATURE, GetLocalString(oItem, "sCreature"), GetItemActivatedTargetLocation());
	SetFirstName(oCreature, GetName(oItem));
	SetDescription(oCreature, GetDescription(oItem));
	oObject = CreateObject(OBJECT_TYPE_PLACEABLE, GetLocalString(oItem, "sPlaceable"), GetItemActivatedTargetLocation());
	SetFirstName(oObject, GetName(oItem));
	SetDescription(oObject, GetDescription(oItem));
	

   
	location lTrap1 = GetLocation(GetObjectByTag ("teshalia_incense"));
	object oCreator = GetObjectByTag("aoe_creator");
	
	
	AssignCommand(oCreator, ApplyAoeAtLocation(AOE_PER_FOGMIND, lTrap1, "morell_tesh_incense", (IntToFloat(nCastDuration)*3.0) ));


	DestroyObject(oCreature, 60.0);
	DestroyObject(oObject, 60.0);
	
	}		