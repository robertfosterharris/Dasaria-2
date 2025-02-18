// kobold_companion_de

void main()
{
	object oPC = GetMaster(OBJECT_SELF);
	if (!GetIsObjectValid(oPC))
	{
		oPC = GetLocalObject(OBJECT_SELF,"oPlayer");
	}
	
	oPC = GetFactionLeader(oPC);
	
	// in this case just die
	if (!GetIsObjectValid(oPC)) return;
	
	string sTag = GetTag(OBJECT_SELF);
	AddJournalQuestEntry(sTag,7,oPC,TRUE,FALSE,TRUE);	
}