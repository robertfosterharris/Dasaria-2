// wired 10/23/2008
// these creatures autoscale to PC level, so CR 0 and award fixed XP of 40
void main()
{
	object oPC = GetLastKiller();
	object oArea = GetArea(oPC);
	
    object oPartyMem = GetFirstFactionMember(oPC, TRUE);
    while (GetIsObjectValid(oPartyMem)) 
	{
        if (GetArea(oPartyMem) == oArea)
		{
			GiveXPToCreature(oPartyMem, 40);
		}
		
        oPartyMem = GetNextFactionMember(oPC, TRUE);
    }
}