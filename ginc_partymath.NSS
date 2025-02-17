#include "nw_i0_plot"

// Check for quest state across ALL PCs in the party
int GetHighJournalEntry(string sQuest, object oPC)
{
    object oPartyMem = GetFirstFactionMember(oPC);
	int nEntry = GetJournalEntry(sQuest,oPC);
	int nEntry2;

	// Check other party members
    while (GetIsObjectValid(oPartyMem)) 
	{
		nEntry2 = GetJournalEntry(sQuest,oPartyMem);
		if ( nEntry2 > nEntry)
		{
			nEntry = nEntry2;
		}		
        oPartyMem = GetNextFactionMember(oPC);
    }
    return nEntry;
}

int GetHighLocalInt(object oPC, string sVar)
{
    object oPartyMem = GetFirstFactionMember(oPC);
	int nInt = 	GetLocalInt(oPC,sVar);
	int nInt2;

	// Check other party members
    while (GetIsObjectValid(oPartyMem)) 
	{
		nInt2 = GetLocalInt(oPartyMem,sVar);
		if ( nInt2 > nInt)
		{
			nInt = nInt2;
		}		
        oPartyMem = GetNextFactionMember(oPC);
    }
    return nInt;
}


int GetPartyNumItems(object oPC, string sTag)
{
	int nNumItems = 0;
	
	object oPartyMem = GetFirstFactionMember(oPC);
	
	while (GetIsObjectValid(oPartyMem) )
	{
		nNumItems = nNumItems + GetNumItems(oPartyMem,sTag);
		oPartyMem = GetNextFactionMember(oPC);
	}
	
	return nNumItems;
}

// in this application, we only want to look at PCs
int PartyLevelCheck( object oPC, int low, int high )
{
	if (GetIsDM(oPC)) return TRUE;
	
	object oMember = GetFirstFactionMember(oPC);
	while( GetIsObjectValid(oMember) )
	{
		if (GetIsPC(oMember))
		{
			if( GetHitDice(oMember) > high) 
				return FALSE;
			if( GetHitDice(oMember) < low) 
				return FALSE;					
		}
		oMember = GetNextFactionMember(oPC);
	}
	
	return TRUE;
}