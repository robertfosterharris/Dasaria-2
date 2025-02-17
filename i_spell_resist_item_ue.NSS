// i_spell_resist_item_ue
//

#include "ginc_item_spellresist"

void main()
{
	object oPC = GetPCItemLastUnequippedBy();
	RemoveItemSR(oPC);
}