int StartingConditional(string sString)
{
	if (	FindSubString(GetTag(GetArea(OBJECT_SELF)),sString) == -1	)
	{
		return FALSE;
	}
	return TRUE;
}