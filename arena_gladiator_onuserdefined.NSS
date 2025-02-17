//  Fight Gladiator's OnUserDefined


void WhoAttackedMe(object oHostileActor)
{
	if ( GetIsPC(oHostileActor))
	{			
		AssignCommand(oHostileActor, PlaySound("as_wt_thundercl1"));
		FloatingTextStringOnCreature("IT IS FORBIDDEN TO INTERFERE WITH A CONTEST",oHostileActor);
	   	effect eDamage = EffectDamage(150, DAMAGE_TYPE_DIVINE);	
	   	effect eVis = EffectVisualEffect(VFX_IMP_FLAME_M);	
	   	ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oHostileActor);
	   	ApplyEffectToObject(DURATION_TYPE_INSTANT, eDamage, oHostileActor);	
	}
}

void main()
{
    int nUser = GetUserDefinedEventNumber();
	
    if(nUser == EVENT_HEARTBEAT ) //HEARTBEAT
    {

    }
    else if(nUser == EVENT_PERCEIVE) // PERCEIVE
    {

    }
    else if(nUser == EVENT_END_COMBAT_ROUND) // END OF COMBAT
    {

	}
    else if(nUser == EVENT_DIALOGUE) // ON DIALOGUE
    {

    }
    else if(nUser == EVENT_ATTACKED) // ATTACKED
    {
		object oHostileActor = GetLastHostileActor();
		object oAuthorizedAttacker = GetLocalObject(OBJECT_SELF,"oPCFighting");
		if (oHostileActor != oAuthorizedAttacker) { WhoAttackedMe(oHostileActor); }
    }
    else if(nUser == EVENT_DAMAGED) // DAMAGED
    {

    }
    else if(nUser == EVENT_DISTURBED) // DISTURBED
    {

    }
	else if (nUser == EVENT_SPELL_CAST_AT) 	// 1011
    {
		object oHostileActor = GetLastSpellCaster();
		object oAuthorizedAttacker = GetLocalObject(OBJECT_SELF,"oPCFighting");
		if (oHostileActor != oAuthorizedAttacker) { WhoAttackedMe(oHostileActor); }
	}	
}