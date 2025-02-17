// i_culnul_circumvax_mask_eq
void main()
{
    object oPC      = GetPCItemLastEquippedBy();
    object oItem    = GetPCItemLastEquipped();

 	//Your code goes here
	SetItemCursedFlag(oItem,TRUE);
}