/*
	11/13/06	RFH		ADDED DEBUGING INFORMATION
						ADDED TIME_STAMP_SET ON UGLY_AREA_INIT
    04/29/07    RFH     REMOVED DEBUGGING INFORMATION    
    04/30/07    RFH     DELETE CREATURES IF THEY WERE SPAWNED BY AN ENCOUNTER
                        CLOSE LINKED DOORS
                        DISPLAY ITEM PROCESSED COUNT
	05/01/07	RFH		ADDED RESPAWNING TRAP CODE
	11/18/07	RFH		ADDED RESPAWNING TRAP CODE FOR PROJECTILE TRAPS
	01/15/09	RFH		CLOSING DESTROYED DOORS CAUSED THEM TO STOP TRANSITIONING
						SO ONLY CLOSE OPEN DOORS.  ALSO COMMENTED OUT THE CLOSING OF LINKED DOOR.
	07/19/09	Atharin	Added "UGLY_NOCLOSE" condition to ugly_door_found
*/

#include "std_i0_time"
#include "x0_i0_stringlib"

int RandomTrapBaseType(int nTrapClass);
void DoSweep(object oArea);
void SetTrap(object oObject);
void SetTrapOrigin(object oObject);
void j4acs_sweeper_wipe_object(object target);
void ugly_area_init(object oArea);
void ugly_door_found( object oDoor );
void ugly_scan( object oArea );

//
//	RETURNS A RANDOM TRAP BASE TYPE FROM A TRAPS CLASS
//
//	nTrapClass:
//	-1	MINOR
//	-2	AVERAGE
//	-3	STRONG
//	-4	DEADLY
//	-5	EPIC
//
int RandomTrapBaseType(int nTrapClass)
{
	int nRandomTrapBaseType;
	
	switch (nTrapClass)
	{
		case -1:					//	MINOR TRAPS
			switch (Random(10))
			{
				case 0:
					nRandomTrapBaseType = TRAP_BASE_TYPE_MINOR_ACID;
					break;
				case 1:
					nRandomTrapBaseType = TRAP_BASE_TYPE_MINOR_ACID_SPLASH;
					break;
				case 2:
					nRandomTrapBaseType = TRAP_BASE_TYPE_MINOR_ELECTRICAL;
					break;
				case 3:
					nRandomTrapBaseType = TRAP_BASE_TYPE_MINOR_FIRE;
					break;
				case 4:
					nRandomTrapBaseType = TRAP_BASE_TYPE_MINOR_FROST;
					break;
				case 5:
					nRandomTrapBaseType = TRAP_BASE_TYPE_MINOR_GAS;
					break;
				case 6:
					nRandomTrapBaseType = TRAP_BASE_TYPE_MINOR_HOLY;
					break;
				case 7:
					nRandomTrapBaseType = TRAP_BASE_TYPE_MINOR_NEGATIVE;
					break;
				case 8:
					nRandomTrapBaseType = TRAP_BASE_TYPE_MINOR_SONIC;
					break;
				case 9:
					nRandomTrapBaseType = TRAP_BASE_TYPE_MINOR_SPIKE;
					break;
				case 10:
					nRandomTrapBaseType = TRAP_BASE_TYPE_MINOR_TANGLE;
					break;
			}					
			break;
		case -2:					//	AVERAGE TRAPS
			switch (Random(10))
			{
				case 0:
					nRandomTrapBaseType = TRAP_BASE_TYPE_AVERAGE_ACID;
					break;
				case 1:
					nRandomTrapBaseType = TRAP_BASE_TYPE_AVERAGE_ACID_SPLASH;
					break;
				case 2:
					nRandomTrapBaseType = TRAP_BASE_TYPE_AVERAGE_ELECTRICAL;
					break;
				case 3:
					nRandomTrapBaseType = TRAP_BASE_TYPE_AVERAGE_FIRE;
					break;
				case 4:
					nRandomTrapBaseType = TRAP_BASE_TYPE_AVERAGE_FROST;
					break;
				case 5:
					nRandomTrapBaseType = TRAP_BASE_TYPE_AVERAGE_GAS;
					break;
				case 6:
					nRandomTrapBaseType = TRAP_BASE_TYPE_AVERAGE_HOLY;
					break;
				case 7:
					nRandomTrapBaseType = TRAP_BASE_TYPE_AVERAGE_NEGATIVE;
					break;
				case 8:
					nRandomTrapBaseType = TRAP_BASE_TYPE_AVERAGE_SONIC;
					break;
				case 9:
					nRandomTrapBaseType = TRAP_BASE_TYPE_AVERAGE_SPIKE;
					break;
				case 10:
					nRandomTrapBaseType = TRAP_BASE_TYPE_AVERAGE_TANGLE;
					break;
			}
			break;
		case -3:					//	STRONG TRAPS
			switch (Random(10))
			{
				case 0:
					nRandomTrapBaseType = TRAP_BASE_TYPE_STRONG_ACID;
					break;
				case 1:
					nRandomTrapBaseType = TRAP_BASE_TYPE_STRONG_ACID_SPLASH;
					break;
				case 2:
					nRandomTrapBaseType = TRAP_BASE_TYPE_STRONG_ELECTRICAL;
					break;
				case 3:
					nRandomTrapBaseType = TRAP_BASE_TYPE_STRONG_FIRE;
					break;
				case 4:
					nRandomTrapBaseType = TRAP_BASE_TYPE_STRONG_FROST;
					break;
				case 5:
					nRandomTrapBaseType = TRAP_BASE_TYPE_STRONG_GAS;
					break;
				case 6:
					nRandomTrapBaseType = TRAP_BASE_TYPE_STRONG_HOLY;
					break;
				case 7:
					nRandomTrapBaseType = TRAP_BASE_TYPE_STRONG_NEGATIVE;
					break;
				case 8:
					nRandomTrapBaseType = TRAP_BASE_TYPE_STRONG_SONIC;
					break;
				case 9:
					nRandomTrapBaseType = TRAP_BASE_TYPE_STRONG_SPIKE;
					break;
				case 10:
					nRandomTrapBaseType = TRAP_BASE_TYPE_STRONG_TANGLE;
					break;
			}
			break;
		case -4:					//	DEADLY TRAPS
			switch (Random(10))
			{
				case 0:
					nRandomTrapBaseType = TRAP_BASE_TYPE_DEADLY_ACID;
					break;
				case 1:
					nRandomTrapBaseType = TRAP_BASE_TYPE_DEADLY_ACID_SPLASH;
					break;
				case 2:
					nRandomTrapBaseType = TRAP_BASE_TYPE_DEADLY_ELECTRICAL;
					break;
				case 3:
					nRandomTrapBaseType = TRAP_BASE_TYPE_DEADLY_FIRE;
					break;
				case 4:
					nRandomTrapBaseType = TRAP_BASE_TYPE_DEADLY_FROST;
					break;
				case 5:
					nRandomTrapBaseType = TRAP_BASE_TYPE_DEADLY_GAS;
					break;
				case 6:
					nRandomTrapBaseType = TRAP_BASE_TYPE_DEADLY_HOLY;
					break;
				case 7:
					nRandomTrapBaseType = TRAP_BASE_TYPE_DEADLY_NEGATIVE;
					break;
				case 8:
					nRandomTrapBaseType = TRAP_BASE_TYPE_DEADLY_SONIC;
					break;
				case 9:
					nRandomTrapBaseType = TRAP_BASE_TYPE_DEADLY_SPIKE;
					break;
				case 10:
					nRandomTrapBaseType = TRAP_BASE_TYPE_DEADLY_TANGLE;
					break;
			}
			break;
		case -5:					//	EPIC TRAPS
			switch (Random(4))
			{
				case 0:
					nRandomTrapBaseType = TRAP_BASE_TYPE_EPIC_ELECTRICAL;
					break;
				case 1:
					nRandomTrapBaseType = TRAP_BASE_TYPE_EPIC_FIRE;
					break;
				case 2:
					nRandomTrapBaseType = TRAP_BASE_TYPE_EPIC_FROST;
					break;
				case 3:
					nRandomTrapBaseType = TRAP_BASE_TYPE_EPIC_SONIC;
					break;
			}
			break;
		default:
			WriteTimestampedLogEntry("ERROR: INVALID TRAP CLASS IN FUNCTION RandomTrapBaseType");
			break;
	}
	
	return nRandomTrapBaseType;
}

//
//	SWEEP EMPTY AREAS
//
void DoSweep(object oArea)
{
	if (GetLocalInt(oArea, "bAreaEmpty")) ugly_scan(oArea);
}

//
//	CREATES TRAPS FOR OBJECTS WITH LOCALINT IsTrapped SET TO TRUE
//
void SetTrap(object oObject)
{
	int nTrapBaseType;
	int nTrapRespawnChance;
	object oTrap;
	string sOnTrapTriggered;
	string sTrapName;
	
	nTrapBaseType = GetLocalInt(oObject, "TrapBaseType");
	if (nTrapBaseType < 0) nTrapBaseType = RandomTrapBaseType(nTrapBaseType);
	
	nTrapRespawnChance = GetLocalInt(oObject, "TrapRespawnChance");
	if (nTrapRespawnChance == 0) nTrapRespawnChance = 100;
	
	sOnTrapTriggered = GetLocalString(oObject, "OnTrapTriggered");
	if (GetLocalString(oObject, "SpellList") != "") sOnTrapTriggered = "gtr_d2_ontrigger";
	
	if (d100() <= nTrapRespawnChance)
	{
		if (GetObjectType(oObject) == OBJECT_TYPE_WAYPOINT)
		{
			oTrap = CreateTrapAtLocation(nTrapBaseType, GetLocation(oObject), GetLocalFloat(oObject, "Size"), GetTag(oObject), STANDARD_FACTION_HOSTILE, "gtr_d2_ondisarm", sOnTrapTriggered);
			SetLocalInt(oTrap, "IsTrapped", TRUE);
		}
		else
		{
			CreateTrapOnObject(nTrapBaseType, oObject, STANDARD_FACTION_HOSTILE, "gtr_d2_ondisarm", sOnTrapTriggered);
			oTrap = oObject;
		}
		if (GetLocalInt(oObject, "TrapDetectable")) SetTrapDetectable(oTrap, GetLocalInt(oObject, "TrapDetectable"));
		if (GetLocalInt(oObject, "TrapDetectDC")) SetTrapDetectDC(oTrap, GetLocalInt(oObject, "TrapDetectDC"));
		if (GetLocalInt(oObject, "TrapDisarmable")) SetTrapDisarmable(oTrap, GetLocalInt(oObject, "TrapDisarmable"));
		if (GetLocalInt(oObject, "TrapDisarmDC")) SetTrapDisarmDC(oTrap, GetLocalInt(oObject, "TrapDisarmDC"));
		if (GetLocalInt(oObject, "TrapRecoverable")) SetTrapRecoverable(oTrap, GetLocalInt(oObject, "TrapRecoverable"));
		if (GetLocalInt(oObject, "CasterLevel")) SetLocalInt(oTrap, "CasterLevel", GetLocalInt(oObject, "CasterLevel"));
		if (GetLocalString(oObject, "SpellList") != "") SetLocalString(oTrap, "SpellList", GetLocalString(oObject, "SpellList"));
		if (GetIsObjectValid(GetLocalObject(oObject, "TrapOrigin"))) SetLocalObject(oTrap, "TrapOrigin", GetLocalObject(oObject, "TrapOrigin"));
	}
}

//
//	SET TRAP ORIGIN FOR PROJECTILE TRAPS
//
void SetTrapOrigin(object oObject)
{
	int nNth;
	int nType;
	object oTrapOrigin;
	
	nType = GetObjectType(oObject);
	if (nType == OBJECT_TYPE_WAYPOINT || nType == OBJECT_TYPE_DOOR)
	{
		nNth = GetLocalInt(GetModule(), "nTrapOrigin");
		nNth++;
		SetLocalInt(GetModule(), "nTrapOrigin", nNth);
		oTrapOrigin = CreateObject(OBJECT_TYPE_PLACEABLE, "d2_trap_origin", GetLocation(oObject), FALSE, "d2_trap_origin_" + IntToString(nNth));
		SetLocalObject(oObject, "TrapOrigin", oTrapOrigin);
	}
	else
	{
		oTrapOrigin = oObject;
	}
	SetLocalInt(oTrapOrigin, "NWN2_PROJECTILE_TRAP_CASTER_LEVEL", GetLocalInt(oObject, "CasterLevel"));
	SetReflexSavingThrow(oTrapOrigin, GetLocalInt(oObject, "CasterLevel"));
}

//
//	DESTROY AN OBJECT AND ITS INVENTORY
//
void j4acs_sweeper_wipe_object(object target)
{
	if (GetHasInventory(target))
    {
	    object foo = GetFirstItemInInventory(target);
    	while ( GetIsObjectValid(foo) )
      	{
      		j4acs_sweeper_wipe_object(foo);
      		foo = GetNextItemInInventory(target);
      	}
    }
  DestroyObject(target);
}

//
//	INITIALIZE THE AREA
//
void ugly_area_init(object oArea)
{
	int nNth;
	int nType;
	int bHerbs;
	object oObject;
	object oTrapOrigin;
	
	oObject = GetFirstObjectInArea(oArea);
	while (GetIsObjectValid(oObject))
	{
		nType = GetObjectType(oObject);
    	switch (nType)
		{
      		case OBJECT_TYPE_DOOR:
				if (GetLocked(oObject)) SetLocalInt(oObject, "j4acs_locked", TRUE);
				break;
							
			default:
				break;
		}

		if (GetLocalInt(oObject, "IsTrapped"))
		{
			if (nType != OBJECT_TYPE_WAYPOINT)
			{
				SetLocalInt(oObject, "TrapBaseType", GetTrapBaseType(oObject));
				SetLocalInt(oObject, "TrapDetectable", GetTrapDetectable(oObject));
				SetLocalInt(oObject, "TrapDetectDC", GetTrapDetectDC(oObject));
				SetLocalInt(oObject, "TrapDisarmable", GetTrapDisarmable(oObject));
				SetLocalInt(oObject, "TrapDisarmDC", GetTrapDisarmDC(oObject));
				SetLocalInt(oObject, "TrapRecoverable", GetTrapRecoverable(oObject));
				SetTrapDisabled(oObject);
			}
			
			if (GetLocalString(oObject, "SpellList") != "")	AssignCommand(GetModule(), DelayCommand(2.0, SetTrapOrigin(oObject)));
			AssignCommand(GetModule(), DelayCommand(4.0, SetTrap(oObject)));
		}	
				
		oObject = GetNextObjectInArea(oArea);			
	}		
}

//
//	CLOSE AND LOCK DOORS FOUND DURING AN AREA SWEEP
//
void ugly_door_found( object oDoor )
{
	if (!GetLocalInt(oDoor,"UGLY_NOCLOSE"))
	{
	    object oTransitionTarget;
	    
		if (GetIsOpen(oDoor))
		{
			AssignCommand(oDoor, ActionCloseDoor(oDoor));
			if ( GetLocalInt(oDoor, "j4acs_locked") == TRUE)
	    	{
					SetLocked(oDoor, TRUE);
			}
			
	    	oTransitionTarget = GetTransitionTarget(oDoor);
			if (GetIsOpen(oTransitionTarget) && GetIsObjectValid(oTransitionTarget))
	    	{
	    		AssignCommand(oTransitionTarget, ActionCloseDoor(oTransitionTarget));
		    	if ( GetLocalInt(oTransitionTarget, "j4acs_locked") == TRUE)
	        	{
					SetLocked(oTransitionTarget, TRUE);
		    	}
	    	}
		}
	}		
}

//
//	SWEEP AN AREA
//
void ugly_scan( object oArea )
{
    int nType;
    int nDoors;
    int nPlaceables;
    int nCreatures;
    int nOther;
    object oObject;
	
	oObject = GetFirstObjectInArea(oArea);
	while (GetIsObjectValid(oObject))
	{
		nType = GetObjectType( oObject );
		switch (nType)
      	{
   			case OBJECT_TYPE_DOOR:
				nDoors++;
				ugly_door_found( oObject );
				break;
					
			case OBJECT_TYPE_PLACEABLE:
				nPlaceables++;
			    if (GetTag(oObject) == "BodyBag") j4acs_sweeper_wipe_object(oObject);
				break;
                
			case OBJECT_TYPE_CREATURE:
				nCreatures++;
				if (GetIsEncounterCreature(oObject) && GetStandardFactionReputation(STANDARD_FACTION_HOSTILE, oObject) > 50)
				{
					DestroyObject(oObject);
				}
				break;
			default:
				nOther++;
				break;
		}
		
		if (GetLocalInt(oObject, "IsTrapped"))
		{
			if (GetObjectType(oObject) == OBJECT_TYPE_TRIGGER)
			{
				SetTrapDisabled(oObject);	
			}
			else
			{
				SetTrapDisabled(oObject);	
				AssignCommand(GetModule(), DelayCommand(2.0, SetTrap(oObject)));
			}				
		}
		
	    oObject = GetNextObjectInArea(oArea);				             
	}
}

/*
*/