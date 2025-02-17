//no pets allowed here
void main()
{
	object oPC;
	object oTarget;
    effect eVis;
	effect eDeath;
	effect eLink;

	oTarget = GetEnteringObject();
	//object oFamiliar = GetAssociate(ASSOCIATE_TYPE_FAMILIAR, oEnterer);	
	// - Returns ASSOCIATE_TYPE_NONE if the creature is not the associate of anyone.	
	if (GetAssociateType( oTarget ) != ASSOCIATE_TYPE_NONE )
	{
		eVis = EffectVisualEffect( VFX_HIT_AOE_ABJURATION );
		eDeath = EffectDeath(FALSE, TRUE, TRUE); //FIX: should work on death-immune
		eLink = EffectLinkEffects(eVis, eDeath);	
		oPC = GetMaster(oTarget);
		FloatingTextStringOnCreature("Pets, companions, summoned creatures are banned from these premises.", oPC);  
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eLink, oTarget);
	}
}