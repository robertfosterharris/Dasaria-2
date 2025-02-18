//Shhh!
//Private convo for bard in Lendose
//Look into adding this as a hook to default script in the Das module
//- atharin

//#include "nw_i0_generic"
#include "ginc_behavior"
void main()
{
object oPC = GetLastSpeaker();
if (GetIsDead(OBJECT_SELF) == TRUE)  {  return;  }	
    // notify walkwaypoints that we've been stopped and need to restart.
    SetLocalInt(OBJECT_SELF, VAR_KICKSTART_REPEAT_COUNT, 100);

ActionStartConversation(oPC, "", TRUE, TRUE);

}