// i_dmwand_changedeity_ac
// wired 01/25/09
void main()
{
	object oDM;
	object oTarget;	

	oDM = GetItemActivator();
	if (!GetIsDM(oDM)) return;
	
	oTarget = GetItemActivatedTarget();
	SetLocalObject(oDM,"deity_switch_player",oTarget);
	AssignCommand(oDM,ActionStartConversation(oDM,"dmwand_cnv_setdeity",TRUE,FALSE));
}