// ga_jump_party
// wired 2008/08/07 this doesn't exist?
void main(string sWPTag)
{
	object oPC = GetPCSpeaker();
	object oPartyMem = GetFirstFactionMember(oPC, FALSE);
	object oWP = GetWaypointByTag(sWPTag);
	
    while (GetIsObjectValid(oPartyMem)) 
	{
		AssignCommand(oPartyMem, JumpToObject(oWP));
        oPartyMem = GetNextFactionMember(oPC, FALSE);
    }
}