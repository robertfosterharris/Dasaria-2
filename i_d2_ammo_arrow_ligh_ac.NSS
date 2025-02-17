//	CREATES A STACK OF 99 LIGHTNING ARROWS
//
//	ROBERT HARRIS	ROBERTHARRIS@ROBERTHARRIS.COM	03/03/2007
//
void main()
{
	CreateItemOnObject("NW_WAMMAR006", GetItemActivator(), 99);
	if (GetItemCharges(GetItemActivated()) == 0) DestroyObject(GetItemActivated());
}