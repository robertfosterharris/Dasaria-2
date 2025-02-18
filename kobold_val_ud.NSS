// kobold_val_ud
//
// if reduced to 10hp, val will flee

#include "ginc_misc"

void main()
{
    int nUser = GetUserDefinedEventNumber();
	int nHP;
	object oExit;
	
    if(nUser == EVENT_DAMAGED) // DAMAGED
    {
		nHP = GetCurrentHitPoints( OBJECT_SELF );
		
		if (nHP > 11)
		{
			SetPlotFlag(OBJECT_SELF,TRUE);
			SetCreatureScriptsToSet(OBJECT_SELF, 0);
			oExit = GetNearestObjectToLocation(OBJECT_TYPE_DOOR, GetLocation(OBJECT_SELF));
			SpeakString("You're going to get me killed! I am outta here! ");
			ClearAllActions(TRUE);
			AssignCommand(OBJECT_SELF, ActionForceExit(GetTag(oExit), TRUE));
		}
    }
}