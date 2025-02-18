#include "nw_i0_spells"

void main()

{
    object oTarget = GetEnteringObject();
	int nPoints;
	effect eDumb = EffectAbilityDecrease(ABILITY_INTELLIGENCE, 3);
    
    if (Random(100) + 1 < 60)
        AssignCommand(oTarget, ActionPlayAnimation(ANIMATION_LOOPING_TALK_LAUGHING));
    else
        AssignCommand(oTarget, ActionPlayAnimation(ANIMATION_LOOPING_DANCE01));		
	
    object oCreator = GetTrapCreator(GetAreaOfEffectCreator());
    if (oCreator == OBJECT_INVALID)
    {
        oCreator = OBJECT_SELF; //pre-placed traps have no creator
    }

    //oTarget = GetFirstInPersistentObject();
    //while(GetIsObjectValid(oTarget))
    //{
    	if (spellsIsTarget(oTarget, SPELL_TARGET_STANDARDHOSTILE, oCreator))
    	{
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eDumb, oTarget, 60.0);
			SendMessageToPC(oTarget, "As you breath in the smoke you get a feeling of euphoria and your mind begins to wander.");
        }
		
	}	
		
    //    oTarget = GetNextInPersistentObject();
    //
	


 