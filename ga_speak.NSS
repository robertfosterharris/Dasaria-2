// ga_speak
// wired 02/26/2010
//
//	I want someone outside the conversation to say something

#include "ginc_param_const"
void main(string sTarget, string sShout)
{
	object oTarget = GetTarget(sTarget, TARGET_OWNER);
	AssignCommand(GetNearestObjectByTag(sTarget),SpeakString(sShout));
	
}