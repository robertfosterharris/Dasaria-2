//i_unicorn_horn_aq
//

#include "nw_i0_plot"

void main()
{
	object oPC = GetModuleItemAcquiredBy();
	object oAcquired = GetModuleItemAcquired();
	string sTag = GetTag(oAcquired);
	
	if (	GetNumItems(oPC,sTag) > 2	)
	{
		SendMessageToPC(oPC,"Unicorns are not so numerous in the world that a single person could hope to see such of cache of horns in their lifetimes.");
		DestroyObject(oAcquired,0.0,FALSE);
	}
	
}