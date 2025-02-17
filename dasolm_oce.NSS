#include "dasolm_inc"

void main()
{
	// destroy any companions, henchmen, etc.
	// what happens if i leave this?

	object oAssociate = GetEnteringObject();
	if ( GetIsObjectValid( GetMaster(oAssociate)  ) )
	{
		RemoveAllEffects(oAssociate,0);//Removing all effects
		ApplyEffectToObject(DURATION_TYPE_PERMANENT,
		ExtraordinaryEffect(EffectSetScale(0.7,0.7,0.7)),oAssociate);
		SetMovementRateFactor(oAssociate,0.75);
	}

	
	// only run the following on PCs
	object oPC = GetFirstEnteringPC();	
	if (!GetIsPC(oPC)) return;
	//set GUI
	while(GetIsObjectValid(oPC))
	{
		if(GetIsPC(oPC))
		{
			DasOL_OCE(oPC);
		}
	oPC = GetNextEnteringPC();
	}
}