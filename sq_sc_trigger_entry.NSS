
//OnEnter script to speak string when entering the caves and remove quest items
void main()
{

object oPC = GetEnteringObject();

if (!GetIsPC(oPC)) return;

int DoOnce = GetLocalInt(oPC, GetTag(OBJECT_SELF));

if (DoOnce==TRUE) return;

SetLocalInt(oPC, GetTag(OBJECT_SELF), TRUE);

FloatingTextStringOnCreature("The cave is shrouded in darkness and there's a howling wind that make is hard to focus. You doubt there's any rest to be had here, no matter how tired...", oPC);

object oItem;
oItem = GetFirstItemInInventory(oPC);

while (GetIsObjectValid(oItem))
   {
   if (GetTag(oItem)=="sq_it_mushroom") DestroyObject(oItem);

   oItem = GetNextItemInInventory(oPC);
   }

oItem = GetFirstItemInInventory(oPC);

while (GetIsObjectValid(oItem))
   {
   if (GetTag(oItem)=="sq_it_key_jail") DestroyObject(oItem);

   oItem = GetNextItemInInventory(oPC);
   }

oItem = GetItemPossessedBy(oPC, "sq_it_key_stag");

if (GetIsObjectValid(oItem))
   DestroyObject(oItem);

oItem = GetFirstItemInInventory(oPC);

while (GetIsObjectValid(oItem))
   {
   if (GetTag(oItem)=="sq_it_key_boar") DestroyObject(oItem);

   oItem = GetNextItemInInventory(oPC);
   }

oItem = GetFirstItemInInventory(oPC);

while (GetIsObjectValid(oItem))
   {
   if (GetTag(oItem)=="sq_it_key_eagle") DestroyObject(oItem);

   oItem = GetNextItemInInventory(oPC);
   }

oItem = GetFirstItemInInventory(oPC);

while (GetIsObjectValid(oItem))
   {
   if (GetTag(oItem)=="sq_it_key_grumnaak") DestroyObject(oItem);

   oItem = GetNextItemInInventory(oPC);
   }

oItem = GetFirstItemInInventory(oPC);

while (GetIsObjectValid(oItem))
   {
   if (GetTag(oItem)=="sq_it_azek") DestroyObject(oItem);

   oItem = GetNextItemInInventory(oPC);
   }

oItem = GetFirstItemInInventory(oPC);

while (GetIsObjectValid(oItem))
   {
   if (GetTag(oItem)=="sq_it_crystal_purple") DestroyObject(oItem);

   oItem = GetNextItemInInventory(oPC);
   }

oItem = GetFirstItemInInventory(oPC);

while (GetIsObjectValid(oItem))
   {
   if (GetTag(oItem)=="sq_it_crystal_yellow") DestroyObject(oItem);

   oItem = GetNextItemInInventory(oPC);
   }

oItem = GetFirstItemInInventory(oPC);

while (GetIsObjectValid(oItem))
   {
   if (GetTag(oItem)=="sq_it_headband") DestroyObject(oItem);

   oItem = GetNextItemInInventory(oPC);
   }

}