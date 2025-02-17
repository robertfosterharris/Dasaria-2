void main()
{
object oPC = GetLastDisturbed();
object oArmor = GetFirstItemInInventory(OBJECT_SELF);
DeleteLocalInt(oArmor,"DamageReduction");
//Strip:
itemproperty ip = GetFirstItemProperty(oArmor);
while (GetIsItemPropertyValid(ip))
{

if (GetItemPropertyType(ip) == 90)
{
RemoveItemProperty(oArmor,ip);
SendMessageToPC(oPC,"del+copied ip "+IntToString(GetItemPropertyType(ip)));
}
ip = GetNextItemProperty(oArmor);
}
//90
}