void main()
{
	object oPC = GetClickingObject();
	
	string target = "std_transition_target";
	string k_message = "std_transition_message";

	object oPet = 	GetAssociate(ASSOCIATE_TYPE_ANIMALCOMPANION,oPC);
	object oDom = 	GetAssociate(ASSOCIATE_TYPE_DOMINATED,oPC);
	object oFam = 	GetAssociate(ASSOCIATE_TYPE_FAMILIAR,oPC);	
	object oHnc = 	GetAssociate(ASSOCIATE_TYPE_HENCHMAN,oPC);	
	object oSum = 	GetAssociate(ASSOCIATE_TYPE_SUMMONED,oPC);	
	
	string tag = GetLocalString( OBJECT_SELF, target);
	if ( tag == "")
		{
		// panic!		
		return;
		}
	
	object oWP = GetNearestObjectByTag( tag );
	if ( !GetIsObjectValid( oWP ) )
		{
		// panic
		return;
		}
		
	string sMessage = GetLocalString( OBJECT_SELF, k_message);
	if ( sMessage != "" )
		FloatingTextStringOnCreature( sMessage, oPC, FALSE );
	
	DelayCommand(1.0,AssignCommand( oPC,JumpToObject( oWP, 0 )	));
		
	if (GetIsObjectValid(oPet)) DelayCommand(1.5,AssignCommand(oPet,JumpToObject(oWP)));
	if (GetIsObjectValid(oDom)) DelayCommand(1.5,AssignCommand(oDom,JumpToObject(oWP)));	
	if (GetIsObjectValid(oFam)) DelayCommand(1.5,AssignCommand(oFam,JumpToObject(oWP)));
	if (GetIsObjectValid(oHnc)) DelayCommand(1.5,AssignCommand(oHnc,JumpToObject(oWP)));
	if (GetIsObjectValid(oSum)) DelayCommand(1.5,AssignCommand(oSum,JumpToObject(oWP)));;
}