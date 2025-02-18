/*
*/


#include "std_enviro_torch_i0"


int StartingConditional( string tag )
	{
	
	object oTorch = GetObjectByTag( tag );
	
	// Non-existant torches are not lit
	if ( !GetIsObjectValid(oTorch) )
		return FALSE;
		
		
	// All other torches are lit if they are lit
	return std_enviro_torch_IsLit(oTorch);	
	}

/*
*/