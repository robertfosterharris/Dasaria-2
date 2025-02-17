// gc_skill_dc_private(int nSkill, int nDC)
/*
	Determine if PC Speaker's skill roll is successful.
	
	Parameters:
		int nSkill 	= skill int to check
		int nDC		= difficulty class to beat
	
	Remarks:
	int SKILL_CONCENTRATION    = 1;
	int SKILL_DISABLE_TRAP     = 2;
	int SKILL_DISCIPLINE       = 3;
	int SKILL_HEAL             = 4;
	int SKILL_HIDE             = 5;
	int SKILL_LISTEN           = 6;
	int SKILL_LORE             = 7;
	int SKILL_MOVE_SILENTLY    = 8;
	int SKILL_OPEN_LOCK        = 9;
	int SKILL_PARRY            = 10;
	int SKILL_PERFORM          = 11;
	int SKILL_DIPLOMACY        = 12;
	int SKILL_SLEIGHT_OF_HAND  = 13;
	int SKILL_SEARCH           = 14;
	int SKILL_SET_TRAP         = 15;
	int SKILL_SPELLCRAFT       = 16;
	int SKILL_SPOT             = 17;
	int SKILL_TAUNT            = 18;
	int SKILL_USE_MAGIC_DEVICE = 19;
	int SKILL_APPRAISE         = 20;
	int SKILL_TUMBLE           = 21;
	int SKILL_CRAFT_TRAP       = 22;
	int SKILL_BLUFF            = 23;
	int SKILL_INTIMIDATE       = 24;
	int SKILL_CRAFT_ARMOR      = 25;
	int SKILL_CRAFT_WEAPON     = 26;
	int SKILL_CRAFT_ALCHEMY    = 27;
	int SKILL_RIDE             = 28;
	int SKILL_SURVIVAL         = 29;
	int SKILL_SPEAK_LANGUAGE   = 30;
	int SKILL_SENSE_MOTIVE     = 31;
*/
//	ROBERT HARRIS	11/30/2007		ROBERTHARRIS@ROBERTHARRIS.COM
//
#include "std_i0_skill"

int StartingConditional(int nSkill, int nDC)
{
	return GetIsSkillSuccessfulPrivate(GetPCSpeaker(), nSkill, nDC);
}