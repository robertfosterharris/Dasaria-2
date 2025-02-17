// Deph: Jay's script - it's for the Shai Quest mushroom that sends the PCs into the Spirit World.
//
//	07/01/2007		RFH		REMOVE KEYS ON EXIT

#include "nw_i0_plot"

void dont_do_drugs(object oPC, object oTarget) 
	{
	location lTarget  = GetLocation(oTarget);  
	AssignCommand(oPC, ClearAllActions());  
	AssignCommand(oPC, ActionJumpToLocation(lTarget));  
	FadeFromBlack(oPC); 
	}    
   
void main()  
	{  
	object oPC;  
      
	oPC = GetItemActivator();  
	FloatingTextStringOnCreature("The leaf has a nice, tangy taste but soon you feel light headed and begin to drift off...", oPC);  
	  
	// Check for using it out of the intended area
	if ( GetTag(GetArea(oPC)) != "spiritworld_sanctuary")
		{
		FloatingTextStringOnCreature("... ugh.  Horrible.", oPC);  
		
		return;
		}
      

	// Find the waypoint
	object oTarget = GetWaypointByTag("wp_azek");       
	if ( !GetIsObjectValid( oTarget) )  
		return;  
       
    
	DelayCommand( 4.0,  
		FadeToBlack(oPC) 
		);  
       
	DelayCommand( 10.0,  
		dont_do_drugs( oPC, oTarget) 
		); 
		
		
   	}  
  