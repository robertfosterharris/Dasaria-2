// rvnw_add_feyprop

#include "x2_inc_itemprop"
//#include "ginc_var_ops"
#include "nw_i0_plot"

void takeMyDust(object oPC)
{

	int nItems = 0;
	int nCount = 0;
	int nNumItems = 50;
	string sItemTag = "rvn_fairy_dust";

	object oItem = GetFirstItemInInventory(oPC);
	while (GetIsObjectValid(oItem) == TRUE && nCount < nNumItems)
	{
	        if (GetTag(oItem) == sItemTag)
	        {
				int stack_size = GetItemStackSize(oItem);
				if ( stack_size > nNumItems )
					{
					SetItemStackSize( oItem, stack_size-nNumItems);
					return;				
					}
				
				if ( stack_size > 1 )
					{
					DestroyObject(oItem,0.1f);
					nCount += stack_size;
					}
					
				DestroyObject(oItem,0.1f);
	            nCount++;
	        }
		oItem = GetNextItemInInventory(oPC);
	}
}

void main()
{
	object oWeapon;
	object oPC = GetPCSpeaker();;
	int nItems = 0;
	int nNumItems = 50;
	string sItemTag = "rvn_fairy_dust";
	itemproperty ipFey;
		
	//SendMessageToPC(oPC,"_feyprop running.");		 
	
	nItems = GetNumItems(oPC, sItemTag);
	if (nItems < nNumItems)
	{
		SendMessageToPC(oPC,"Error: You do not have enough dust.");
		WriteTimestampedLogEntry("rvnw_add_feyprop: Possible exploit, player attempted to drop quest items"); 
		return;
	}
	else
	{
		// take the items
		//SendMessageToPC(oPC,"DEBUG: Taking Items");
		
		takeMyDust(oPC);	

		// add the property
		//SendMessageToPC(oPC,"DEBUG: Add Properties");
		
		oWeapon = GetItemInSlot(INVENTORY_SLOT_RIGHTHAND, oPC);
		
		if (!GetIsObjectValid(oWeapon)) 
		{
			SendMessageToPC(oPC,"Error: Item is invalid!");
			return;	
		}
		
	    if (IPGetIsMeleeWeapon(oWeapon) || IPGetIsRangedWeapon(oWeapon))
		{
			//SendMessageToPC(oPC,"Enhancing Item.");
			ipFey = ItemPropertyEnhancementBonusVsRace(IP_CONST_RACIALTYPE_FEY, 4);
			IPSafeAddItemProperty(oWeapon, ipFey, 0.0f, X2_IP_ADDPROP_POLICY_KEEP_EXISTING, FALSE, TRUE);
		}
		else
		{
			SendMessageToPC(oPC,"Error: Weapon is neither a melee nor ranged weapon!");
		}
	}
}