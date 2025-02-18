//trg_port_pet
//wired 11/04/2008
//port pet to player when passing through non-contiguous doors

void main()
{
	object oPC = GetEnteringObject();
	if (!GetIsPC(oPC)) return;

	object oPet = 	GetAssociate(ASSOCIATE_TYPE_ANIMALCOMPANION,oPC);
	object oDom = 	GetAssociate(ASSOCIATE_TYPE_DOMINATED,oPC);
	object oFam = 	GetAssociate(ASSOCIATE_TYPE_FAMILIAR,oPC);	
	object oHnc = GetAssociate(ASSOCIATE_TYPE_HENCHMAN,oPC);	
	object oSum = 	GetAssociate(ASSOCIATE_TYPE_SUMMONED,oPC);	
	
	if (GetIsObjectValid(oPet) && (GetLastAssociateCommand(oPet) != ASSOCIATE_COMMAND_STANDGROUND)) AssignCommand(oPet,JumpToObject(oPC));
	if (GetIsObjectValid(oDom) && (GetLastAssociateCommand(oDom) != ASSOCIATE_COMMAND_STANDGROUND)) AssignCommand(oDom,JumpToObject(oPC));	
	if (GetIsObjectValid(oFam) && (GetLastAssociateCommand(oFam) != ASSOCIATE_COMMAND_STANDGROUND)) AssignCommand(oFam,JumpToObject(oPC));
	if (GetIsObjectValid(oHnc) && (GetLastAssociateCommand(oHnc) != ASSOCIATE_COMMAND_STANDGROUND)) AssignCommand(oHnc,JumpToObject(oPC));
	if (GetIsObjectValid(oSum) && (GetLastAssociateCommand(oSum) != ASSOCIATE_COMMAND_STANDGROUND)) AssignCommand(oSum,JumpToObject(oPC));
}
