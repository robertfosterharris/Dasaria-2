// ga_jump_henchmen
// jump with your henchmen, if they are told to follow or guard only

const int bDEBUG = TRUE;

void main(string sDestination, float fDelay)
{
	object oPC 			= GetPCSpeaker();
	object oDestination = GetObjectByTag(sDestination);
	object oHench;
	int nMax			= GetMaxHenchmen();
	int nCounter;
	int nLastCommand;
	
	for (nCounter=nMax; nCounter>0; nCounter--)
	{
		oHench 			= GetHenchman(oPC,nCounter);
		
		if (GetIsObjectValid(oHench))
		{
			nLastCommand	= GetLastAssociateCommand(oHench);
	
			if (nLastCommand != ASSOCIATE_COMMAND_STANDGROUND)
			{
				AssignCommand(oHench, JumpToObject(oDestination));
			}
		}	
	}	
	AssignCommand(oPC, DelayCommand(fDelay, JumpToObject(oDestination)));
}
	
	
	