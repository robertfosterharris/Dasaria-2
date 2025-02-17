// Deph: Jay's script - it's for the Shai Quest mushroom that sends the PCs into the Spirit World.

  
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
	FloatingTextStringOnCreature("You eat the foul smelling mushroom and pretty soon you start feeling dizzy, as your eyes loose focus...", oPC);  
	  
	// Check for using it out of the intended area
	if ( GetTag(GetArea(oPC)) != "thrallsgate_shai_2")
		{
		FloatingTextStringOnCreature("... ugh.  Horrible.", oPC);  
		
		return;
		}
      

	// Find the waypoint
	object oTarget = GetWaypointByTag("wp_mushroom");       
	if ( !GetIsObjectValid( oTarget) )  
		return;  
       
    
	DelayCommand( 4.0,  
		FadeToBlack(oPC) 
		);  
       
	DelayCommand( 10.0,  
		dont_do_drugs( oPC, oTarget) 
		); 
		
		
   	}  
  