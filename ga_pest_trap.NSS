



void main()
{

	object oTrigger = OBJECT_SELF;
	object oNPC_Pest = GetEnteringObject();
	object oTest;
	object oWP = GetWaypointByTag("Pest_Trap");
	
	
	if (GetIsPC(oNPC_Pest)) return;
	
	oTest = GetFirstObjectInArea(oTrigger);
	
	while(GetIsObjectValid(oTest))
	    {
	         // Destroy any objects tagged "DESTROY"
	         if(GetIsPC(oTest))
	         {
	             
			 	AssignCommand(oNPC_Pest, ClearAllActions());
			 	AssignCommand(oNPC_Pest, ActionMoveToObject(oWP));
			 
			 
	         }
	         oTest = GetNextObjectInArea(oTrigger);
	    }
	


}