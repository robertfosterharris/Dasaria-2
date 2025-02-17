// ga_increment
// wired 12/28/2008 just what it says

#include "ginc_param_const"

void main(string sTarget, string sVarName)
{
	// Get the PC Speaker - if used from command line, then use OBJECT_SELF
	// In a conversation, OBJECT_SELF refers to the NPC.
	// From the command line, OBJECT_SELF refers to the currently possesed character.
    object oPC = (GetPCSpeaker()==OBJECT_INVALID?OBJECT_SELF:GetPCSpeaker());

	// Find a target by Tag - also supports "$PC", "$OWNED_CHAR", etc. (see list in ginc_param_const)
	// Optional second parameter can be added to change the default target.
	object oTarget = GetTarget(sTarget);

	// If debug text is on, this will let you know the script fired.
	PrettyDebug("Script Fired on target: " + GetName(oTarget) + "!");
	
	// Do stuff here
	SetLocalInt(oTarget,sVarName,GetLocalInt(oTarget,sVarName)+1);
}