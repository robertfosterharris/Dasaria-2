#include "X0_I0_PARTYWIDE"
#include "ginc_journal"

void spawn_placeable(string sResRef, location loc);

void main() {
	object oPC = GetLastKiller();
    string sResRef = GetResRef(OBJECT_SELF);
	location loc = GetLocation(OBJECT_SELF);
    float fRespawn = GetLocalFloat(OBJECT_SELF, "fRespawn");
    
    	AssignCommand(GetModule(), DelayCommand(fRespawn,
     			        spawn_placeable(sResRef, loc))); 
                        
    
    
	// count total portal arms in area
	object oPortalArm1 = GetNearestObjectByTag("storm_portal_arm1");
	object oPortalArm2 = GetNearestObjectByTag("storm_portal_arm2");
	object oPortalArm3 = GetNearestObjectByTag("storm_portal_arm3");
	object oPortalArm4 = GetNearestObjectByTag("storm_portal_arm4");
	int iLocalArmCount = GetLocalInt(oPC, "iLocalArmCount");
	
	// get total number of portal arms remaining.  We need to find out
	// if any respawned since the last time the player destroyed one.
	int iArmCount = 0;
	if (OBJECT_INVALID != oPortalArm1) {
		iArmCount = iArmCount + 1;
	}
	if (OBJECT_INVALID != oPortalArm2) {
		iArmCount = iArmCount + 1;
	}
	if (OBJECT_INVALID != oPortalArm3) {
		iArmCount = iArmCount + 1;
	}
	if (OBJECT_INVALID != oPortalArm4) {
		iArmCount = iArmCount + 1;
	}
	
	if (iLocalArmCount !=0 && iArmCount >= iLocalArmCount) {
		FloatingTextStringOnCreature("The arm collapses, but it seems to have no effect on the portal", oPC);
		return;
	}
	//FloatingTextStringOnCreature("iArmCount " + IntToString(iArmCount), oPC);
	// if we have got this far, no portal arms have respawned.
	SetLocalIntOnAll(oPC, "iLocalArmCount", iArmCount);
	
	
	switch(iArmCount) {
		case 3:
			SetLocalIntOnAll(oPC, "sJyhannaConvo", 1);
			//FloatingTextStringOnCreature("sJyhannaConvo 1", oPC);
			break;
		case 2:
			SetLocalIntOnAll(oPC, "sJyhannaConvo", 2);
			//FloatingTextStringOnCreature("sJyhannaConvo 2", oPC);
			break;
		case 1:
			SetLocalIntOnAll(oPC, "sJyhannaConvo", 3);
			//FloatingTextStringOnCreature("sJyhannaConvo 3", oPC);
			break;
		case 0:
			SetLocalIntOnAll(oPC, "sJyhannaConvo", 4);
			//FloatingTextStringOnCreature("sJyhannaConvo 4", oPC);
			// need to set everything for respawns.
			
			break;
		default:
			// doh! we are in trouble, so the best we can do is drop to
			// the fall through text in jyhannas convo.
			SetLocalIntOnAll(oPC, "sJyhannaConvo", -1);
			//FloatingTextStringOnCreature("sJyhannaConvo -1", oPC);
		}
		
		location locWP = GetLocation(GetNearestObjectByTag("WP_storm_portal_spawn"));
		object oJyhanna = CreateObject(OBJECT_TYPE_CREATURE, "pande_jyhanna_projection", locWP, TRUE);
	
		effect eZapper = EffectVisualEffect(VFX_SPELL_HIT_CALL_LIGHTNING); 
		ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eZapper, locWP);
		AssignCommand(oJyhanna, ClearAllActions());
		//int iConvoPos = GetLocalInt(oPC, "sJyhannaConvo");
		//SetLocalIntOnAll(oPC, "sJyhannaConvo", iConvoPos + 1);
	 
		//FloatingTextStringOnCreature("sJyhannaConvo " + IntToString(GetLocalInt(oPC, "sJyhannaConvo")), oPC);
		AssignCommand(oPC, ActionStartConversation(oJyhanna, "" , FALSE, TRUE, TRUE, FALSE));
}
    
void spawn_placeable(string sResRef, location loc) {
    object oPlaceable = CreateObject(OBJECT_TYPE_PLACEABLE, sResRef, loc, TRUE);
}