// i_das_item_wyvpack_aq
//
#include "nw_i0_plot"

void main()
{
	object oPC;
	object oAcquired;
	string sTag;

	oPC = GetModuleItemAcquiredBy();
	oAcquired = GetModuleItemAcquired();
	sTag = GetTag(oAcquired);
	
	// no duplicates!
	if (GetNumItems(oPC,sTag) > 1)
	{
		ActionPutDownItem(oAcquired);
		SendMessageToPC(oPC,"You can't hold more than one of these wyvern sacks at once, they're too slippery!");
	}
}