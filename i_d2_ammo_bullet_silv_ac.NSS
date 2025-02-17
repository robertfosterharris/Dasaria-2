//	CREATES A STACK OF 99 SILVER BULLETS
//
//	ROBERT HARRIS	ROBERTHARRIS@ROBERTHARRIS.COM	06/28/2010
//
void main()
{
	CreateItemOnObject("nx2_bullet_silver", GetItemActivator(), 99);
	if (GetItemCharges(GetItemActivated()) == 0) DestroyObject(GetItemActivated());
}