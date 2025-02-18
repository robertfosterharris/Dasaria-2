/*
	The entire party must be between "low" and "high", inclusive.
	
	2006/11/26		jhr4n
		Initial revision
	
	2009/01/27		wired
		Return TRUE for DMs
		
	2012/02/12		wired
		allow staff to set a bit to return TRUE (for testing)
	
*/

#include "std_i0_misc"

void SendMessageToParty(object oPC, string sHighLow)
{
	object oMember = GetFirstFactionMember(oPC);
	while( GetIsObjectValid(oMember) )
	{
		SendMessageToPC(oMember,GetName(oPC)+"'s level is too "+sHighLow+".");
		oMember = GetNextFactionMember(oPC);
	}
}

int StartingConditional( int low, int high )
{
	object oSpeaker = GetPCSpeaker();
	if (GetIsDM(oSpeaker)) return TRUE;
	
	if (GetIsStaff(oSpeaker) &&  GetLocalInt(oSpeaker,"bBuilderOverrideLevelCheck") == TRUE) return TRUE;
	
	object oMember = GetFirstFactionMember(oSpeaker);
	while( GetIsObjectValid(oMember) )
	{
		if( GetHitDice(oMember) > high )
		{ 
			SendMessageToParty(oMember,"high");
			return FALSE;
		}
		if( GetHitDice(oMember) < low )
		{ 
			SendMessageToParty(oMember,"low");
			return FALSE;
		}
		oMember = GetNextFactionMember(oSpeaker);
	}	
	return TRUE;
}
	
	
/*
*/