// gtr_hench_destroy_oe
//#include "ginc_var_ops"
void main()
{
	object oPC = GetEnteringObject();	
	string sHenchTag = GetLocalString(OBJECT_SELF,"sHenchTag");
	string sQuestName = GetLocalString(OBJECT_SELF,"sQuestName");
	int nJournalAdv	= GetLocalInt(OBJECT_SELF,"nJournalAdv");	
	object oHench = GetAssociate(ASSOCIATE_TYPE_HENCHMAN, oPC);
	
	
	if (GetIsObjectValid(oHench) && GetTag(oHench) == sHenchTag)
	{        
		if (sQuestName != "" && nJournalAdv != 0)
		{
			AddJournalQuestEntry(sQuestName,nJournalAdv,oPC,TRUE);
		}	
			RemoveHenchman(oPC,oHench);
			DestroyObject(oHench);
	}		
}