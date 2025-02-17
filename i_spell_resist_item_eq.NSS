// i_spell_resist_item_eq
//

#include "ginc_item_spellresist"

void main()
{
	object oPC = GetPCItemLastEquippedBy();
	object oItem = GetPCItemLastEquipped();
	string sResRef = GetResRef(oItem);
	string sTag = GetTag(oItem);	
	int nSR = GetLocalInt(oItem,"iSpellResistance");
	
	if (nSR == 0)
	{	
		if (sResRef == "talontmb_lich_crown" || sTag == "talontmb_lich_crown") nSR = 22;
		if (sResRef == "ravenwood_faerie_crown2" || sTag == "ravenwood_faerie_crown2") nSR = 18;
		if (sResRef == "rvnw_splrst_ring" || sTag == "rvnw_splrst_ring") nSR = 16;
		if (sResRef == "rvnw_aa_bow" ||sTag == "rvnw_aa_bow"  ) nSR = 15;
	}
	
	ApplyItemSR(nSR, oPC);
}

//<c=DarkGreen>Special Properties</c>
//Spell Resistance: 16