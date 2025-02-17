//  ON ACQUIRE SCRIPT
//
//  GIVES PARTY A MYSTERIOUS DOLL QUEST IF THEY ARE BETWEEN LEVELS 10 AND 15 AND DO NOT HAVE THE QUEST
//
//  ROBERT HARRIS   ROBERTHARRIS@ROBERTHARRIS.COM   11/13/2011
//
#include "ginc_item_script"
#include "ginc_partymath"

void main()
{
	int nEntry;
    object oItem;
	object oPC;

    oItem = GetModuleItemAcquired();
    oPC = GetModuleItemAcquiredBy();
	nEntry = GetJournalEntry("daris_jess", oPC);
		
	if (nEntry == 0 && PartyLevelCheck(oPC, 10, 15))
	{
		AddJournalQuestEntry("daris_jess", 1, oPC, TRUE);
	}
}