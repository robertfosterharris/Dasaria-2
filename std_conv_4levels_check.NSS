// std_conv_4levels_check
// wired 10/27
#include "X0_I0_PARTYWIDE"
int StartingConditional( )
{
	object oSpeaker = GetPCSpeaker();
	int nPlayerCount = GetNumberPartyMembers(oSpeaker) - 1;
	//SendMessageToPC(GetFirstPC(),"The are " + IntToString(nPlayerCount) + " person(s) in your party.");
	
	if (nPlayerCount == 1)
	{
		//SendMessageToPC(GetFirstPC(),"Return TRUE1");
		return TRUE;
	}
	else
	{	
		object oWeakest = GetFactionWeakestMember(oSpeaker, TRUE);
		object oStrongest = GetFactionStrongestMember(oSpeaker, TRUE);
		
		int nHDMax = GetHitDice(oWeakest);
		int nHDMin = GetHitDice(oStrongest);
		
		if (nHDMax - nHDMin > 4)
		{
			//SendMessageToPC(GetFirstPC(),"Return FALSE");	
			return FALSE;
			
		}
		else
		{	
			//SendMessageToPC(GetFirstPC(),"Return TRUE2");
			return TRUE;
		}
	}
}