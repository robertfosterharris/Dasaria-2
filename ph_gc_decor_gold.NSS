
int StartingConditional()
{
	object oItem = OBJECT_SELF;
	object oPC = GetPCSpeaker();
	int nPrice = GetLocalInt(oItem,"nPrice");		

	if (GetGold(oPC) >= nPrice)
		return TRUE;
	else
		return FALSE;			
}