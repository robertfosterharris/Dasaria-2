// culnite_ondeath
// wired 06/20/2009
// mark inventory undroppable if killed by culnite player

#include "ginc_faction"

void main()
{
	if  (GetIsInFaction(GetLastHostileActor(),"The Harbingers of Culnul"))
	{
		object oItem = GetFirstItemInInventory(OBJECT_SELF);
		while (GetIsObjectValid(oItem))
		{
			SetDroppableFlag(oItem,FALSE);
			oItem = GetNextItemInInventory(OBJECT_SELF);
		}	
	}
}