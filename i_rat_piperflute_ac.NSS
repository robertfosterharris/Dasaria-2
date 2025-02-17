#include "X0_I0_SPELLS"

void main()
{
	int iBardDC;
	int iRatDC;
	float fDuration;
	object oPC;
	object oTarget;

	iBardDC = 24;
	iRatDC = 16;
	fDuration = 30.0f;
	oPC = GetItemActivator();
	
// message + animate "play flute" + sound

	SendMessageToPC( oPC, "You begin to play the flute");
	AssignCommand(oPC, PlayAnimation(31, 1.0, 5.0));
    AssignCommand(oPC, PlaySound("gui_flutesong01"));    
	effect eFNF    = ExtraordinaryEffect( EffectVisualEffect(VFX_DUR_BARD_SONG) );
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eFNF, GetLocation(oPC));
		
	if ( GetIsSkillSuccessful( oPC, SKILL_PERFORM, iBardDC) )
		{
		oTarget = GetFirstObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_HUGE, GetLocation(oPC) );
		while ( GetIsObjectValid(oTarget) )
			{
   			effect eSleep =  EffectSleep();
			effect eDur = EffectVisualEffect( VFX_DUR_SLEEP );
			effect eLink = EffectLinkEffects( eSleep, eDur);
		
			if ( GetRacialType(oTarget)==RACIAL_TYPE_VERMIN && GetIsReactionTypeHostile(oPC, oTarget) )
				{
			
				//Fire cast spell at event for the specified target
           		SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_SLEEP));
			
				// Saving throw for vfx or vfx+sleep
				if (!MySavingThrow(SAVING_THROW_WILL, oTarget, iRatDC, SAVING_THROW_TYPE_MIND_SPELLS, oPC))
					{
                   	if (GetIsImmune(oTarget, IMMUNITY_TYPE_SLEEP) == FALSE)
						ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, fDuration);
   	                else
       	                ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eSleep, oTarget, fDuration);
					}
				}
			
			oTarget = GetNextObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_LARGE, GetLocation(oPC) );
			}
		}
	else
		{
		SendMessageToPC( oPC, "You blow a bad note");
		}
}