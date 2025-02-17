// i_kraacsisle_lute_ac
// A Mass Haven Song
// Wired 4/29/2009

//:://////////////////////////////////////////////////////////////////////////
//:: Bard Song: Haven Song
//:: nw_s2_snghaven.nss
//:: Created By: Brock Heinz - OEI
//:: Created On: 09/12/05
//:: Copyright (c) 2005 Obsidian Entertainment Inc.
//:://////////////////////////////////////////////////////////////////////////
/*

    Haven Song (Req: 3rd level, Perform 10)
    This song works like the Sanctuary spell except the saving throw is a 
    Will save against a DC of 11 + ( Perform / 2) and its duration is 
    10 rounds or until the bard does a hostile action. The Fascinate and
    Cloud Mind songs do not count as hostile actions.

*/
//:: PKM-OEI 07.13.06 VFX Pass
//:: AFW-OEI 07/14/2006: Check to see if you have bardsong feats left; if you do, execute
//::	script and decrement a bardsong use.
//:: PKM-OEI 07.20.06 Added Perform skill check


#include "x0_i0_spells"
#include "nwn2_inc_spells"

void main()
{
	object oPC = GetItemActivator();
	
	if (!GetIsObjectValid(oPC))
	return;

	if ( GetCanBardSing( oPC ) == FALSE )
	{
		return; 
	}

    if (!GetHasFeat(FEAT_BARD_SONGS, oPC))
    {
        FloatingTextStrRefOnCreature(STR_REF_FEEDBACK_NO_MORE_BARDSONG_ATTEMPTS,oPC); // no more bardsong uses left
        return;
    }
	
	int		nPerform	= GetSkillRank(SKILL_PERFORM, oPC);
	 
	if (nPerform < 10 ) //Checks your perform skill so nubs can't use this song
	{
		FloatingTextStrRefOnCreature ( 182800, oPC );
		return;
	}

	int 	nSaveDC		= 11 + ( nPerform / 2 ); 
	int 	nDuration 	= ApplySongDurationFeatMods( 10, oPC ); // Rounds
    float 	fDuration 	= RoundsToSeconds(nDuration);
	effect 	eVis 		= EffectVisualEffect(VFX_HIT_BARD_HAVEN_SONG);
	effect	eSanc		= EffectSanctuary( nSaveDC );		
		
	effect eLink = EffectLinkEffects(eVis, eSanc);
	
	//Apply the VFX impact and effects
    effect eFNF    = ExtraordinaryEffect( EffectVisualEffect(VFX_DUR_BARD_SONG) );
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eFNF, GetLocation(oPC));

    ApplyFriendlySongEffectsToArea( oPC, SPELLABILITY_SONG_HAVEN_SONG, fDuration, RADIUS_SIZE_COLOSSAL, eLink );
    DecrementRemainingFeatUses(oPC, FEAT_BARD_SONGS);	
}