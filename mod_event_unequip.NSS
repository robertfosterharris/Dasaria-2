// mod_event_unequip
//
// wired 2009/08/18 intital version
// wired 2009/12/29 remove CON HP Stacking to the equip
// 

#include "x2_inc_switches"
#include "x2_inc_itemprop"
#include "ginc_item_spellresist"

void main()
{
	object oPC				=	GetPCItemLastUnequippedBy();
	object oItem			=	GetPCItemLastUnequipped();	
	
	//if (GetLocalInt(oItem, "iSpellResistance") > 0) RemoveItemSR(oPC);
	
     // -------------------------------------------------------------------------
     // Generic Item Script Execution Code
     // If MODULE_SWITCH_EXECUTE_TAGBASED_SCRIPTS is set to TRUE on the module,
     // it will execute a script that has the same name as the item's tag
     // inside this script you can manage scripts for all events by checking against
     // GetUserDefinedItemEventNumber(). See x2_it_example.nss
     // -------------------------------------------------------------------------
     if (GetModuleSwitchValue(MODULE_SWITCH_ENABLE_TAGBASED_SCRIPTS) == TRUE)
     {
        SetUserDefinedItemEventNumber(X2_ITEM_EVENT_UNEQUIP);
        int nRet =   ExecuteScriptAndReturnInt(GetUserDefinedItemEventScriptName(oItem),OBJECT_SELF);
        if (nRet == X2_EXECUTE_SCRIPT_END)
        {
           return;
        }
     }	 	
}