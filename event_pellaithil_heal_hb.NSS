// battlefield healer heartbeat
#include "nwn2_inc_spells"

void main()
{
	object 	oArea;
	object	oWounded;
    int 	nCasterLvl;
	int		nSpellId;
	int 	nMaxToCure;
	int 	nCuredInFaction;
    effect	eVis;
    effect 	eVis2;
    effect 	eImpact;
	string 	sTag;
	
    // If there isn't a fight going on, skip all this and just stand there
     if ( !GetIsObjectValid(GetAttemptedAttackTarget())
          && !GetIsObjectValid(GetAttemptedSpellTarget())
          && !GetIsObjectValid(GetNearestSeenEnemy()))
		{	
			PlayImmobileAmbientAnimations();
		}
		else
		{	
			oArea	 = oArea;
			sTag	 = GetTag(OBJECT_SELF);	
			oWounded = GetFirstObjectInArea(oArea);
			
			while ( GetIsObjectValid(oWounded) )
			{
				// if dead, ressurect
				if (GetIsDead(oWounded))
				{
					ActionForceMoveToObject(oWounded,TRUE,2.0f);
					ActionCastSpellAtObject(SPELL_RESURRECTION,oWounded,METAMAGIC_QUICKEN,TRUE);
					
					if (sTag == "event_pellaithil_h_rel" || sTag == "event_pellaithil_amandil" ) ActionSpeakString("<i>The Eternal Beacon calls you hero, rise up and fight again!</i>");			
				}
				
				// if below 50%, throw a mass heal at them
				else if ( ( IntToFloat( GetCurrentHitPoints(oWounded) ) / IntToFloat(GetMaxHitPoints(oWounded) ) < 0.50f ))
				{
					ActionCastSpellAtLocation(SPELL_MASS_CURE_CRITICAL_WOUNDS,GetLocation(oWounded),METAMAGIC_MAXIMIZE,TRUE);
					if (sTag == "event_pellaithil_h_rel" || sTag == "event_pellaithil_amandil" ) ActionSpeakString("<i>By the Grace of the Healing Dawn, you are healed!</i>" );
				}
			oWounded = GetNextObjectInArea(oArea);
			}
		}
}