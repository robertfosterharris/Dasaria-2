// gui_d2_bio_update
//
// wired 6/15/2011

#include "std_quest_i0"

void main(string sInput)
{
	object oPC = GetOwnedCharacter(OBJECT_SELF);
	object oJournal = std_journal_get( oPC );
	
	SetDescription(oPC, sInput+"\n\n");	
	SetLocalString(oJournal,"DESCRIPTION",sInput+"\n\n");
	WriteTimestampedLogEntry("PC BIO CHANGE: " +GetFirstName(oPC)+" "+GetLastName(oPC)+" ["+GetPCPublicCDKey(oPC)+"] to " + sInput);
}