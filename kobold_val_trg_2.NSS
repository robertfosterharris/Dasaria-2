// kobold_vala_trg_2
//
// when the PC val hits this trigger, run Val guide/attack convo
//
void main()
{
	object oPC = GetEnteringObject();
	if (!GetIsPC(oPC)) return;
	
	//SendMessageToPC(oPC,"Running!");
	
	// pc is on the quest, correct state
	if (GetJournalEntry("kobold_king",oPC) == 4)
	{	
		object oVal;
		int nHench = 6;
		
		// count henchman backwards until you find val
		for (nHench; nHench>0; nHench--)
		{
			oVal = GetHenchman(oPC,nHench);
			if (GetIsObjectValid(oVal) && GetTag(oVal) == "kobold_val" )
			{
				RemoveHenchman(oPC,oVal);
				AddJournalQuestEntry("kobold_king",5,oPC,TRUE,FALSE);
				DelayCommand(2.0,AssignCommand(oVal,ActionStartConversation(oPC,"kobold_val",FALSE,FALSE,TRUE)));
			}
		}
	}
}