void main()
{
	object oPC;
	
	oPC = GetItemActivator();
	AssignCommand(oPC, ActionStartConversation(oPC, "kragvoks_orders_convo"));
}