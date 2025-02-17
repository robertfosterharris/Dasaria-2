#include "std_persist_i0"
#include "ginc_custom_races"
#include "ginc_gui_d2_languages"

const string HUM_DESC = "HUMAN_DESC"; 


void main(string sInput1, string sInput2)
{
	object oPC = OBJECT_SELF;
	string sDescription;
	object oJournal;
	int iLang_Skillpoints;
	
	if(sInput1=="display")
	{
		SetGUIObjectText(oPC, HUMAN_GUINAME, HUM_DESC, -1, "");	
		SetGUIObjectText(oPC, HUMAN_GUINAME, HUM_DESC, -1, sHumanDescription(sInput2) );
		SetLocalGUIVariable( oPC, HUMAN_GUINAME, 2, sInput2 );
		SetGUIObjectDisabled( oPC, HUMAN_GUINAME,"SELECT_RACE" , FALSE);
		
	}
	if(sInput1=="select")
	{
		SetHumanHeritage( oPC, sInput2);
		CloseGUIScreen(oPC, HUMAN_GUINAME );
		
		
		//Pop Language screen if necessary
		oJournal = std_journal_get(oPC);
		
		if( GetLocalInt( oJournal, "std_login_count") ==1 )
		{
			if(	GetLevelByClass(CLASS_TYPE_ROGUE, oPC) > 0 )	
			{
				if(!GetHasFeat(StringToInt(Get2DAString(LANG_DAS_2DA, LANG_COL_FT, LNG_KALEM)), oPC) )
				{
					AddSelectLanguageFeatToPC( oPC, LNG_KALEM);
				}
				
			}
	
			if(	GetLevelByClass(CLASS_TYPE_DRAGON, oPC) > 0 )	
			{
				if(!GetHasFeat(StringToInt(Get2DAString(LANG_DAS_2DA, LANG_COL_FT, LNG_DRAGON_D)), oPC) )
				{
					AddSelectLanguageFeatToPC( oPC, LNG_DRAGON_D );
				}
				
			}
			
			if(	GetLevelByClass(CLASS_TYPE_CLERIC, oPC) > 0 || GetLevelByClass(CLASS_TYPE_PALADIN, oPC) > 0 )	
			{
				if(!GetHasFeat(StringToInt(Get2DAString(LANG_DAS_2DA, LANG_COL_FT, LNG_DAWN_TONGUE)), oPC) )
				{
					AddSelectLanguageFeatToPC( oPC, LNG_DAWN_TONGUE );
				}
					
			}
			
			if(	GetLevelByClass(CLASS_TYPE_DRUID, oPC) > 0 )	
			{
				if(!GetHasFeat(StringToInt(Get2DAString(LANG_DAS_2DA, LANG_COL_FT, LNG_DRUID_D)), oPC) )
				{
					AddSelectLanguageFeatToPC( oPC, LNG_DRUID_D );
				}
			}				
		
			Build_LanguageTable_For_GUI(oPC);
			DisplayGuiScreen(oPC, LNG_GUINAME, FALSE, LNG_XMLNAME); 
			DoLanguageListbox(oPC, LNG_GUINAME, LNG_XMLNAME);				
		}
		
		
		
	}


}