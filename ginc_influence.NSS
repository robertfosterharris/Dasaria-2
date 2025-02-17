// ginc_influence
// wired 10/28/2008
/* A -VERY SIMPLE- library for "keeping score" of influence during detective convos

1-13	Hostile  	Will take risks to hurt you  	Attack, interfere, berate, flee
14-38	Unfriendly 	Wishes you ill 					Mislead, gossip, avoid, watch suspiciously, insult
39-63	Indifferent Doesn’t much care 				Socially expected interaction
64-88 	Friendly 	Wishes you well 				Chat, advise, offer limited help, advocate
88-100	Helpful 	Will take risks to help you 	Protect, back up, heal, aid
*/
#include "x2_inc_itemprop"

int GetIsArmed(object oPC);

// get a PC's influence with NPC sTag
int d2GetInfluence( string sTag, object oPC )
{
		int influence = GetLocalInt(oPC,"INFL_"+sTag);
		return influence;
}

// Set PC's influence 
void d2SetInfluence( string sTag, int nInfluence, object oPC )
{
		string sInfluence = "Unknown";
		SetLocalInt(oPC,"INFL_"+sTag,nInfluence);
		
		if (nInfluence > 88)	sInfluence = "Helpful";
		if (nInfluence < 89)	sInfluence = "Friendly";		
		if (nInfluence < 64) 	sInfluence = "Indifferent";		
		if (nInfluence < 39)	sInfluence = "Unfriendly";		
		if (nInfluence < 14) 	sInfluence = "Hostile";		
	
		SendMessageToPC(oPC,"Your relationship with "+GetName(OBJECT_SELF)+ " is "+sInfluence+".");
}

// Clear PC's influence
void d2ClearInfluence( string sTag, object oPC )
{
		SetLocalInt(oPC,"INFL_"+sTag,0);
}

// Increase/decrease PC's influence
void d2ChangeInfluence( string sTag, int nChange, object oPC )
{
	int nInfluence = d2GetInfluence( sTag, oPC );
	nInfluence = nInfluence+nChange;
	if (nInfluence > 100) nInfluence = 100;
	if (nInfluence < 1) nInfluence =1;
	d2SetInfluence(sTag, nInfluence, oPC);
}

void d2InitInfluence(string sTag, object oPC, int nAdjust)
{

	int nInfluence = d2GetInfluence(sTag,oPC );
	int nPartyGoodAxis = GetFactionAverageGoodEvilAlignment(oPC);
	int nPartyLawAxis = GetFactionAverageLawChaosAlignment(oPC);
	int nNPCGoodAxis = GetAlignmentGoodEvil(OBJECT_SELF);
	int nNPCLawAxis = GetAlignmentLawChaos(OBJECT_SELF);
	int nAlignGoodDiff = abs(nPartyGoodAxis - nNPCGoodAxis);
	int nAlignLawDiff = abs(nPartyLawAxis - nNPCLawAxis);
	
	if (nInfluence != 0) return;
	
	// standard faction rep probably starts at 50
	nInfluence = GetReputation(OBJECT_SELF, oPC); 
	
	// process pos/neg nAdjust, if there is one
	nInfluence = nInfluence + nAdjust;
	
	// add charisma modifier * 2
	nInfluence = nInfluence+GetAbilityModifier(5,oPC)*2;
	// adjust for same race
	if (GetSubRace(oPC) == GetSubRace(OBJECT_SELF)) nInfluence = nInfluence+5;

		// adjust for similar alignment (these are cumulative)
	if (nAlignGoodDiff < 10)  nInfluence = nInfluence+5;
	if (nAlignLawDiff < 10)  nInfluence = nInfluence+5;

	if (nAlignGoodDiff > 20)  nInfluence = nInfluence-5;
	if (nAlignLawDiff > 20)  nInfluence = nInfluence-5;	
	
	if (nAlignGoodDiff > 30)  nInfluence = nInfluence-5;
	if (nAlignLawDiff > 30)  nInfluence = nInfluence-5;
	
	if (nAlignGoodDiff > 40)  nInfluence = nInfluence-5;
	if (nAlignLawDiff > 40)  nInfluence = nInfluence-5;
		
	// same religion
	if ( (GetDeity(oPC)) == (GetDeity(OBJECT_SELF)) )  nInfluence = nInfluence+5;
	
	// are we armed?
	if (GetIsArmed(oPC) == TRUE) nInfluence = nInfluence-20;
	
	// significant boost if charmed
	if 	(	(GetHasSpellEffect(SPELL_CHARM_PERSON, OBJECT_SELF)) || 
			(GetHasSpellEffect(SPELL_CHARM_PERSON_OR_ANIMAL, OBJECT_SELF)) ||
			(GetHasSpellEffect(SPELL_MASS_CHARM, OBJECT_SELF)) 	)
		{
			nInfluence = nInfluence+50;
		}
	
	if (nInfluence > 100) nInfluence = 100;
	if (nInfluence < 1) nInfluence = 1;
	d2SetInfluence( sTag, nInfluence, oPC );
}


int GetIsArmed(object oPC)
{
	object oWeapon;
	
	oWeapon = GetItemInSlot(INVENTORY_SLOT_RIGHTHAND, oPC);
    if (IPGetIsMeleeWeapon(oWeapon) ||
		IPGetIsRangedWeapon(oWeapon) )
	{
		return TRUE;
	}
	else
	{
		return FALSE;
	}
}