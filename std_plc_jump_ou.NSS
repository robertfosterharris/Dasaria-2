//	std_plc_jump_ou
//	wired 04/31/10
//
//	why YET ANOTHER jumper?
//	player housing application
//	* 	uses getnearestobject by tag because we're using an ipoint target
//		i'm already using the only waypoint allowed to find entrance
//	*	takes companions/henchmen across non-area transitions
//
// wired 02/04/12 block mounted transition into interior areas unless so marked

#include "std_inc_mounts"

void main()
{
	object oPC = GetLastUsedBy();
	object oDoor1 = GetNearestObject(OBJECT_TYPE_DOOR,oPC);
	AssignCommand(oDoor1,ActionOpenDoor(oDoor1));
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
		
	// block mounted transition into interior areas unless so marked
	if (!GetCanTransition(oPC, GetArea(oWP))) return;		
	
	object oDoor2 = GetNearestObject(OBJECT_TYPE_DOOR,oWP);	
	AssignCommand(oDoor2,ActionOpenDoor(oDoor2));
		
	string sMessage = GetLocalString( OBJECT_SELF, k_message);
	if ( sMessage != "" )
		FloatingTextStringOnCreature( sMessage, oPC, FALSE );
	
	AssignCommand( oPC,JumpToObject( oWP, 0 )	);
		
	if (GetIsObjectValid(oPet)) AssignCommand(oPet,JumpToObject(oWP));
	if (GetIsObjectValid(oDom)) AssignCommand(oDom,JumpToObject(oWP));	
	if (GetIsObjectValid(oFam)) AssignCommand(oFam,JumpToObject(oWP));
	if (GetIsObjectValid(oHnc)) AssignCommand(oHnc,JumpToObject(oWP));
	if (GetIsObjectValid(oSum)) AssignCommand(oSum,JumpToObject(oWP));;
}