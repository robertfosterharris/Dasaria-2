//gc_encounter_done
//Returns TRUE if the encounter is all dead. Returns FALSE if any creatures are still alive in the encounter.
#include "ginc_overland"
#include "ginc_group"

int IsGroupHostile(string sGroupName)
{
	object oGroupMember = GetFirstInGroup(sGroupName);
	while(GetIsObjectValid(oGroupMember))
	{
		if(!GetIsReactionTypeHostile(GetFirstPC(), oGroupMember))
			return FALSE;
			
		oGroupMember = GetNextInGroup(sGroupName);
	}
	
	return TRUE;
}

int StartingConditional()
{
	if(GetIsGroupValid(ENC_GROUP_NAME_1, TRUE) && IsGroupHostile(ENC_GROUP_NAME_1))
		return FALSE;
	
	if(GetIsGroupValid(ENC_GROUP_NAME_2, TRUE) && IsGroupHostile(ENC_GROUP_NAME_2))
		return FALSE;
	
	if(GetIsGroupValid(ENC_GROUP_NAME_3, TRUE) && IsGroupHostile(ENC_GROUP_NAME_3))
		return FALSE;
	
	if(GetIsGroupValid(ENC_GROUP_NAME_4, TRUE) && IsGroupHostile(ENC_GROUP_NAME_4))
		return FALSE;

	if(GetIsGroupValid(ENC_GROUP_NAME_5, TRUE) && IsGroupHostile(ENC_GROUP_NAME_5))
		return FALSE;
	
	if( GetLocalInt(GetArea(OBJECT_SELF), "bMated") )
	{
		if(GetIsGroupValid("COMBATANT_2" + ENC_GROUP_NAME_1, TRUE) && IsGroupHostile("COMBATANT_2" + ENC_GROUP_NAME_1))
			return FALSE;
	
		else if(GetIsGroupValid("COMBATANT_2" + ENC_GROUP_NAME_2, TRUE) && IsGroupHostile("COMBATANT_2" + ENC_GROUP_NAME_2))
			return FALSE;
	
		else if(GetIsGroupValid("COMBATANT_2" + ENC_GROUP_NAME_3, TRUE) && IsGroupHostile("COMBATANT_2" + ENC_GROUP_NAME_3))
			return FALSE;
		
		else if(GetIsGroupValid("COMBATANT_2" + ENC_GROUP_NAME_4, TRUE) && IsGroupHostile("COMBATANT_2" + ENC_GROUP_NAME_4))
			return FALSE;
	
		else if(GetIsGroupValid("COMBATANT_2" + ENC_GROUP_NAME_5, TRUE) && IsGroupHostile("COMBATANT_2" + ENC_GROUP_NAME_5))
			return FALSE;
	}
	
	return TRUE;
}