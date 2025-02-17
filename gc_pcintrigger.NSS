// gc_pcintrigger
// is anyone standing inside the trigger?

int StartingConditional(string sWPTag)
{
	//The trigger to look in
	object oTrigger = GetObjectByTag(sWPTag);
	
	//First object in that trigger. 
	object oInTrigger = GetFirstInPersistentObject(oTrigger, OBJECT_TYPE_CREATURE);
	
	if (oInTrigger != OBJECT_INVALID && GetIsPC(oInTrigger) == TRUE)
	{
			return TRUE;
	}
	else
	{
			return FALSE;
	}
}