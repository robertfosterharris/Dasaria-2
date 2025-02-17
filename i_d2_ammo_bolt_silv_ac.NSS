//	CREATES A STACK OF 99 SILVER BOLTS
//
//	ROBERT HARRIS	ROBERTHARRIS@ROBERTHARRIS.COM	06/28/2010
//
void main()
{
	CreateItemOnObject("d2_bolt_silver", GetItemActivator(), 99);
	if (GetItemCharges(GetItemActivated()) == 0) DestroyObject(GetItemActivated());
}