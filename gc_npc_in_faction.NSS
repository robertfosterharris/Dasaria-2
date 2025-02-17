// gc_npc_in_faction
// determines what 

int StartingConditional(string sFactionMemberTag)
{
	object oCompareTo = GetObjectByTag(sFactionMemberTag);
	if (!GetIsObjectValid(oCompareTo) ) SendMessageToPC(GetFirstPC(),"Can't find "+sFactionMemberTag);
	
	if ( GetFactionEqual( oCompareTo, OBJECT_SELF) )
	{
		return TRUE;
	}
	else
	{
		return FALSE;
	}
}