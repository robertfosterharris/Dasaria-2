//	ONCOVERSATION SCRIPT THAT ALLOWS YOU TO PICK UP A CREATURE
//	THEN STORE THEM AS AN INVENTORY ITEM (RFH_POKEMON).
//
//	1/20/2007	ROBERT HARRIS	ROBERTHARRIS@ROBERTHARRIS.COM
//	
void main()
{
	object oCreature;
	object oItem;
	object oPC;
	vector vPosition;
    
    if (GetListenPatternNumber() == -1)
    {
		oCreature = OBJECT_SELF;
		oPC = GetLastSpeaker();
		oItem = CreateItemOnObject("rfh_pokemon", oPC);

		SetLocalString(oItem, "sCreature", GetResRef(oCreature));
		SetFirstName(oItem, GetName(oCreature));
		SetDescription(oItem, GetDescription(oCreature));
	
		AssignCommand(oPC, ActionMoveToObject(oCreature, TRUE));
		AssignCommand(oPC, SetFacingPoint(GetPosition(oCreature)));
		AssignCommand(oPC, ActionPlayAnimation(ANIMATION_LOOPING_GET_LOW, 1.0, 2.0));
		DestroyObject(oCreature);
	}		
}