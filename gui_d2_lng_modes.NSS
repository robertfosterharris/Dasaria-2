// gui_d2_lng_modes

#include "ginc_chat_funct"

/*

const string LANG_DAS_2DA  ="DAS_Lang";
const string LANG_COL_NAME = "strRef";
const string LANG_COL_DESCRIPT = "Description";
const string LANG_COL_LNG = "Language";
const string LANG_COL_FT = "FeatID";
const string LANG_COL_SID = "SpellID";
const string LANG_COL_SFX = "EffectIcon";
const string LANG_COL_AVL = "Available";
*/


void DoLanguageSelectListbox(object oPC, string sGUI_Name, string sGUI_XMLName);


void main()
{

	object oPC = OBJECT_SELF;
		
	string LNGSEL_GUINAME = "Dasaria2Languages_usegui";
	string LNGSEL_XMLNAME = "Dasaria2Languages_usegui.xml";
	

	//	SendMessageToPC(oPC,"Languages GUI opening");
	Build_LanguageTable_For_GUI(oPC);
	DisplayGuiScreen(oPC,LNGSEL_GUINAME,FALSE,LNGSEL_XMLNAME);
	DoLanguageSelectListbox(oPC, LNGSEL_GUINAME, LNGSEL_XMLNAME);
}




void DoLanguageSelectListbox(object oPC, string sThis_GUIName, string  sThis_XMLName) 
{ 

    //SendMessageToPC(oPC, "DoLanguageSelectListbox");
	int iRow;
	int iMaxRows;

	string sTexts_A, sTextures_A, sVariable1, sVariable2, sVariables;
	
	//	sVariable1 == iLanguageToSpeakSID;
	// 	sVariable2 == iLanguageFeatInUse;
	int iCountLanguagesDisplayed = 0;


	string sLng_2DA_Row;
	string sLng_FeatArray_Identifier;
	string sLng_Selected_Identifier;
	string sLng_Name_Identifier;
	string sLng_Descript_Identifier;
	string sLng_EffectIcon;
	string sLanguage_SpellID;
	
	int iLng_Selected_Identifier;
	
	string LISTBOX_AVAILABLE_1 ="LISTBOX_AVAILABLE_1";
	string LISTBOX_AVAILABLE_TEXT_1 ="LISTBOX_AVAILABLE_TEXT_1=";
	string LISTBOX_AVAILABLE_ICON_1  ="LISTBOX_AVAILABLE_ICON_1=";
	string LISTBOX_AVAILABLE_BUTTON_1  ="LISTBOX_AVAILABLE_BUTTON_1";
	
	string LISTBOX_AVAILABLE_2 ="LISTBOX_AVAILABLE_2";
	string LISTBOX_AVAILABLE_TEXT_2 ="LISTBOX_AVAILABLE_TEXT_2=";
	string LISTBOX_AVAILABLE_ICON_2  ="LISTBOX_AVAILABLE_ICON_2=";
	string LISTBOX_AVAILABLE_BUTTON_2  ="LISTBOX_AVAILABLE_BUTTON_2";
	
	string LISTBOX_AVAILABLE_3 ="LISTBOX_AVAILABLE_3";
	string LISTBOX_AVAILABLE_TEXT_3 ="LISTBOX_AVAILABLE_TEXT_3=";
	string LISTBOX_AVAILABLE_ICON_3  ="LISTBOX_AVAILABLE_ICON_3=";
	string LISTBOX_AVAILABLE_BUTTON_3  ="LISTBOX_AVAILABLE_BUTTON_3";	
	
	iMaxRows = GetLocalInt(oPC , LANG_ARRAY_FEATID0);
	

	//SendMessageToPC(oPC, "iMaxRows = " + IntToString(iMaxRows));	
	
	
	// open gui and clear any listbox items from an earlier viewing 

	ClearListBox(oPC, sThis_GUIName, LISTBOX_AVAILABLE_1); 
	ClearListBox(oPC, sThis_GUIName, LISTBOX_AVAILABLE_2);
	ClearListBox(oPC, sThis_GUIName, LISTBOX_AVAILABLE_3);	 
		
	//Loop over each entry in the Languages2DA
	for(iRow=1;iRow <= iMaxRows; iRow++)
	{
			sLng_Selected_Identifier = LANG_ARRAY_SELECTED + IntToString(iRow);
			iLng_Selected_Identifier = GetLocalInt(oPC , sLng_Selected_Identifier); 
			
			if(iLng_Selected_Identifier == LANG_ARRAY_SELECTED_KNOWN)
			
			{
	
				iCountLanguagesDisplayed = iCountLanguagesDisplayed + 1;
				
				sLng_Name_Identifier = LANG_ARRAY_NAME + IntToString(iRow);
				sLng_EffectIcon = LANG_ARRAY_EFFECTICON + IntToString(iRow);
				sLng_FeatArray_Identifier = LANG_ARRAY_FEATID + IntToString(iRow);
				sLanguage_SpellID = LANG_ARRAY_SPELLID +  IntToString(iRow);	
		
				if(iCountLanguagesDisplayed <= 10)
				{
					sTexts_A = LISTBOX_AVAILABLE_TEXT_1 + GetStringByStrRef(GetLocalInt(oPC, sLng_Name_Identifier));
					sTextures_A = LISTBOX_AVAILABLE_ICON_1 +GetLanguageIconResRef(GetLocalInt(oPC, sLng_EffectIcon)); 
					
					sVariable1 = "1=" + IntToString(GetLocalInt(oPC, sLanguage_SpellID));				
					sVariable2 = "2=" + IntToString(GetLocalInt(oPC, sLng_FeatArray_Identifier));
		
				
					sVariables = sVariable1+";"+sVariable2;
					//SendMessageToPC(oPC, "sVariables = #" + sVariables+ "#");			
					AddListBoxRow(oPC, sThis_GUIName , LISTBOX_AVAILABLE_1, "Entry_A" + IntToString(iRow), sTexts_A, sTextures_A, sVariables, ""); 
				}
				
				if(iCountLanguagesDisplayed > 10 && iCountLanguagesDisplayed <= 20)
				{
					sTexts_A = LISTBOX_AVAILABLE_TEXT_2 + GetStringByStrRef(GetLocalInt(oPC, sLng_Name_Identifier));
					sTextures_A = LISTBOX_AVAILABLE_ICON_2 +GetLanguageIconResRef(GetLocalInt(oPC, sLng_EffectIcon)); 
					
					sVariable1 = "1=" + IntToString(GetLocalInt(oPC, sLanguage_SpellID));				
					sVariable2 = "2=" + IntToString(GetLocalInt(oPC, sLng_FeatArray_Identifier));
		
				
					sVariables = sVariable1+";"+sVariable2;
					//SendMessageToPC(oPC, "sVariables = #" + sVariables+ "#");			
					AddListBoxRow(oPC, sThis_GUIName , LISTBOX_AVAILABLE_2, "Entry_A" + IntToString(iRow), sTexts_A, sTextures_A, sVariables, ""); 
				}				
				
				if(iCountLanguagesDisplayed > 20)
				{
					sTexts_A = LISTBOX_AVAILABLE_TEXT_3 + GetStringByStrRef(GetLocalInt(oPC, sLng_Name_Identifier));
					sTextures_A = LISTBOX_AVAILABLE_ICON_3 +GetLanguageIconResRef(GetLocalInt(oPC, sLng_EffectIcon)); 
					
					sVariable1 = "1=" + IntToString(GetLocalInt(oPC, sLanguage_SpellID));				
					sVariable2 = "2=" + IntToString(GetLocalInt(oPC, sLng_FeatArray_Identifier));
		
				
					sVariables = sVariable1+";"+sVariable2;
					//SendMessageToPC(oPC, "sVariables = #" + sVariables+ "#");			
					AddListBoxRow(oPC, sThis_GUIName , LISTBOX_AVAILABLE_3, "Entry_A" + IntToString(iRow), sTexts_A, sTextures_A, sVariables, ""); 
				}				
				
				
			}			
	}

}