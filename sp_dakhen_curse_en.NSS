// wired 11/1/12: this script obviated

/*
// sp_dakhen_curse_en
// wired 2012-09/-21
// this is a supernatural ghast stench with no VFX

    The stink of death and corruption surrounding 
    these creatures is overwhelming. Living creatures 
    within 10 feet must succeed on a DC 15 Fortitude 
    save or be sickened for 1d6+4 minutes. A creature 
    that successfully saves cannot be affected again 
    by the same ghasts stench for 24 hours. A delay 
    poison or neutralize poison spell removes the effect 
    from a sickened creature. Creatures with immunity 
    to poison are unaffected, and creatures resistant 
    to poison receive their normal bonus on their 
    saving throws. The save DC is Charisma-based.
	


#include "NW_I0_SPELLS"
//#include "std_persist_i0"
#include "std_quest_i0"

int bDEBUG = FALSE;

void main()
{
    //Declare major variables
	object oTarget= GetEnteringObject();
	object oPC = GetAreaOfEffectCreator(OBJECT_SELF);
	
	if (!GetIsObjectValid(oPC)) oPC = GetFirstPC();

	if (bDEBUG == TRUE) {	SendMessageToPC(oPC,"DEBUG: sp_dakhen_curse_en() is running!");	}
		
	if ( !GetIsObjectValid(oTarget) )
	{
		return;
	}	
	
	if (bDEBUG == TRUE) {	SendMessageToPC(oPC,"DEBUG: "+GetName(oTarget)+" entered AOE."); }
	
    effect eCon= EffectAbilityDecrease( ABILITY_CONSTITUTION, 2 );
    effect eStr= EffectAbilityDecrease( ABILITY_STRENGTH, 2 );
    effect eDex= EffectAbilityDecrease( ABILITY_DEXTERITY, 2 );
    effect eDur = EffectVisualEffect( VFX_DUR_SICKENED );
    effect eSick1 = EffectLinkEffects( eCon, eStr );
    effect eSick2 = EffectLinkEffects( eSick1, eDex );
    effect eLink = EffectLinkEffects( eSick2, eDur );  
	
	//effect eLink = SupernaturalEffect( eSick2);
	
	int iCooldown = GetLocalInt(oTarget,"DAKHEN_COOLDOWN"+GetName(oPC));
	

    if(!GetHasSpellEffect(1878, oTarget) || !GetJournalEntry("dakhen_curse",oTarget) || !GetHasFeat(3061,oTarget,TRUE) )
    {   
		if (bDEBUG == TRUE) {	SendMessageToPC(oPC,"DEBUG: Target triggered one or more conditionals [No effect 1878 OR No JE OR No feat 3061"); }
	if (!iCooldown)
	{
		// we're only going to do this to a PC 
		if (GetIsPC(oTarget) && GetHitDice(oTarget) > 4 )
		{ 
        //if(GetIsEnemy(oTarget, GetAreaOfEffectCreator()))
            //{
                //Fire cast spell at event for the specified target
                //SignalEvent(oTarget, EventSpellCastAt( OBJECT_SELF, SPELLABILITY_GHAST_STENCH ));
                //Make a saving throw check
                if(!MySavingThrow(SAVING_THROW_FORT, oTarget, 20, SAVING_THROW_TYPE_DISEASE))
                {
                    if (!GetIsImmune(oTarget, IMMUNITY_TYPE_DISEASE))
                    {
						if (bDEBUG == TRUE) {	SendMessageToPC(oPC,"DEBUG: Target afflicted!"); }
	                    //int nDuration = (d4() + 1);
	                    //Apply the VFX impact and effects for Sickness
						FeatAdd(oTarget,3061,FALSE,FALSE,FALSE);
	                    ApplyEffectToObject(DURATION_TYPE_PERMANENT, SupernaturalEffect(SetEffectSpellId(eLink,1878)), oTarget);	
						persist_advance_single( oTarget, "dakhen_curse", 0, 1, 0);
                    }
					else
					{
						if (bDEBUG == TRUE) {	SendMessageToPC(oPC,"DEBUG: Target is immune to disease."); }
					}
                }
				else
				{
					if (bDEBUG == TRUE) {	SendMessageToPC(oPC,"DEBUG: Target saved."); }
				}                
            }
			
	SetLocalInt(oTarget,"DAKHEN_COOLDOWN"+GetName(oPC),1);
	DelayCommand(30.0,DeleteLocalInt(oTarget,"DAKHEN_COOLDOWN"+GetName(oPC)));
	}//end iCooldown        
    }
	else
	{
		if (bDEBUG == TRUE) {	SendMessageToPC(oPC,"DEBUG: Target skipped all conditionals [No effect 1878 OR No JE OR No feat 3061"); }
	}
}

/*