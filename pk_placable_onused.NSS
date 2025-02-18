void main()
{
	string sItem = GetLocalString(OBJECT_SELF, "resref");  //this gets the resref value of the item you want the player to receive on picking up item
	CreateItemOnObject(sItem, GetLastUsedBy());
	DestroyObject(OBJECT_SELF); // this destroys the placeable, leaving the item in the player's inventory
}