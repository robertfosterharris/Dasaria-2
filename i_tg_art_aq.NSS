/*
	Automatically destroy cearian dawn
*/
void main()
{
	
  	// * This code runs when the item is acquired
   	object oPC      = GetModuleItemAcquiredBy();
   	object oItem    = GetModuleItemAcquired();

	if( GetHitDice(oPC) > 11 )
	{	
		SendMessageToPC(oPC,"Object Destroyed: Quest item out of level range.");
		DestroyObject( oItem );
	}

}
		