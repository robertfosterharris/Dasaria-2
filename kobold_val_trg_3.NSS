// kobold_vala_trg_3
//
// when val hits this trigger, she will destroy herself
//

#include "ginc_misc"

void main()
{
	object oVal = GetEnteringObject();
	object oPC;
	object oExit;
	
	if (GetResRef(oVal) == "kobold_val" )
	{
			oPC = GetMaster(oVal);
			RemoveHenchman(oPC,oVal);
			SetPlotFlag(oVal,TRUE);
			SetCreatureScriptsToSet(oVal, 0);
			oExit = GetNearestObjectToLocation(OBJECT_TYPE_DOOR, GetLocation(OBJECT_SELF));
			AssignCommand(oVal,SpeakString("Where are you taking me?! I thought we were headed for the ruin?!  I am outta here! "));
			AssignCommand(oVal, ActionForceExit(GetTag(oExit), TRUE));
	}
}