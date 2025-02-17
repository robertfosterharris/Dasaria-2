//n_pit_trap
//General script for a pit trap. Will delete a placeable covering a pit and jump party to another location.
//Loki - 06/08/12
#include "ginc_actions"

void main()
{
object oPC = GetEnteringObject();
object oPitWP = GetWaypointByTag(GetLocalString(OBJECT_SELF, "sPitWP"));
object oCoverWP = GetWaypointByTag(GetLocalString(OBJECT_SELF, "sCoverWP"));
object oWP = GetWaypointByTag(GetLocalString(OBJECT_SELF, "std_transition_target"));
string sCover = GetLocalString(OBJECT_SELF, "sCover");
string sBounding = GetLocalString(OBJECT_SELF, "sBounding");
location lPitWP = GetLocation(oPitWP);
location lCoverWP = GetLocation(oCoverWP);

effect eDamage = EffectDamage(d6(1), DAMAGE_TYPE_BLUDGEONING);

DestroyObject(GetObjectByTag(sCover), 0.1f);
AssignCommand(GetArea(OBJECT_SELF),DelayCommand(300.f,ActionCreateObject(OBJECT_TYPE_PLACEABLE, sCover, lCoverWP)));
AssignCommand(GetArea(OBJECT_SELF),DestroyObject(CreateObject(OBJECT_TYPE_PLACEABLE, sBounding, lPitWP), 295.f));
		
		
oPC = GetFirstObjectInShape(SHAPE_SPHERE, 4.0, lPitWP);

while(GetIsObjectValid(oPC))
	{
	if (GetIsPC(oPC))
		{
		AssignCommand(oPC, JumpToObject( oWP, 0 ));
		FloatingTextStringOnCreature("You tumble into a dark pit", oPC, TRUE);
		AssignCommand(GetArea(OBJECT_SELF),DelayCommand(1.0f,ApplyEffectToObject(DURATION_TYPE_INSTANT, eDamage, oPC)));
		AssignCommand(oPC, PlayVoiceChat(VOICE_CHAT_PAIN1,oPC));
    	}
	oPC = GetNextObjectInShape(SHAPE_SPHERE, 4.0, lPitWP);
	} 	
	
}