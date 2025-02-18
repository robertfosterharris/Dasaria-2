/*
	States:
		0 = unlit
		1 = lit
*/


#include "std_enviro_torch_i0"


void	main( string tag, int state )
	{
	
	object oTorch = GetObjectByTag( tag );
	
	// Stop early if no torch
	if ( !GetIsObjectValid(oTorch) )
		return;
		
	if ( state == 0 )			
		std_enviro_torch_extinguish( oTorch );
		
	if ( state == 1 )			
		std_enviro_torch_light( oTorch );
	}

/*
*/