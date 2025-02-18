/*

	2006/1/2	wyvern
		Initial revision

*/

#include "ginc_chat_funct"
#include "std_i0_xp"
#include "d2_sql_log"



void reset_xp_for_level(object oPC, int pc_level);
int get_xp_for_level(object oPC, int level);




void main() {

	object oPC = GetPCLevellingUp();
	int pc_level = GetHitDice(oPC);
	int iLang_Skillpoints;
	
	reset_xp_for_level(oPC, pc_level);
	
	ResetHertitageFeatUses(oPC);
		 
	iLang_Skillpoints = CalculateLngSkillPointsRemaining(oPC);
	
	if(iLang_Skillpoints > 0 )
	{
	
		SetLocalInt(oPC, "iCloseLanguageGUI", 1);
		
		if(GetRacialType(oPC) < 46  &&  !GetHasFeat(LNG_FEAT_COMMON_D, oPC))
		{
			Add_LNG_Feats(oPC);	
		}
		
		if(	GetLevelByClass(CLASS_TYPE_ROGUE, oPC) > 0 )	
		{
			if(!GetHasFeat(StringToInt(Get2DAString(LANG_DAS_2DA, LANG_COL_FT, LNG_KALEM)), oPC) )
			{
				AddLanguageFeatToPC( oPC, LNG_KALEM );
			}
			
		}

		if(	GetLevelByClass(CLASS_TYPE_DRAGON, oPC) > 0 )	
		{
			if(!GetHasFeat(StringToInt(Get2DAString(LANG_DAS_2DA, LANG_COL_FT, LNG_DRAGON_D)), oPC) )
			{
				AddLanguageFeatToPC( oPC, LNG_DRAGON_D );
			}
			
		}
		
		if(	GetLevelByClass(CLASS_TYPE_CLERIC, oPC) > 0 || GetLevelByClass(CLASS_TYPE_PALADIN, oPC) > 0 )	
		{
			if(!GetHasFeat(StringToInt(Get2DAString(LANG_DAS_2DA, LANG_COL_FT, LNG_DAWN_TONGUE)), oPC) )
			{
				AddLanguageFeatToPC( oPC, LNG_DAWN_TONGUE );
			}
				
		}
		
		if(	GetLevelByClass(CLASS_TYPE_DRUID, oPC) > 0 )	
		{
			if(!GetHasFeat(StringToInt(Get2DAString(LANG_DAS_2DA, LANG_COL_FT, LNG_DRUID_D)), oPC) )
			{
				AddLanguageFeatToPC( oPC, LNG_DRUID_D );
			}
		}			
		
		
			
		Build_LanguageTable_For_GUI(oPC);
		DisplayGuiScreen(oPC, LNG_GUINAME, FALSE, LNG_XMLNAME); 
		DoLanguageListbox(oPC, LNG_GUINAME, LNG_XMLNAME);
	}
	
	trackEvent(oPC,"LEVELUP",OBJECT_INVALID,pc_level);
	
}




void reset_xp_for_level(object oPC, int pc_level) {
	
	int ecl_modifier = xp_util_level_ecl_modifier(GetSubRace(oPC));
	int pc_effective_level = pc_level + ecl_modifier;
	SendMessageToPC(oPC, "ECL modifier is " + IntToString(ecl_modifier));
	SendMessageToPC(oPC, "effective level is " + IntToString(pc_effective_level));

	int xp_limit_for_level = get_xp_for_level(oPC, pc_effective_level);
	int xp_limit_for_next_level = get_xp_for_level(oPC, pc_effective_level + 1);
	int xp_buffer = (xp_limit_for_next_level - xp_limit_for_level) / 2;
	int pc_xp = GetXP(oPC);
	int xp_difference = pc_xp - xp_limit_for_level;
	if (xp_difference > xp_buffer) {
		xp_difference = xp_buffer;
	}
	
	
	SendMessageToPC(oPC, "rebalancing experience gained based on level: " +  IntToString(xp_limit_for_level + xp_difference));
	SetXP(oPC, xp_limit_for_level + xp_difference);
}







int get_xp_for_level(object oPC, int level) {
	switch (level) {
		case 1:
			return 0;
		case 2:
			return 1000;
		case 3:
			return 3000;
		case 4:
			return 6000;
		case 5:
			return 10000;
		case 6:
			return 15000;
		case 7:
			return 21000;
		case 8:
			return 28000;
		case 9:
			return 36000;
		case 10:
			return 45000;
		case 11:
			return 55000;
		case 12:
			return 66000;
		case 13:
			return 78000;
		case 14:
			return 91000;
		case 15:
			return 105000;
		case 16:
			return 120000;
		case 17:
			return 136000;
		case 18:
			return 153000;
		case 19:
			return 171000;
		case 20:
			return 190000;
		case 21:
			return 210000;
		case 22:
			return 231000;
		case 23:
			return 253000;
		default:
			return GetXP(oPC);
		}
		return GetXP(oPC);
}



/*
*/