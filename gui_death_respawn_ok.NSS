/*
    Module respawn


Revision History:
	Created By:   Brent
	Created On:   November
	// ChazM 3/2/06
	June 1: moved RestoreEffects into plot include
	
	2006/11/??		jhr4n
		Modified to use area specific respawning with old NWN1/Dasaria
		GP/XP loss
		
	2006/12/10		jhr4n
		Takes ECL into account for preventing level loss
		
		8/14/2009	wired
		// only do the jail respawn if we're in or around cear
	
	2011/07/01	ROBERT HARRIS	ADDED CODE TO PREVENT MONSTERS PURSUING THE DEAD
			
	2012/02/10 wired clean up mounted player on death
		
*/

#include "nw_i0_plot"
#include "std_faction_i0"
#include "std_i0_markofdeath"
#include "death_i0_respawn"
#include "ginc_das_jail"
#include "dasolm_inc"
#include "std_inc_mounts"


void main()
{
	location lDeath = GetLocation(OBJECT_SELF);
	location respawn_point;
    object oRespawner = OBJECT_SELF;
	object oKiller = GetLastHostileActor(OBJECT_SELF);
	object oNPC;
	string sAreaTag = GetTag(GetArea(oRespawner));
	
	string respawn_tag = "std_respawn_area_wp";
	
	SendMessageToPC(oRespawner, "Respawning...");
	
	MountedPCCleanUp(OBJECT_SELF);	
	
	// Clear their "mark of death"
	std_death_mark_remove( oRespawner );
	
	// Load respawn point
	respawn_point = respawn_locate_point(oRespawner);
	
	// wired 08/14/2009
	if (FindSubString(sAreaTag, "cear") != -1)
	{
		if (GetLocalInt(oRespawner, "nLegalStatus") > LEGAL_STATUS_CLEAR) respawn_point = GetOpenCell(oRespawner);
	}
	
	// Wired 09/02/2010 Special Lendose OLM Logic
	if (FindSubString(sAreaTag,"lendose_ol",0) != -1)
    {
		respawn_point = DasOL_RespawnHook(oRespawner);
	}				
	
	// Raise them up
    ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectResurrection(),oRespawner);
    ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectHeal(GetMaxHitPoints(oRespawner)), oRespawner);
    RemoveEffects(oRespawner);
	
	// Show them the error of their ways
	if (GetControlledCharacter(GetLastHostileActor(oRespawner)) == OBJECT_INVALID) ApplyPenalty(oRespawner);
	
	// Repent!
	std_reputation_reset( oRespawner,"cearguard");
	
	// Send them on their way
	AssignCommand( oRespawner, JumpToLocation(respawn_point));
	
	//	SET A TEMPORARY VARIABLE TO PREVENT PURSUIT IN PERCEPTION SCRIPT
	SetLocalInt(oRespawner, "bIsDead", 1);
	DelayCommand(6.0, DeleteLocalInt(oRespawner, "bIsDead"));
}