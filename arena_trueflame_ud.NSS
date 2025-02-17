//  arena_trueflame_ud
//	wired 2008/02/29
//
//  riffing off RFH's vampire quest UD
//
#include "ginc_item"

void main()
{
	int nEvent;
	object oPC;
	object oWeapon;
	
	nEvent = GetUserDefinedEventNumber();
	switch(nEvent)
	{
		case EVENT_DAMAGED:
		{
			oPC = GetLastAttacker();
			oWeapon = GetLastWeaponUsed(oPC);
			string sTag = GetTag(oWeapon);		
			
			if(sTag == "cd_chn_torch_unlit")
			{
				EquipNewItem(oPC,"cd_chn_torch_lit",INVENTORY_SLOT_RIGHTHAND,TRUE);
				AddJournalQuestEntry("cd_chn_fire",3,oPC,TRUE);
				FloatingTextStringOnCreature("The unlit firestick suddenly catches fire in your hand.", oPC, FALSE);
			}
			if (sTag != "cd_chn_torch_lit" &&
				sTag != "cd_chn_torch_unlit" )
			{
				FloatingTextStringOnCreature("Use the Cuhannan fire stick, " + GetFirstName(oPC) + ".", oPC, FALSE);
			}
		}
		break;
	}
}