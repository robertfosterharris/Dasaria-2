void main()
{
	object oPC = GetEnteringObject();
	
	if (GetIsDM(oPC))
	{
		ExecuteScript("wand_init", oPC);
	}
}