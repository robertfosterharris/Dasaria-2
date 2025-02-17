// i_wired_grimoire_ou
// wip 2014/8/10


#include "std_persist_i0"

void LatherRinseRepeat(object oPC, int nFeatID, string sFeatName, int nSpellLvl, int nCLevel)
{
	//int nCLevel = GetCasterLevel(oPC);
	//string sLevel = IntToString(nCLevel);
	//string sLevel2 = IntToString(nSpellLvl);	
	//FloatingTextStringOnCreature("Caster level is "+sLevel+"</i>",oPC,TRUE);	 
	//FloatingTextStringOnCreature("Spell level is "+sLevel2+"</i>",oPC,TRUE);
	
	if (GetHasFeat(nFeatID,oPC,TRUE))
	{
		FloatingTextStringOnCreature(GetName(oPC)+ " already knows <i>"+sFeatName+"</i>",oPC,TRUE);	 
		return;  
	}
	
	/*
	if (nSpellLvl > nCLevel)
	{
		FloatingTextStringOnCreature("FAILURE! "+GetName(oPC)+ " lacks sufficient caster levels to learn <i>"+sFeatName+"</i> at this time.",oPC,TRUE);	
		return;
	}
	*/
	
	if ( GetIsSkillSuccessful(oPC,SKILL_SPELLCRAFT,nSpellLvl+15,TRUE ))
	{
		FeatAdd(oPC,nFeatID,FALSE,TRUE,TRUE);
	}
	else
	{
		FloatingTextStringOnCreature("FAILURE! "+GetName(oPC)+ " lacks the Spellcraft to successfully learn <i>"+sFeatName+"</i>",oPC,TRUE);
		return;
	}
		
}


void main()
{

	object oPC = GetItemActivator();
	object oJournal = 	std_journal_get( oPC) ;
	int nCLevel = GetCasterLevel(oPC);
	int nHD;
	int nGrimoireLastRead;

	// start cycle
	FloatingTextStringOnCreature(GetName(oPC)+ " attempts to decipher the Grey Grimoire...",oPC,TRUE);
	
	// wizards and sorcs only
	int nWizLevel = GetLevelByClass(CLASS_TYPE_WIZARD,oPC);
	int nSorcLevel = GetLevelByClass(CLASS_TYPE_SORCERER,oPC);	
	if (nWizLevel == 0 && nSorcLevel == 0)
	{
		FloatingTextStringOnCreature("FAILURE! You must be a wizard or sorcerer in order to attempt to decipher the Grimoire.",oPC,TRUE);	 	  
		return;
		}
				
	
	// if caster level 0, error
	if (nCLevel == 0)
	{
		FloatingTextStringOnCreature("FAILURE! " + GetName(oPC)+ " must cast at least one spell before attempting to decipher the Grimoire.",oPC,TRUE);	 	  
		return;
	}
			
	
	// you can only attempt to read this thing once per level
	nHD = GetHitDice( oPC );
	nGrimoireLastRead = GetLocalInt(oJournal,"nGrimoireLastRead");
	if (nGrimoireLastRead > 0)
	{
		if (!nGrimoireLastRead < nHD)
		{
			FloatingTextStringOnCreature("FAILURE! You can only attempt to decipher the Grimoire once per level.",oPC,TRUE);
			return;	
		}
	}
	
	
	// set persistent int	
	SetLocalInt(oJournal, "nGrimoireLastRead", nHD);	
	
	
	// 3072 FEAT_GRIM_ANTIMAGIC  
	LatherRinseRepeat(oPC, 3072,"Antimagic Field",7,nCLevel);	 	  
	
	// 3073 FEAT_GRIM_LOCATE_CRTR
	LatherRinseRepeat(oPC, 3073,"Locate Creature",4,nCLevel);
	
	// 3074 FEAT_GRIM_LSR_TELEPORT
	LatherRinseRepeat(oPC, 3074,"Lesser Teleport",5,nCLevel);
	
	// 3075 FEAT_GRIM_GRTR_TELEPORT 
	LatherRinseRepeat(oPC, 3075,"Greater Teleport",7,nCLevel);
	
	// 3076 FEAT_GRIM_TELEPORT_CIRC
	LatherRinseRepeat(oPC, 3076,"Teleportation Circle",9,nCLevel);  
	
	// 3077 FEAT_GRIM_SUMN_OTHER
	LatherRinseRepeat(oPC, 3077,"Summon Other",9,nCLevel);  	 	  
	
	// 3078 FEAT_GRIM_LSR_PLNR_SHIFT 
	LatherRinseRepeat(oPC, 3078,"Lesser Planar Shift",7,nCLevel);  
	
	// 3079 FEAT_GRIM_GTR_PLNR_SHIFT
	LatherRinseRepeat(oPC, 3079,"Greater Planar Shift",9,nCLevel);  
	
	// 3080 FEAT_GRIM_TMP_STATIS
	LatherRinseRepeat(oPC, 3080,"Temportal Stasis",8,nCLevel);  
	
	// 3081 FEAT_GRIM_TIMESTOP
	LatherRinseRepeat(oPC, 3081,"Time Stop",9,nCLevel); 
	
	// 3082 FEAT_GRIM_CHIMERA  
	LatherRinseRepeat(oPC, 3082,"Chimera",9,nCLevel); 


}
/*
3072 FEAT_GRIM_ANTIMAGIC                                             16777726 16777727    ia_appear                    ****           ****   ****   ****   ****   ****   ****   ****   ****   ****   ****   ****   ****   7           7            ****        ****        0            0            1                ****     ****  1879    ****      ****    ****       ****        ****       1          ****       ****       ****       ****       ****       ****       ****     ****             ****             ****      ****              ****              FEAT_GRIM_ANTIMAGIC                                             6               ****        ****     ****          ****     ****        0          HISTORY_FT_CAT       1        0            ****       ****     1      0       ****          ****         1       
3073 FEAT_GRIM_LOCATE_CRTR                                           16777726 16777727    ia_attackmytarget            ****           ****   ****   ****   ****   ****   ****   ****   ****   ****   ****   ****   ****   4           4            ****        ****        0            0            1                ****     ****  1880    ****      ****    ****       ****        ****       0          ****       ****       ****       ****       ****       ****       ****     ****             ****             ****      ****              ****              FEAT_GRIM_LOCATE_CRTR                                           6               ****        ****     ****          ****     ****        0          HISTORY_FT_CAT       1        0            ****       ****     1      0       ****          ****         1       
3074 FEAT_GRIM_LSR_TELEPORT                                          16777726 16777727    ife_NW_teleport              ****           ****   ****   ****   ****   ****   ****   ****   ****   ****   ****   ****   ****   5           5            ****        ****        0            0            1                ****     ****  1881    ****      ****    ****       ****        ****       1          ****       ****       ****       ****       ****       ****       ****     ****             ****             ****      ****              ****              FEAT_GRIM_LSR_TELEPORT                                          6               ****        ****     ****          ****     ****        0          HISTORY_FT_CAT       1        0            ****       ****     1      0       ****          ****         1       
3075 FEAT_GRIM_GRTR_TELEPORT                                         16777726 16777727    ife_NW_teleport              ****           ****   ****   ****   ****   ****   ****   ****   ****   ****   ****   ****   ****   7           7            ****        ****        0            0            1                ****     ****  1882    ****      ****    ****       ****        ****       1          ****       ****       ****       ****       ****       ****       ****     ****             ****             ****      ****              ****              FEAT_GRIM_GRTR_TELEPORT                                         6               ****        ****     ****          ****     ****        0          HISTORY_FT_CAT       1        0            ****       ****     1      0       ****          ****         1       
3076 FEAT_GRIM_TELEPORT_CIRC                                         16777726 16777727    ife_NW_teleport              ****           ****   ****   ****   ****   ****   ****   ****   ****   ****   ****   ****   ****   9           9            ****        ****        0            0            1                ****     ****  1883    ****      ****    ****       ****        ****       0          ****       ****       ****       ****       ****       ****       ****     ****             ****             ****      ****              ****              FEAT_GRIM_TELEPORT_CIRC                                         6               ****        ****     ****          ****     ****        0          HISTORY_FT_CAT       1        0            ****       ****     1      0       ****          ****         1       
3077 FEAT_GRIM_SUMN_OTHER                                            16777726 16777727    is_planebindgreat            ****           ****   ****   ****   ****   ****   ****   ****   ****   ****   ****   ****   ****   9           9            ****        ****        0            0            1                ****     ****  1884    ****      ****    ****       ****        ****       0          ****       ****       ****       ****       ****       ****       ****     ****             ****             ****      ****              ****              FEAT_GRIM_SUMN_OTHER                                            6               ****        ****     ****          ****     ****        0          HISTORY_FT_CAT       1        0            ****       ****     1      0       ****          ****         1       
3078 FEAT_GRIM_LSR_PLNR_SHIFT                                        16777726 16777727    ic_b_shifter                 ****           ****   ****   ****   ****   ****   ****   ****   ****   ****   ****   ****   ****   7           7            ****        ****        0            0            1                ****     ****  1885    ****      ****    ****       ****        ****       1          ****       ****       ****       ****       ****       ****       ****     ****             ****             ****      ****              ****              FEAT_GRIM_LSR_PLNR_SHIFT                                        6               ****        ****     ****          ****     ****        0          HISTORY_FT_CAT       1        0            ****       ****     1      0       ****          ****         1       
3079 FEAT_GRIM_GTR_PLNR_SHIFT                                        16777726 16777727    ic_b_shifter                 ****           ****   ****   ****   ****   ****   ****   ****   ****   ****   ****   ****   ****   9           9            ****        ****        0            0            1                ****     ****  1886    ****      ****    ****       ****        ****       1          ****       ****       ****       ****       ****       ****       ****     ****             ****             ****      ****              ****              FEAT_GRIM_GTR_PLNR_SHIFT                                        6               ****        ****     ****          ****     ****        0          HISTORY_FT_CAT       1        0            ****       ****     1      0       ****          ****         1       
3080 FEAT_GRIM_TMP_STATIS                                            16777726 16777727    ise_timestop                 ****           ****   ****   ****   ****   ****   ****   ****   ****   ****   ****   ****   ****   8           8            ****        ****        0            0            1                ****     ****  1887    ****      ****    ****       ****        ****       0          ****       ****       ****       ****       ****       ****       ****     ****             ****             ****      ****              ****              FEAT_GRIM_TMP_STATIS                                            6               ****        ****     ****          ****     ****        0          HISTORY_FT_CAT       1        0            ****       ****     1      0       ****          ****         1       
3081 FEAT_GRIM_TIMESTOP                                              16777726 16777727    ise_timestop                 ****           ****   ****   ****   ****   ****   ****   ****   ****   ****   ****   ****   ****   9           9            ****        ****        0            0            1                ****     ****  1888    ****      ****    ****       ****        ****       0          ****       ****       ****       ****       ****       ****       ****     ****             ****             ****      ****              ****              FEAT_GRIM_TIMESTOP                                              6               ****        ****     ****          ****     ****        0          HISTORY_FT_CAT       1        0            ****       ****     1      0       ****          ****         1       
3082 FEAT_GRIM_CHIMERA                                               16777726 16777727    ife_BG_createundead          ****           ****   ****   ****   ****   ****   ****   ****   ****   ****   ****   ****   ****   9           9            ****        ****        0            0            1                ****     ****  1889    ****      ****    ****       ****        ****       0          ****       ****       ****       ****       ****       ****       ****     ****             ****             ****      ****              ****              FEAT_GRIM_CHIMERA                                               6               ****        ****     ****          ****     ****        0          HISTORY_FT_CAT       1        0            ****       ****     1      0       ****          ****         1       


// Determine whether oCreature has nFeat, and nFeat is useable.
// - nFeat: FEAT_*
// - oCreature
// JLR - OEI 08/25/05 -- added param
// -- nIgnoreUses -- if true, ignores whether there are uses left for this Feat
//int GetHasFeat(int nFeat, object oCreature=OBJECT_SELF, int nIgnoreUses=FALSE);

///////////////////////////////////////////////////////////////////////////////
// FeatAdd
///////////////////////////////////////////////////////////////////////////////
// Created By:  Brock Heinz - OEI
// Created On:  01/19/06
// Description: Adds a feat to the target creature. with an option to check or
//              bypass the feat's requirements
// Edited 09/30/2008 JWR-OEI
// Arguments:
//  oCreature           - The creature to which you want to add a feat
//  iFeatId             - The Feat ID which you want to add, from Feats.2DA
//  bCheckRequirements  - Whether or not the game should check to see if the
//                      creature meets the feat's prerequisites before adding
// bFeedback            - Whether or not to display feedback in chatlog
// bFeedback            - Whether or not to display "notice" text in center of
//                        the screen
// Returns: TRUE if the feat was added to the creature, otherwise, FALSE
///////////////////////////////////////////////////////////////////////////////
//int FeatAdd( object oCreature, int iFeatId, int bCheckRequirements, int bFeedback=FALSE, int bNotice=FALSE );


*/