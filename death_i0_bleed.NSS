/*
*/
// wired 02/10/12	dismount a mounted pc before bleeding anims

#include "std_i0_markofdeath"
#include "std_inc_mounts"


// Hook these into the module events
void 	death_event_OnHeartbeat( object oPC );
void	death_event_OnDying( object oPC );
void	death_event_OnDeath( object oPC );
void	death_event_OnLogin( object oPC );



// These are util functions
void	bleeding_stop( object oPC );
void 	bleeding_heartbeat( object oPC );
void    bleeding_cry(object oPC);




// These variable names suck and should probably be replaced
string bleeding_var = "das2_mod_j4_bleeding";
string bleeding_HP = "das2_mod_j4_bleeding_HP";



/*
*/







void    bleeding_cry(object oPC)
{
    switch (d6())
        {
        case 1:
        	PlayVoiceChat (VOICE_CHAT_PAIN1, oPC);
        	break;

        case 2:
	        PlayVoiceChat (VOICE_CHAT_PAIN2, oPC);
    	    break;

        case 3:
        	PlayVoiceChat (VOICE_CHAT_PAIN3, oPC);
        	break;

        case 4:
        	PlayVoiceChat (VOICE_CHAT_HEALME, oPC);
        	break;

        case 5:
        	PlayVoiceChat (VOICE_CHAT_NEARDEATH, oPC);
        	break;

        case 6:
        	PlayVoiceChat (VOICE_CHAT_HELP, oPC);
        	break;
        }
	}



	
	
	
	





	
	
	
	
	
	
	


void	bleeding_stop( object oPC )
	{
	DeleteLocalInt( oPC, bleeding_var);
	DeleteLocalInt( oPC, bleeding_HP);
	
	// Stop the knockdown animation - required?
	AssignCommand( oPC,
		ClearAllActions(TRUE)
		);
	}
	
	
	
	
		
	
	
	

void	bleeding_heartbeat_stable( object oPC )
	{
	
	// If they are NOT bleeding (stable or dead, but less than 0 HP)
	
	// Give them a chance to respawn
	string message = "Press OK to respawn.  Press cancel to dismiss this screen.";
	DisplayMessageBox( oPC, 0, message, 
		"gui_death_respawn_ok", "gui_death_respawn_cancel",
		 TRUE, "", 6603, "", 0, "" 
		 );

	/*
	// Check for spontaneous recovery
	if ( d100() <= GetAbilityModifier(ABILITY_CONSTITUTION, oPC) )
		{
		SendMessageToPC(oPC, "Spontaneous recovery");
		effect eHeal = EffectHeal(1);
		ApplyEffectToObject(DURATION_TYPE_INSTANT, eHeal, oPC);
		}	
	*/

	}
	
	
	
	
	
	
	
	
	
	

void	bleeding_heartbeat_bleeding( object oPC )
	{
	// Check for healing
	if ( GetCurrentHitPoints(oPC) > GetLocalInt( oPC, bleeding_HP) )
		{
		SendMessageToPC(oPC, "The bleeding has stopped");
		bleeding_stop( oPC );
		return;
		}


	// Check for stabilization, copied straight from D1
	if (d100() <= 10 + (GetAbilityModifier(ABILITY_CONSTITUTION, oPC) * 5))
		{
		SendMessageToPC(oPC, "You have stabilized");
		bleeding_stop( oPC );
		return;		
		}
			
	// Feedback
	bleeding_cry( oPC );
	SendMessageToPC(oPC, "Bleeding damage...");						
	
	// Damage	
	effect eDamage = EffectDamage(1);	
	ApplyEffectToObject(DURATION_TYPE_INSTANT, eDamage, oPC);	
	}
	
	
	

	

	
	
	
	
	

void	death_event_OnDying( object oPC )
	{
	
	if (GetIsMounted(oPC)) OnMountedPCDeath(oPC);	
	
	SendMessageToPC(oPC, "You start bleeding");

	SetLocalInt( oPC, bleeding_var, 1);
	SetLocalInt( oPC, bleeding_HP, GetCurrentHitPoints(oPC) );

	PlayCustomAnimation(oPC,"proneb",1);
	

	//ApplyEffectToObject( DURATION_TYPE_PERMANENT, EffectBlindness(), oPC );		
	}

	
	
	
	
	
	
	
	
	
	
	
	
void	death_event_OnDeath( object oPC )
	{
	// Give them the mark of death
	std_death_mark_give( oPC );			
	
	// Stop any bleeding
	bleeding_stop( oPC );	
	}
	
	
	
	
	
	
	
	
	


void 	death_event_OnHeartbeat( object oPC )
	{
	
	// We need to check for bleeding and negative HP
	// Negative HP check is faster so we do that 1st

	// Are we are incapacitated?
	if ( GetCurrentHitPoints(oPC) > 0 )
		{
		
		// If positive HP, the only think we need to check is if
		// they just got healed, if so, stop bleeding
		if ( GetLocalInt( oPC, bleeding_var) == 1 )
			bleeding_stop( oPC );
		
		return;
		}
	
	// run only if hp < 0
	if (GetIsMounted(oPC)) OnMountedPCDeath(oPC);	

	// Negative HP is always prone, beeding or not		
	PlayCustomAnimation(oPC,"proneb",1);		
		
		
	// If they are bleeding
	if ( GetLocalInt( oPC, bleeding_var) == 1 )	
		bleeding_heartbeat_bleeding(oPC);
	else
		bleeding_heartbeat_stable(oPC);

	}
	
	
	
	
	
	
		
	
	
	
	
	
	
void	death_event_OnLogin( object oPC )
	{
	

	if ( std_death_mark_check(oPC) )
		{
		effect e = EffectDeath();
		ApplyEffectToObject(DURATION_TYPE_PERMANENT, e, oPC);	
		}
		
	}
	
	
	
	

	
	
	
	
	
/*
*/