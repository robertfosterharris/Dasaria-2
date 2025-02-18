// wired 2012/07/14

void main()
{
	object oPC = GetLastUsedBy();	
	ActionStartConversation(oPC, "ph_decor_cnv_ou", TRUE,TRUE,FALSE);
}