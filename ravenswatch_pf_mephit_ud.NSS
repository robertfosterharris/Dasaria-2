// ravenswatch_pf_mephit_ud
#include "std_inc_npc_levelup"	
void main()
{
    int iEvent = GetUserDefinedEventNumber();

    switch (iEvent)
	{

		case EVENT_SPELL_CAST_AT: 	// 1011
		
		if (GetLastSpell() == SPELL_STONE_TO_FLESH)
		{			
			object oPC = GetNearestCreature(CREATURE_TYPE_PLAYER_CHAR, PLAYER_CHAR_IS_PC);
			int nPCHD = GetHitDice(oPC);
			DelayCommand(1.0f,DoLevelMeUpTo(OBJECT_SELF,nPCHD-2));
			ChangeToStandardFaction(OBJECT_SELF,STANDARD_FACTION_HOSTILE);
		}	
			break;	
	}

}