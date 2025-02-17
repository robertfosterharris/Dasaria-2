//gui_d2_bio_edit
//
// wired 6/15/2011

#include "std_quest_i0"

void main()
{
	object oPC = GetOwnedCharacter(OBJECT_SELF);
	object oJournal = std_journal_get( oPC );

	string sDesc = GetLocalString( oJournal, "DESCRIPTION");

	SetGUIObjectText(oPC,"D2_BIO_EDIT","BIO_TEXT",0, sDesc );
	SetGUIObjectText(oPC,"D2_BIO_EDIT","BIO_NAME",0, GetFirstName(oPC)+" "+GetLastName(oPC) );
	
}