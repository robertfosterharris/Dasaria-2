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

int IsArmed(object oHostileActor)
{
	if ( GetItemInSlot(INVENTORY_SLOT_RIGHTHAND, oHostileActor)== OBJECT_INVALID )
	{
		return FALSE;
	}
	else
	{
		return TRUE;
	}
}


void main()
{
    int nUser = GetUserDefinedEventNumber();
	
    if(nUser == EVENT_HEARTBEAT ) //HEARTBEAT
    {
		// keep attacking, dammit!
		object oPC = GetLocalObject(OBJECT_SELF,"oPCFighting");
		ActionAttack(oPC);
		ActionAttack(oPC);	
    }
    else if(nUser == EVENT_PERCEIVE) // PERCEIVE
    {

    }
    else if(nUser == EVENT_END_COMBAT_ROUND) // END OF COMBAT
    {
		// try it this way
		object oAuthorizedAttacker = GetLocalObject(OBJECT_SELF,"oPCFighting");
		location lLoc = GetLocation(GetNearestObjectByTag("casterbattle_end"));
		if (GetIsDead(oAuthorizedAttacker))
		{
			// do stuff
			FloatingTextStringOnCreature("I'M DEAD",oAuthorizedAttacker);			
			// End the Quest
			int nEntry1 = GetJournalEntry("ravenswatch_casterbattle",oAuthorizedAttacker);
			switch (nEntry1)
			{
				case 11: AddJournalQuestEntry("ravenswatch_casterbattle",13,oAuthorizedAttacker,FALSE); break; // killed in first round
				case 21: AddJournalQuestEntry("ravenswatch_casterbattle",23,oAuthorizedAttacker,FALSE); break; // killed in second round
				case 31: AddJournalQuestEntry("ravenswatch_casterbattle",33,oAuthorizedAttacker,FALSE); break; // killed in third round
			}		
			// Return the PC	
			AssignCommand(oAuthorizedAttacker, ActionJumpToLocation(lLoc));
			ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(99), oAuthorizedAttacker);
			MusicBattleStop(GetArea(OBJECT_SELF));			
			// Clean me up
			DelayCommand(2.0,AssignCommand(OBJECT_SELF, ActionPlayAnimation(ANIMATION_FIREFORGET_BOW)));
			DelayCommand(3.0,ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(566),OBJECT_SELF));
			FloatingTextStringOnCreature("There can be only one!",OBJECT_SELF);
			DelayCommand(5.0f,SetEncounterActive(TRUE,GetNearestObjectByTag("ravenswatch_casterbattle")));
			DeleteLocalInt(OBJECT_SELF,"activefight");
			DestroyObject(OBJECT_SELF, 3.5f);			
		}
	}
    else if(nUser == EVENT_ATTACKED) // ATTACKED
    {		
		object oHostileActor = GetLastHostileActor();
		object oAuthorizedAttacker = GetLocalObject(OBJECT_SELF,"oPCFighting");
		if (oHostileActor != oAuthorizedAttacker) { WhoAttackedMe(oHostileActor); }
    }
    else if(nUser == EVENT_DAMAGED) // DAMAGED
    {
		object oLastDamager = GetLastDamager();
		if ( IsArmed(oLastDamager) )
		{
			int nDmg = GetTotalDamageDealt();
			effect eHeal = EffectHeal(nDmg);
			ApplyEffectToObject(DURATION_TYPE_INSTANT,eHeal,OBJECT_SELF);
			FloatingTextStringOnCreature("CONTESTANTS MUST REMAIN UNARMED *Damage Reversed*",oLastDamager);
		}
	
    }
	else if (nUser == EVENT_SPELL_CAST_AT) 	// 1011
    {
		object oHostileActor = GetLastSpellCaster();
		object oAuthorizedAttacker = GetLocalObject(OBJECT_SELF,"oPCFighting");
		if (oHostileActor != oAuthorizedAttacker) { WhoAttackedMe(oHostileActor); }
	}	
}