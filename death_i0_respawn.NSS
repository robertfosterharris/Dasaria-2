/*
	Helper functions for locating the respawn points
*/
// wired 07/01/2009 add support for lDefaultAreaRespawn
// wired 05/27/2010 use lDefaultAreaRespawn if checkpoint out of zone
// wired 08/12/2011 replace uses of GetIsLocationValid(location) with  GetIsObjectValid(GetAreaFromLocation(location))
// wired 07/02/2012 tap the respawn location for player housing

#include "std_i0_xp"
#include "d2_sql_log"

location	respawn_locate_point(object oRespawner);

int			value_of_equipped_items( object oPC );

void 		ApplyPenalty(object oDead);



string		respawn_kTag = "cfg_waypoint";
string 		respawn_kPlayerVar = "respawn_checkpoint";



/*
*/


location	respawn_locate_point(object oRespawner)
{
    object oRespawner = OBJECT_SELF;
	location lDefaultAreaRespawn;	
		
	// Attempt to Load tag from PC
	string tag = GetLocalString( oRespawner, respawn_kPlayerVar );
	object oWP = GetObjectByTag( tag );
	
	// 0-Player died in player housing
	if (GetStringLeft(GetTag(GetArea(oRespawner)), 2) == "ph")
	{
		lDefaultAreaRespawn = GetLocalLocation(oRespawner,"lExit");
		if (GetIsObjectValid( GetAreaFromLocation(lDefaultAreaRespawn) ) )
		{
			return lDefaultAreaRespawn;
		}
	}
	
	// 1-Look for a 'Checkpoint' style location
	// 5/27/2010 ignore this if it's out of area
	if ( GetIsObjectValid(oWP) && GetArea(oWP) == GetArea(oRespawner))
	{
		return GetLocation( oWP );
	}
	
	// 2-Look for a old-style respawn marker
	//	
	string respawn_tag = "std_respawn_area_wp";
	object respawn_marker = GetNearestObjectByTag(respawn_tag);
	if ( GetIsObjectValid(respawn_marker)  )
	{
		return GetLocation( respawn_marker );
	}
	
	// 3-Still here? Use the location stored on the PC in j4acs_ha_exit
	//
	lDefaultAreaRespawn = GetLocalLocation(oRespawner,"lDefaultAreaRespawn");
	if (GetIsObjectValid( GetAreaFromLocation(lDefaultAreaRespawn) ) )
	{
		return lDefaultAreaRespawn;
	}	

	// 4-Failed to find any of this
	// Jump to the module starting point
	//
	return GetStartingLocation();		
}


	
	
	

//	Applies an XP and GP penalty
//	to the player respawning
void ApplyPenalty(object oDead)
{
	int nGoldToTake;
    int nPenalty;
	
	nPenalty = 50 * GetHitDice(oDead);
	
	// The easy way!
	if (xp_level_ecl(oDead) < 20)
	{
		xp_penalty_nolevelloss(oDead, nPenalty);
	}
	else
	{
		SetXP(oDead, GetXP(oDead) - 1000);
	}  

    nGoldToTake = FloatToInt(0.10 * GetGold(oDead));
    if (nGoldToTake > 10000) nGoldToTake = 10000;

	if (GetLocalInt(oDead, "bNoGoldLoss") == 1)
	{
		nGoldToTake = 0;
		DeleteLocalInt(oDead, "bNoGoldLoss");
	}
    AssignCommand(oDead, TakeGoldFromCreature(nGoldToTake, oDead, TRUE));
    DelayCommand(4.0, FloatingTextStrRefOnCreature(58299, oDead, FALSE));
    DelayCommand(4.8, FloatingTextStrRefOnCreature(58300, oDead, FALSE));
	
	trackEvent(oDead,"RESPAWN",oDead,nGoldToTake,nPenalty);
}








int			value_of_equipped_items( object oPC )
	{
	int gp = 0;
	
	int 	iSlot;
	object 	oItem;
	
	for( iSlot=0; iSlot < NUM_INVENTORY_SLOTS; ++iSlot )
		{
		oItem = GetItemInSlot( iSlot , oPC );
		gp += GetGoldPieceValue( oItem );		
		}
	
	return gp;
	}

	
	
	
	




/*

This probably will never be used again, but I can't bring
myself to delete it.  "just in case"


// Resurrect and remove negative effects from oPlayer
void Raise(object oPlayer)
{
	effect eVisual = EffectVisualEffect(VFX_IMP_RESTORATION);
	
	effect eBad = GetFirstEffect(oPlayer);
	ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectResurrection(),oPlayer);
	ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectHeal(GetMaxHitPoints(oPlayer)), oPlayer);
	 
	//Search for negative effects
	while(GetIsEffectValid(eBad))
	{
	    if (GetEffectType(eBad) == EFFECT_TYPE_ABILITY_DECREASE ||
	        GetEffectType(eBad) == EFFECT_TYPE_AC_DECREASE ||
	        GetEffectType(eBad) == EFFECT_TYPE_ATTACK_DECREASE ||
	        GetEffectType(eBad) == EFFECT_TYPE_DAMAGE_DECREASE ||
	        GetEffectType(eBad) == EFFECT_TYPE_DAMAGE_IMMUNITY_DECREASE ||
	        GetEffectType(eBad) == EFFECT_TYPE_SAVING_THROW_DECREASE ||
	        GetEffectType(eBad) == EFFECT_TYPE_SPELL_RESISTANCE_DECREASE ||
	        GetEffectType(eBad) == EFFECT_TYPE_SKILL_DECREASE ||
	        GetEffectType(eBad) == EFFECT_TYPE_BLINDNESS ||
	        GetEffectType(eBad) == EFFECT_TYPE_DEAF ||
	        GetEffectType(eBad) == EFFECT_TYPE_PARALYZE ||
	        GetEffectType(eBad) == EFFECT_TYPE_NEGATIVELEVEL)
	        {
	            //Remove effect if it is negative.
	            RemoveEffect(oPlayer, eBad);
	        }
	    eBad = GetNextEffect(oPlayer);
	}
	//Fire cast spell at event for the specified target
	SignalEvent(oPlayer, EventSpellCastAt(OBJECT_SELF, SPELL_RESTORATION, FALSE));
	ApplyEffectToObject(DURATION_TYPE_INSTANT, eVisual, oPlayer);
}



*/


	
	


/*
*/