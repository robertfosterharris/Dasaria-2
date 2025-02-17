// wired feb 2014
// gtr_nrgaoe_exit

void main()
{
	int iArmed = GetLocalInt (OBJECT_SELF,"iArmed");
	object oCtrl;
	
	if (iArmed == FALSE) return;
	
	oCtrl = GetLocalObject(OBJECT_SELF,"oCtrl");
	DestroyObject(oCtrl);
}