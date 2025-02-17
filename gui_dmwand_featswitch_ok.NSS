// gui_dmwand_featswitch_ok
// wired 2008-01-19
// get input from text box and execute

int DoAdd(object oTarget, int nFeatAdd)
{
	return FeatAdd(oTarget, nFeatAdd, TRUE);		
}

void main(string sFeatNames)
{
	int nFeatRemove;
	int nFeatAdd;
	int nStringLength = GetStringLength(sFeatNames);
	
	if (!GetIsDM(OBJECT_SELF)) return;

	// don't do the work if it looks invalid
	if 	(!TestStringAgainstPattern("*n,*n", sFeatNames) ||
		 nStringLength != 9 )
	{
		SendMessageToPC(OBJECT_SELF,"DM Wand Error: Correct format is <i>####,####</i>, add leading zeroes if necessary.");
		return;
	}
	
	object oTarget = GetLocalObject(OBJECT_SELF, "oTarget");	
	
	nFeatRemove = StringToInt(GetStringLeft(sFeatNames,4));
	nFeatAdd = StringToInt(GetStringRight(sFeatNames,4));
	
	SendMessageToPC(OBJECT_SELF,"DM Wand: Feat to Remove was " + IntToString(nFeatRemove) + " and Feat to Add was " + IntToString(nFeatAdd));
	
	if (!GetHasFeat(nFeatRemove,oTarget,TRUE))
	{
			SendMessageToPC(OBJECT_SELF,"DM Wand Error: Target did not have Feat # " + IntToString(nFeatRemove) + ", aborting...");
	}
	else
	{
		if ( FeatAdd(oTarget,nFeatAdd, TRUE) == TRUE)
		{
			FeatRemove(oTarget, nFeatRemove);
			SendMessageToPC(OBJECT_SELF,"DM Wand: Successfully removed Feat #" + IntToString(nFeatRemove) + " and added Feat # " + IntToString(nFeatAdd));
		}
		else
		{
			SendMessageToPC(OBJECT_SELF,"DM Wand Error: Could not add Feat # " + IntToString(nFeatAdd) + ", check pre-reqs");
		}
	}
}