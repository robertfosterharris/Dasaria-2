// cear_tc_lib_orbo_di

#include "ginc_partymath"
#include "x0_i0_partywide"

void main()
{
    object oItem	=	GetInventoryDisturbItem();
    object oPC		=	GetLastDisturbed();
    int nType		=	GetInventoryDisturbType();
	int nEntry 		= 	GetHighJournalEntry("cear_tc_orbus",oPC);

	// we're supposed to be putting the egg in the nes and we do so
	if (	(GetTag(oItem) == "lib_orb") &&
			(nEntry == 1) &&
			(nType == INVENTORY_DISTURB_TYPE_ADDED)	)
	{
		object oOrb = CreateObject(OBJECT_TYPE_PLACEABLE,"lib_orbus_scurious",GetLocation(GetObjectByTag("wp_orbus")),TRUE);
		AddJournalQuestEntry("cear_tc_orbus",2,oPC,TRUE,FALSE,FALSE);
		SetPlotFlag(oItem,FALSE);
		DestroyObject(oItem);
		GiveGoldToCreature(oPC,300,TRUE);		
		GiveXPToAll(oPC, GetJournalQuestExperience("cear_tc_orbus"));
		DelayCommand(10.0f,DestroyObject(oOrb));
	}

}