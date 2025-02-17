// wired 10/18/2008
// limit to one search of each ore vein each
int StartingConditional()
{
	object oPC = GetPCSpeaker();
	int nOreID = GetLocalInt(OBJECT_SELF,"OreID");
	int bUsed;
	
	// if i don't have an ID, assign one
	if (nOreID == 0)
	{
		// store my ID on myself
		nOreID = Random(1000);
		SetLocalInt(OBJECT_SELF,"OreID",nOreID);
	}
	
	// if the PC has NOT used me already already 
	bUsed = GetLocalInt(oPC,"OreID"+IntToString(nOreID));
	
	if (bUsed != 1)
	{
		// mark the PC as having used me
		SetLocalInt(oPC,"OreID"+IntToString(nOreID),1);
		// and return true
		return TRUE;
	}
	else
	{
		return FALSE;	
	}
}