/*
//::///////////////////////////////////////////////
//:: Example XP2 OnItemUnAcquireScript
//:: x2_mod_def_unaqu
//:: (c) 2003 Bioware Corp.
//:://////////////////////////////////////////////

    Put into: OnItemUnAcquire Event


//:://////////////////////////////////////////////
//:: Created By: Georg Zoeller
//:: Created On: 2003-07-16
//:://////////////////////////////////////////////

*/

//	11/18/2007  wired	added code for womble's droppable gold
//	02/29/2008	rfh		cleanup
//	06/04/2009	RFH		LIMIT NUMBER OF CONTAINERS

#include "x2_inc_switches"
#include "rw_coinage"

void main()
{
	int nNumberOfContainers;
    object oItem;
	object oPC;
//
//	RUN DEFAULT ON UNACQUIRE EVENT
//
	ExecuteScript("x2_mod_def_unaqu", OBJECT_SELF);
	
	oPC = GetModuleItemLostBy();

	if (GetIsPC(oPC) && !GetIsDM(oPC))
	{
		oItem = GetModuleItemLost();
		
		//	LOST ITEM
		if (GetIsObjectValid(oItem))
		{
			//	LIMIT THE NUMBER OF CONTAINERS PER CHARACTER
			if (GetBaseItemType(oItem) == BASE_ITEM_LARGEBOX)
			{
				nNumberOfContainers = GetLocalInt(oPC, "nNumberOfContainers") - 1;
				SetLocalInt(oPC, "nNumberOfContainers", nNumberOfContainers);
			}
		}
		//	LOST GOLD
		else
		{
			CalculateGoldWeight(oPC);
		}
	}
}