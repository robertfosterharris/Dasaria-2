//
//	06/15/2007	RFH		SET PICKPOCKETABLE FLAG BASED ON ITEM WEIGHT
//	11/18/2007  wired	added code for womble's droppable gold
//	06/04/2009	RFH		LIMIT NUMBER OF CONTAINERS
//	11/16/2009	RFH		REMOVED CODE TO DELETE CRAFTING ITEMS


#include "rw_coinage"

const int DASARIA_MAXIMUM_NUMBER_OF_CONTAINERS = 3;

void main()
{
	int bDelete;
	int nNumberOfContainers;
	object oItem;
	object oPC;
	object oSource;
	string sTag;
//
//	RUN DEFAULT ON ACQUIRE EVENT
//
	ExecuteScript("x2_mod_def_aqu", OBJECT_SELF);
	
	oPC = GetModuleItemAcquiredBy();

	if (GetIsPC(oPC) && !GetIsDM(oPC))
	{
		oItem = GetModuleItemAcquired();

		//	ACQUIRED AN ITEM
		if (GetIsObjectValid(oItem))
		{
			//	ITEMS WEIGHING MORE THAN 2 POUNDS CAN NOT BE PICKPOCKETED
			if (GetWeight(oItem) > 20) SetPickpocketableFlag(oItem, FALSE);
		
			//	LIMIT THE NUMBER OF CONTAINERS PER CHARACTER
			if (GetBaseItemType(oItem) == BASE_ITEM_LARGEBOX)
			{
				nNumberOfContainers = GetLocalInt(oPC, "nNumberOfContainers") + 1;
				SetLocalInt(oPC, "nNumberOfContainers", nNumberOfContainers);
				if (nNumberOfContainers > DASARIA_MAXIMUM_NUMBER_OF_CONTAINERS)
				{
					SendMessageToPC(oPC, "You can not carry more than " + IntToString(DASARIA_MAXIMUM_NUMBER_OF_CONTAINERS) + " containers.");
					oSource = GetModuleItemAcquiredFrom();
					AssignCommand(oPC, ClearAllActions(TRUE));
					
					//	PUT THE ITEM BACK WHERE YOU GOT IT
					if (GetIsObjectValid(oSource))
					{
						AssignCommand(oPC, ActionGiveItem(oItem, oSource, TRUE));
					}
					//	OR DROP IT ON THE GROUND
					else
					{
						AssignCommand(oPC, ActionPutDownItem(oItem));
					}
					DelayCommand(0.2f, SetCommandable(FALSE, oPC));
					DelayCommand(2.0f, SetCommandable(TRUE, oPC));
				}
			}
		}
		//	ACQUIRED GOLD
		else
		{
			CalculateGoldWeight(oPC);
		}
	}
}