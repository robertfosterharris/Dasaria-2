// en_area-trans-size
// Checks for creatures size and moves to waypoint if small.
// Set sDestination on the trigger to target WP name.

void main()
{
    // Get PC walker
    object oPC = GetLastUsedBy();
	// Get WP Target
	object oTarget = GetWaypointByTag(GetLocalString(OBJECT_SELF, "sDestination"));
	
    // Speak string
	string Deny = "The passageway rapidly becomes too" + " narrow for a creature of your size";
	string Allow = "You squeeze through the narrow passage";

    // Let through if Small or Tiny, deny if Enlarge is cast
    if((GetCreatureSize(oPC) == CREATURE_SIZE_SMALL) || (GetCreatureSize(oPC) == CREATURE_SIZE_TINY))
    {
        AssignCommand(oPC, JumpToObject(oTarget));
		FloatingTextStringOnCreature(Allow, oPC, TRUE);		
    }
	
	else if((GetHasSpellEffect(SPELL_ENLARGE_PERSON, oPC)) && (GetCreatureSize(oPC) == CREATURE_SIZE_SMALL))
	{
		FloatingTextStringOnCreature(Deny, oPC, TRUE);
	}
	
	else if(GetHasSpellEffect(SPELL_REDUCE_PERSON, oPC))
	{
		AssignCommand(oPC, JumpToObject(oTarget));
		FloatingTextStringOnCreature(Allow, oPC, TRUE);		
	}
    // Anything else
    else
    {
        FloatingTextStringOnCreature(Deny, oPC, TRUE);
    }

}