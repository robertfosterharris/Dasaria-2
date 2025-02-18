/*

	Set local string to the tag of a WP
	"std_plc_transition_target" 
	
	10/03/2012		RFH		CODE TO JUMP ASSOCIATES

*/

void main()
{

	string target = "std_transition_target";
	string k_message = "std_transition_message";
	
	object oPC = GetLastUsedBy();
	object oLadder = OBJECT_SELF;
	
	string tag = GetLocalString( oLadder, target);
	if ( tag == "")	return;
		
	object oWP = GetWaypointByTag( tag );
	if ( !GetIsObjectValid( oWP ) )	return;
		
	string sMessage = GetLocalString( oLadder, k_message);
	if ( sMessage != "" ) FloatingTextStringOnCreature( sMessage, oPC, FALSE );
		
	AssignCommand(oPC, JumpToObject(oWP, 0));
//
//	JUMP ALL ASSOCIATES (ANIMAL COMPANIONS, DOMINATED, FAMILAR, HENCHMEN AND SUMMONS)
//
	int nAssociateType;
	int nAssociateNumber;
	object oAssociate;
	
	for (nAssociateType = 1; nAssociateType < 6; nAssociateType++)
	{
		nAssociateNumber = 1;
		oAssociate = GetAssociate(nAssociateType, oPC, nAssociateNumber);
		while (GetIsObjectValid(oAssociate))
		{
			AssignCommand(oAssociate, JumpToObject(oWP, FALSE));
			nAssociateNumber++;
			oAssociate = GetAssociate(nAssociateType, oPC, nAssociateNumber);
		}
	}
}