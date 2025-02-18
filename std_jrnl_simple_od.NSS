// wired 02/14/09
// std_jrnl_simple_od
// simple ondeath handler, eventually fix this up
void main()
{
	int nHas;
	int nGive;
	int nCurEntry;
	string sQuestName;
	object oPC;
	
	oPC			= 	GetLastDamager();
	nHas		=	GetLocalInt(OBJECT_SELF,"has");
	nGive		=	GetLocalInt(OBJECT_SELF,"give");
	sQuestName	=	GetLocalString(OBJECT_SELF,"quest");
	nCurEntry 	= 	GetJournalEntry(sQuestName,oPC);

	if ( (nCurEntry == 2))
	{			
		AddJournalQuestEntry(sQuestName,nGive,oPC,TRUE);
	}
}