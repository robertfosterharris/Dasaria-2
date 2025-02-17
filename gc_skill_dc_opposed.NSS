// gc_skill_dc_opposed(int nSkill, int nDC)
/*
	Determine if PC Speaker's skill roll is successful.
	
	Parameters:
		int nSkill 	= skill int to check
		int nMod	= manually passed modifer
	
	Remarks:
	int SKILL_PERFORM          = 11;
	int SKILL_DIPLOMACY        = 12;
	int SKILL_BLUFF            = 23;
	int SKILL_INTIMIDATE       = 24;
*/

#include "std_i0_skill"
#include "ginc_influence"

int StartingConditional(int nSkill, int nMod = 0)
{
	int nDC;
	object oPC 		= 	GetPCSpeaker();
	object oTarget	=	OBJECT_SELF;
	
	switch (nSkill)
	{
		// 	perform (11)
		/*	http://www.d20srd.org/srd/classes/bard.htm
			A bard of 6th level or higher with 9 or more ranks in a Perform skill can make
			a suggestion (as the spell) to a creature that he has already fascinated.
			Using this ability does not break the bard’s concentration on the fascinate 
			effect, nor does it allow a second saving throw against the fascinate effect.

			Making a suggestion doesn’t count against a bard’s daily limit on bardic music
			performances. A Will saving throw (DC 10 + ½ bard’s level + bard’s Cha modifier)
			negates the effect. This ability affects only a single creature (but see mass 
			suggestion, below). Suggestion is an enchantment (compulsion), mind-affecting
			language dependent ability. 
		*/
		case 11:
			// exit if the bard doesn't have enough levels or ranks to attempt this
			if (GetSkillRank(SKILL_PERFORM,oPC) <9 || GetLevelByClass(CLASS_TYPE_BARD,oPC) <6) 
				return FALSE;
			// subtract (½ bard’s level + bard’s Cha modifier) from the DC
			nDC = 10-( FloatToInt( IntToFloat(GetLevelByClass(CLASS_TYPE_BARD,oPC))/2) )-GetAbilityModifier(ABILITY_CHARISMA,oPC)+GetWillSavingThrow(oTarget)+nMod;			
		break;
			
		// 	diplomacy (12)
		/*	http://www.d20srd.org/srd/skills/diplomacy.htm
		
			Initial Attitude			New Attitude (DC to achieve)
			===================================================================
						Hostile Unfriendly 	Indifferent 	Friendly 	Helpful
			Hostile 	<20		20 			25 				35 			50
			Unfriendly 	<5 		5 			15				25			40
			Indifferent — 		<1 			1 				15			30
			Friendly 	— 		— 			<1			 	1 			20
			Helpful 	— 		— 			— 				<1 			1
		*/
	    case 12:
			// takes about 15 to jump a level, set it there and use nMod
			// if we want to make it more difficult
			nDC = 15+nMod;
		break;
		
		// bluff (23)
		/*	http://www.d20srd.org/srd/skills/bluff.htm
			Example Circumstances (guidelines for setting nMod)						Sense Motive Modifier
			The target wants to believe you. 										-5
			The bluff is believable and doesn’t affect the target much. 			+0
			The bluff is a little hard to believe or puts the target at some risk. 	+5
			The bluff is hard to believe or puts the target at significant risk. 	+10
			The bluff is way out there, almost too incredible to consider. 			+20
			
			Bluff is opposed by Sense Motive (Wis) which does not exist in NWN2,
			so we'll use a similar construct as per intimidate below
		*/
		case 23:
			nDC = GetHitDice(oTarget)+GetAbilityModifier(ABILITY_WISDOM,oTarget)+GetWillSavingThrow(oTarget)+nMod;
		break;
		
		// intimidate (24)
		/* 	http://www.d20srd.org/srd/skills/intimidate.htm
			Intimidate check is opposed by the target’s modified level check
			(1d20 + character level or Hit Dice + target’s Wisdom bonus [if any]
			+ target’s modifiers on saves against fear) 
			You gain a +4 bonus on your Intimidate check for every size category
			that you are larger than your target. Conversely, you take a -4 penalty
			on your Intimidate check for every size category that you are smaller
			than your target. 
		*/
		case 24:			
			nMod = nMod+( GetCreatureSize(oTarget) - GetCreatureSize(oPC) )*4; // size modifier
			nDC = GetHitDice(oTarget)+GetAbilityModifier(ABILITY_WISDOM,oTarget)+GetWillSavingThrow(oTarget)+nMod;			 
		break;
	}
	// for degbugging only, show unsuccessful rolls
	//return GetIsSkillSuccessful(oPC, nSkill, nDC,TRUE);
	return GetIsSkillSuccessfulPrivate(oPC, nSkill, nDC);
}