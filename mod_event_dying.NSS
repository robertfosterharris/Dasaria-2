/*
*/
// wired 2/12/2012 destroy saddle when possible

#include "death_i0_bleed"

 
void main()
	{
	object oPC = GetLastPlayerDying();
	DestroyObject(GetLocalObject(oPC,"oSaddle"));

	// Notify bleeding / death
	death_event_OnDying( oPC );
	
	}
	
	
/*
*/