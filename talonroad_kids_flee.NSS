// run for the hills
//
#include "ginc_param_const"
#include "ginc_actions"

void KidFleeToExit(object oPC)
{
	SetLocalObject(OBJECT_SELF,"FREED_BY",oPC);
	JumpToObject(GetNearestObjectByTag("wp_drak_kids_escape"));
	SetCreatureScriptsToSet(OBJECT_SELF, 0);
	DelayCommand(10.0f,DestroyObject(OBJECT_SELF));
	AssignCommand(OBJECT_SELF, ActionForceExit("WP_EXIT", TRUE));
}

void main()
{
	object oPC = GetPCSpeaker();	
	AssignCommand(GetNearestObjectByTag("drak_caves_kid_a"),KidFleeToExit(oPC));
	AssignCommand(GetNearestObjectByTag("drak_caves_kid_b"),KidFleeToExit(oPC));
	AssignCommand(GetNearestObjectByTag("drak_caves_kid_c"),KidFleeToExit(oPC));
}