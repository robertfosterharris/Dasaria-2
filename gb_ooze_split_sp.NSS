// b_<creature>_sp
/*
  This is the custom creature spawn script template.
    
  This can be used to customize creature behavior in three main ways:
 
  - Uncomment the existing lines of code to activate certain common desired
    behaviors from the moment when the creature spawns in.
    
  - Uncomment the user-defined event signals to cause the
    creature to fire events that you can then handle with
    a custom OnUserDefined event handler script.
    
  - Add new code to alter the initial behavior in a more customized way.
    Note the last line which executes the default spawn script which contains
    the standard generic behavior.
*/
// 

#include "NW_I0_GENERIC"
#include "ginc_event_handlers"
#include "ginc_math"

void main()
{
	//SetSpawnInCondition(NW_FLAG_HEARTBEAT_EVENT);        // Fire User Defined Event 1001
	//SetSpawnInCondition(NW_FLAG_PERCIEVE_EVENT);         // Fire User Defined Event 1002
	//SetSpawnInCondition(NW_FLAG_ATTACK_EVENT);           // Fire User Defined Event 1005
	SetSpawnInCondition(NW_FLAG_DAMAGED_EVENT);          // Fire User Defined Event 1006
	//SetSpawnInCondition(NW_FLAG_DISTURBED_EVENT);        // Fire User Defined Event 1008
	//SetSpawnInCondition(NW_FLAG_END_COMBAT_ROUND_EVENT); // Fire User Defined Event 1003
	//SetSpawnInCondition(NW_FLAG_ON_DIALOGUE_EVENT);      // Fire User Defined Event 1004
	//SetSpawnInCondition(NW_FLAG_SPELL_CAST_AT_EVENT);    // Fire User Defined Event 1011
	ExecuteScript(SCRIPT_DEFAULT_SPAWN, OBJECT_SELF);
}