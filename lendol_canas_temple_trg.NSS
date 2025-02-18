// lendol_canas_temple_trg
//
// no JE in this area for canite players

#include "ginc_renown"

void main()
{
	object oPC = GetEnteringObject();
	if (getMetaFaction(oPC) == 3)
	{
		RemoveJournalQuestEntry("lendose_ol_canas_temple",oPC,TRUE,FALSE);
	}
}