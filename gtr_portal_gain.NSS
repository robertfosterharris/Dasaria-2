// gtr_portal_gain


#include "std_persist_i0"

void main()
{
	object oPC = GetEnteringObject();
	if (!GetIsPC(oPC)) return;
	
	string sPortalWPTag = GetLocalString(OBJECT_SELF,"sPortalWPTag");
	object oJournal = std_journal_get( oPC );
		
	SetLocalInt(oJournal, sPortalWPTag, 1);

}