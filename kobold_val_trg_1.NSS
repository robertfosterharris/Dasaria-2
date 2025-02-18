// kobold_vala_trg_2
//
// when val hits this trigger, she will lead the PCs to the ruins
//
void DoActions()
{
	object oRuin = GetNearestObjectByTag("wp_val_dest");
	
	//SendMessageToPC(GetFirstPC(),"Running!");
	
	ActionSpeakString("Follow me, I know the way to the ruin.");
	ActionForceMoveToObject(oRuin,FALSE);
    ActionDoCommand(SetCommandable(TRUE));
    SetCommandable(FALSE);
}

void main()
{
	object oVal = GetEnteringObject();
	
	//SendMessageToPC(GetFirstPC(),"Running!");
	
	if (GetTag(oVal) == "kobold_val" && GetLocalInt(oVal,"nTrg1Run") != 1)
	{
		 SetLocalInt(oVal,"nTrg1Run",1);
		 AssignCommand(oVal,ClearAllActions());
		 AssignCommand(oVal, DoActions());
	}
}