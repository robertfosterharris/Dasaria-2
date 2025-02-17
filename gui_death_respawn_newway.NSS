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

*/

// "RemoveEffects"
#include "nw_i0_plot"

// Reset the functions
#include "std_faction_i0"


// No-levelloss function
#include "std_i0_xp"

// mark of death
#include "std_i0_markofdeath"  


// House rules for respawning
#include "death_i0_respawn"




void	main()
	{

    object oRespawner = OBJECT_SELF;
	
	
	// Load respawn point
	location respawn_point = respawn_locate_point(oRespawner);
	
	
	SendMessageToPC(oRespawner, "Stupid Respawn");
		
	// Raise them up
    ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectResurrection(),oRespawner);
    ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectHeal(GetMaxHitPoints(oRespawner)), oRespawner);
    RemoveEffects(oRespawner);
	
	// This method has no penalty at all, for now
	
	
	// Send them on their way
	AssignCommand( oRespawner, JumpToLocation(respawn_point) );
	
	}




void main_old()
{
    object oRespawner = OBJECT_SELF;
	
	string respawn_tag = "std_respawn_area_wp";
	
	SendMessageToPC(oRespawner, "Presenting menu");
		
	// Raise them up
    ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectResurrection(),oRespawner);
    ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectHeal(GetMaxHitPoints(oRespawner)), oRespawner);
    RemoveEffects(oRespawner);
	
	// Get them hidden
	SetScriptHidden(oRespawner, TRUE, FALSE);
	ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectCutsceneImmobilize(),oRespawner);	
	

	// Show the menu
	AssignCommand( oRespawner, 
		ActionStartConversation( oRespawner, "mod_rest", TRUE, FALSE, TRUE, TRUE )
		);		
	
 }

 
	
	
	
	
/*
*/