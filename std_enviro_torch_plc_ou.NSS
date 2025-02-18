/*


*/



#include "std_enviro_torch_i0"


// Light returns to default after this long
string 	cfg_torch_respawn = "cfg_torch_respawn";

// Not currently used -
// 	0 = torch starts unlit
//  1 = torch starts lit
string	cfg_torch_lit = "cfg_torch_lit";

// Not currently used - respawn for placeable
string cfg_plc_respawn = "cfg_plc_respawn";




	
	
	
void	main()
	{
	object oTorch = OBJECT_SELF;
	object oPC = GetLastUsedBy();
	
	
	object oLeftHand = GetItemInSlot(INVENTORY_SLOT_LEFTHAND, oPC); 

	
	// If you have a torch, always light the thing
	if ( GetTag(oLeftHand) == "NW_IT_TORCH001")
		{
		
		// Allready lit, nothing to do (don't add another delay!)
		if ( std_enviro_torch_IsLit(oTorch) )
			return;
			
		// Light it
		std_enviro_torch_light( oTorch );
			
		// Delay and return the thing to unlit
		float respawn = GetLocalFloat( oTorch, cfg_torch_respawn);
		if ( respawn > 10.0 )
			{
			DelayCommand( respawn, 
				std_enviro_torch_extinguish( oTorch )			
				);	
			}
	
		return;
		}
	
	//	If you do not have a torch, put it out
	std_enviro_torch_extinguish( oTorch );	
	}



/*
*/