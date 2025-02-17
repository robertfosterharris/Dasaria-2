// ga_unsummon_familiar
// wired 07/20/11
//
// REALLY? There's no unsummon function in nwnscript?
//
void main()
{
	// if called from dialog
	object oPC = GetPCSpeaker();
	
	// if called from executescript
	if (!GetIsObjectValid(oPC)) oPC = OBJECT_SELF;
	
	object oFam = GetAssociate(ASSOCIATE_TYPE_FAMILIAR,oPC);
	effect eVis;
	effect eDeath;
	effect eLink;
	
	if (GetIsObjectValid(oFam))
	{
		if ( GetIsPossessedFamiliar(oFam) ) UnpossessFamiliar(oPC);
	
		//RemoveSummonedAssociate(oPC,oFam);
		
		eVis = EffectVisualEffect( VFX_HIT_AOE_ABJURATION );
		eDeath = EffectDeath(FALSE, TRUE, TRUE); //FIX: should work on death-immune
		eLink = EffectLinkEffects(eVis, eDeath);	
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eLink, oFam);
	}
}