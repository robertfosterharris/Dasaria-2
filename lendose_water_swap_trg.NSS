// lendose_water_swap_trg
//	wired 02/28/2010

#include "ginc_partymath"

void main()
{
	object oPC = GetEnteringObject();
	object oLowWater =	GetObjectByTag("lendose_low_water");
	object oBucket =	GetObjectByTag("lendose_tyrak_bucket");
	
	// 	the lake is low and somebody steps out 
	//	of the cavewho just filled the lake
	if (GetHighJournalEntry("phoenix_dryad",oPC) == 2)
	{	
		SendMessageToPC(oPC,"From up here on the hillside you can see that the water level in Daphne's pool has risen.");
		
		if (	!GetIsObjectValid(GetObjectByTag("lendose_high_water"))	)
		{	
			object oBigWater =	CreateObject(OBJECT_TYPE_PLACEABLE,"lendose_high_water",GetLocation(GetObjectByTag("wp_lendose_highwater")));
			DestroyObject(oBigWater,300.0f);
			if ( GetIsObjectValid(oLowWater) ) ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectDeath(),oLowWater);
			if ( GetIsObjectValid(oBucket) ) ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectDeath(),oBucket);	
		}
		
	}
}