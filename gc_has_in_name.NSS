//Searches the PC's name for sName. 
//If sName is "boo", "book" and "boot and "booth" will all return true.
int StartingConditional(string sName)
{
	object oPC = GetPCSpeaker();
	string sPCName = GetName(oPC);
	if (FindSubString(sPCName,sName) > -1) return TRUE;
	else return FALSE;
}