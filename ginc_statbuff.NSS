// ginc_statbuff
// A generic, non-stacking attribute buffer
// wired 12/19/2008
// HP-CON exploit code credit to BrianMeyer

void StatBuff( object oTarget, int iStatToBuff, int iStatModifier, float fDuration = 60.0,  int nDurType = DURATION_TYPE_TEMPORARY)
{

	int nSpell;
	effect eLink;
	effect eVis;
	effect eBuff;
	
	// for exploit prevention
	int nBuffedScore;
	int nRawScore;
	int nMaxPossibleScore;	
	int nNewBuffedScore;
	int nMaxHP;
	int nHP;
	int nAbilityModifier;
	int nNewMaxHP;
	int nNewHP;
	int nNewAbilityModifier;
	int iAllowedHPIncrease;	
	
	nBuffedScore = GetAbilityScore(oTarget, iStatToBuff );
    nRawScore = GetAbilityScore(oTarget, iStatToBuff, TRUE);
	nMaxPossibleScore = nRawScore + 12;
    
    // now if this does not have an effect, don't bother applying, as it most likely will cause issues
    // generally this happens with buffs from items being greater than the possible modifier
    if ( ( nRawScore + iStatModifier ) <= nBuffedScore )
    {
		// debug 
		SendMessageToPC(oTarget, "StatBuff: No Possible Benefit, RawStat :" + IntToString( nRawScore ) + " Pre: Stat "+ IntToString( nBuffedScore ) + " and Post Stat would be "+ IntToString( nRawScore + iStatModifier ));
    	return;
    }
	
	switch (iStatToBuff)
	{
		case ABILITY_CHARISMA:
			nSpell = SPELL_EAGLES_SPLENDOR;
			eBuff = EffectAbilityIncrease(ABILITY_CHARISMA,iStatModifier);
			eVis = EffectVisualEffect(VFX_DUR_SPELL_EAGLE_SPLENDOR);		
		break;
		
		case ABILITY_CONSTITUTION:
			nSpell = SPELL_BEARS_ENDURANCE;
			eBuff = EffectAbilityIncrease(ABILITY_CONSTITUTION,iStatModifier);
			eVis = EffectVisualEffect(VFX_DUR_SPELL_BEAR_ENDURANCE);
			
			// for detecting an unwarranted HP increase
	    	nHP = GetCurrentHitPoints( oTarget );
			nMaxHP = GetMaxHitPoints(oTarget);
			nAbilityModifier = GetAbilityModifier( ABILITY_CONSTITUTION, oTarget);					
		break;
						
		case ABILITY_DEXTERITY:
			nSpell = SPELL_CATS_GRACE;
			eBuff = EffectAbilityIncrease(ABILITY_DEXTERITY,iStatModifier);
			eVis = EffectVisualEffect(VFX_DUR_SPELL_CAT_GRACE);		
		break;		
		
		case ABILITY_INTELLIGENCE:
			nSpell = SPELL_FOXS_CUNNING;
			eBuff = EffectAbilityIncrease(ABILITY_INTELLIGENCE,iStatModifier);
			eVis = EffectVisualEffect(VFX_DUR_SPELL_FOX_CUNNING);		
		break;
		case ABILITY_STRENGTH:
			// skip on BG bull's strength
			if (GetHasSpellEffect(SPELL_GREATER_BULLS_STRENGTH))
		    {
		        return;
		    }		
			nSpell = SPELL_BULLS_STRENGTH;
			eBuff = EffectAbilityIncrease(ABILITY_STRENGTH,iStatModifier);
			eVis = EffectVisualEffect(VFX_DUR_SPELL_BULL_STRENGTH);		
		break;
		
		case ABILITY_WISDOM:
			// skip on owl's insight
			if (GetHasSpellEffect(438))
		    {
		        return;
		    }		
			nSpell = SPELL_OWLS_WISDOM;
			eBuff = EffectAbilityIncrease(ABILITY_WISDOM,iStatModifier);
			eVis = EffectVisualEffect(VFX_DUR_SPELL_OWL_WISDOM);		
		break;					
	}		
	
	eLink = EffectLinkEffects(eBuff, eVis);    	
	
	 //Signal the spell cast at event
    SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, nSpell, FALSE));
	
	ApplyEffectToObject(nDurType, eLink, oTarget, fDuration);
	
	// now check for unwarranted hp increases
	nNewBuffedScore = GetAbilityScore(oTarget, iStatToBuff );	
	if ( iStatToBuff == ABILITY_CONSTITUTION ) 
	{
    	nNewHP = GetCurrentHitPoints(oTarget);
		nNewMaxHP = GetMaxHitPoints(oTarget);
		nNewAbilityModifier = GetAbilityModifier( ABILITY_CONSTITUTION, oTarget);			
		iAllowedHPIncrease = nNewAbilityModifier - nAbilityModifier * GetHitDice(oTarget);
		
		// debug 
		SendMessageToPC(oTarget, "StatBuff: RawStat :" + IntToString( nRawScore ) + " Pre: Stat "+ IntToString( nBuffedScore ) + " MaxHP"+ IntToString( nMaxHP ) + " CurHP"+ IntToString( nHP ) + " Post: Stat "+ IntToString( nNewBuffedScore ) + " MaxHP"+ IntToString( nNewMaxHP ) + " CurHP"+ IntToString( nNewHP ) + " Allowed Increase "+ IntToString( iAllowedHPIncrease ) );
		
		if ( nNewHP > ( nHP + iAllowedHPIncrease )  )
		{
			ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectDamage( nNewHP - ( nHP + iAllowedHPIncrease ), DAMAGE_TYPE_MAGICAL), oTarget);
		}
	}
	else
	{
		// debug 
		SendMessageToPC(oTarget, "StatBuff: RawStat :" + IntToString( nRawScore ) + " Pre: Stat "+ IntToString( nBuffedScore ) + " Post: Stat "+ IntToString( nNewBuffedScore ));
	}
}