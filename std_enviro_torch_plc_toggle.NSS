#include "std_enviro_torch_i0"

void	main()
{
	object oTorch = OBJECT_SELF;
	object oPC = GetLastUsedBy();
	
	
		// Allready lit, nothing to do 
		if ( std_enviro_torch_IsLit(oTorch) )
		{
			std_enviro_torch_extinguish( oTorch ); 
		}
		else
		{			
			// Light it
			std_enviro_torch_light( oTorch );
		}
}