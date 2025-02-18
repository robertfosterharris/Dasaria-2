// wired 2012/06/02 launch a new convo so
// i don't need to go back and edit every
// door to include this convo in order to
// add the 'knock' feature

#include "ginc_playerhousing"

void main()
{
	object oPC = GetLastUsedBy();	
	//SetLocalString(OBJECT_SELF,"dialog","ph_convo_knock_list");	
	ActionStartConversation(oPC, "ph_cnv_enter", TRUE,TRUE,FALSE);
}