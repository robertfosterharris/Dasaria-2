/*
*/

#include "dt2_i0_main"

void main()
	{
    // * This code runs when the item is acquired
    object oPC      = GetModuleItemAcquiredBy();
    object oItem    = GetModuleItemAcquired();
    int iStackSize  = GetModuleItemAcquiredStackSize();
    object oFrom    = GetModuleItemAcquiredFrom();

	dt2_token_generate( oItem, oPC );
	
	DestroyObject( oItem, 0.0, FALSE );

	}
	
	
/*
*/