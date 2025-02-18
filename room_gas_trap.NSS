// room_gas_trap
void ApplyAoeAtLocation(int nAOE, location lLocation, string sOnEnter, float fDuration=0.0, string sOnHeartbeat="", string sOnExit="", string sTag="")
{
    int nDurationType = (fDuration == 0.0) ? DURATION_TYPE_PERMANENT : DURATION_TYPE_TEMPORARY;
    effect eAOE = EffectAreaOfEffect(nAOE, sOnEnter, sOnHeartbeat, sOnExit, sTag);
    ApplyEffectAtLocation(nDurationType, eAOE, lLocation, fDuration);
}

void main()
{
    object oPC  = GetEnteringObject();
	if ( (GetIsPC(oPC)) &&
		 (GetLocalInt(OBJECT_SELF, "Triggered") != 1) )
	{
		// sproing!
	    object oDoor1       = GetNearestObjectByTag ("GasTrapDoor1");
		object oDoor2       = GetNearestObjectByTag ("GasTrapDoor2");
    	int nCastDuration   = 20;
		location lTrap1 = GetLocation(GetWaypointByTag ("gasroomtrap1"));
		location lTrap2 = GetLocation(GetWaypointByTag ("gasroomtrap2"));
		location lTrap3 = GetLocation(GetWaypointByTag ("gasroomtrap3"));
   		object oCreator = GetObjectByTag("aoe_creator");
    			
		AssignCommand(oDoor1, ActionCloseDoor(oDoor1));
		AssignCommand(oDoor2, ActionCloseDoor(oDoor2));
	    SetLocked(oDoor1, TRUE);
		SetLocked(oDoor2, TRUE);
		AssignCommand(oCreator, ApplyAoeAtLocation(AOE_PER_FOGSTINK, lTrap1, "nw_t1_gasdeadc1", (IntToFloat(nCastDuration)*6.0) ));
		AssignCommand(oCreator, ApplyAoeAtLocation(AOE_PER_FOGSTINK, lTrap2, "nw_t1_gasdeadc1", (IntToFloat(nCastDuration)*6.0) ));
		AssignCommand(oCreator, ApplyAoeAtLocation(AOE_PER_FOGSTINK, lTrap3, "nw_t1_gasdeadc1", (IntToFloat(nCastDuration)*6.0) ));
		
		SetLocalInt(OBJECT_SELF, "Triggered", 1);
		
		DelayCommand(3.0f,FloatingTextStringOnCreature("Vents along the walls suddenly flood the room with green gas!",oPC,TRUE,10.0));
				
		DelayCommand(600.0f,SetLocalInt(OBJECT_SELF, "Triggered", 0));
		DelayCommand(600.0f,SetLocked(oDoor1, FALSE));
		DelayCommand(600.0f,SetLocked(oDoor2, FALSE));
	}
}