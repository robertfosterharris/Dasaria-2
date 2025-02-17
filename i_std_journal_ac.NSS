// i_std_journal_ac
// wired 10/08/2008
void main()
{
	object oPC = GetItemActivator();
	AssignCommand(oPC,ActionStartConversation(oPC,"mod_cnv_welcome",TRUE,FALSE));
}