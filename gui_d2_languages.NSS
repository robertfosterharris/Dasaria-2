
#include "ginc_gui_d2_languages"


void main(string sVariable1, string sVariable2, string sVariable3)

{
	string sLanguage_RowID = sVariable2;
	string sLanguage_FeatID = sVariable3;
	string sLng_Name_Identifier;
	string sLng_Descript_Identifier;
	string sLng_Selected_Identifier;
	string sDescription;
	int iSelector;
	int iLng_Name_StrRef;
	int iLng_Descript_StrRef;
	int iSkillPointsAvailable;

	int iWelcomeGUI;
	
	object oPC = OBJECT_SELF;

	if(!GetIsPC(oPC))
	{
		CloseGUIScreen(oPC, LNG_GUINAME);
		return;
	}
	
	
	if(sVariable1=="text")
	{
		//TEXT DISPLAY
		sLng_Name_Identifier = LANG_ARRAY_NAME + sVariable2;
		sLng_Descript_Identifier = LANG_ARRAY_DESCRIPT + sVariable2;
		iLng_Name_StrRef = GetLocalInt(oPC, sLng_Name_Identifier);
		iLng_Descript_StrRef = GetLocalInt(oPC, sLng_Descript_Identifier);
		sDescription ="<b>" +  GetStringByStrRef(iLng_Name_StrRef) + "</b>" + CLR_NEWLINE + CLR_NEWLINE + "<b>Description:</b> " + GetStringByStrRef(iLng_Descript_StrRef);
		
		SetGUIObjectText(oPC, LNG_GUINAME, LNG_DESC, -1, "");	
		SetGUIObjectText(oPC, LNG_GUINAME, LNG_DESC, -1, sDescription);	
	}
	
	else if(sVariable1=="select")
	{
		//SendMessageToPC(oPC, "DONE");	
		AddSelectedLanguages(oPC);
		CloseGUIScreen(oPC, LNG_GUINAME);
	}
	
	else
	{
		//SendMessageToPC(oPC, "SELECT A LANGUAGE");	
		iSelector = StringToInt(sVariable1);
		iSkillPointsAvailable = CalculateLngSkillPointsRemaining(oPC);
		
		if(iSelector == LANG_ARRAY_SELECTED_FALSE && iSkillPointsAvailable > 0 )
		{
			sLng_Selected_Identifier = LANG_ARRAY_SELECTED + sLanguage_RowID;
			SetLocalInt(oPC, sLng_Selected_Identifier, LANG_ARRAY_SELECTED_TRUE);
			DoLanguageListbox(oPC, LNG_GUINAME, LNG_XMLNAME);
			sLng_Name_Identifier = LANG_ARRAY_NAME + sVariable2;
			sLng_Descript_Identifier = LANG_ARRAY_DESCRIPT + sVariable2;
			iLng_Name_StrRef = GetLocalInt(oPC, sLng_Name_Identifier);
			iLng_Descript_StrRef = GetLocalInt(oPC, sLng_Descript_Identifier);
			sDescription ="<b>" +  GetStringByStrRef(iLng_Name_StrRef) + "</b>" + CLR_NEWLINE + CLR_NEWLINE + "<b>Description:</b> " + GetStringByStrRef(iLng_Descript_StrRef);
			SetGUIObjectText(oPC, LNG_GUINAME, LNG_DESC, -1, "");	
			SetGUIObjectText(oPC, LNG_GUINAME, LNG_DESC, -1, sDescription);				
			
		}
		if(iSelector == LANG_ARRAY_SELECTED_TRUE)
		{
			sLng_Selected_Identifier = LANG_ARRAY_SELECTED + sLanguage_RowID;
			SetLocalInt(oPC, sLng_Selected_Identifier, LANG_ARRAY_SELECTED_FALSE);
			DoLanguageListbox(oPC, LNG_GUINAME, LNG_XMLNAME);
			SetGUIObjectText(oPC, LNG_GUINAME, LNG_DESC, -1, "");	
		}
	}
}