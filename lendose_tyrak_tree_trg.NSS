// 	lendose_tyrak_tree_trg
//	druids/rangers detect something about the tree

#include "std_i0_time"

void main()
{
	object oPC = GetEnteringObject();
	object oPartyMem;
	
	if (!GetIsPC(oPC)) return;
	
	// Set key
	string concat = GetFirstName(oPC) + GetLastName(oPC);
	string key = "message_pctimer_" + concat;

	// Check timestamp
	int respawn = 8*60;
	int elapsed = time_stamp_seconds_elapsed( OBJECT_SELF, key );
	if ( elapsed < respawn )
		return;	
	
	
	if (	GetLevelByClass(CLASS_TYPE_DRUID,oPC)	||
			GetLevelByClass(CLASS_TYPE_RANGER,oPC)	||
			GetLevelByClass(CLASS_TYPE_SPIRIT_SHAMAN,oPC) ||
			GetHasFeat(FEAT_PLANT_DOMAIN_POWER,oPC) )
		{
			oPartyMem = GetFirstFactionMember(oPC);
			
		    while (GetIsObjectValid(oPartyMem)) 
			{
				SendMessageToPC(oPartyMem,GetName(oPC)+" senses that this is no ordinary tree, but the home to a Dryad.");		
		        oPartyMem = GetNextFactionMember(oPC);
		    }		
		}
		
	// Update timestamp
	time_stamp_seconds_set( OBJECT_SELF, key);		
}