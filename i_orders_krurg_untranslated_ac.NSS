void main()
{
	object oPC;
	
	oPC = GetItemActivator();
	AssignCommand(oPC, ActionStartConversation(oPC, "wr_krurg_orders_convo"));
}