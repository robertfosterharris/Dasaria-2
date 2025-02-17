
void main()
{
	object oPC = GetItemActivatedTarget();
	ActionStartConversation(oPC, "lancon_isl_to_port", FALSE, FALSE, TRUE, TRUE);
}