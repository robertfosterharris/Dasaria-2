/*

	Xira	2007/1/12
*/

void main()
 {
 object oPC = GetModuleItemAcquiredBy();
 object oItem = GetFirstItemInInventory(oPC);
 string sTag = GetTag(GetModuleItemAcquired());
 int iCount = 0;
 
 while (GetIsObjectValid(oItem))
 {
 if (GetTag(oItem) == sTag)
 {
 iCount = iCount + 1;
 if (iCount > 1)
 {
 DestroyObject(oItem);
 }
 }
 oItem = GetNextItemInInventory(oPC);
 }
 }