#include "ginc_custom_races"
#include "ginc_custom_skills"
#include "ginc_chat_const"


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


//11/11/12 updates for ginc_setlanguage_modes

//================= Dasaria2LanguagesPickGUI.xml CONSTANTS =============

const string  LNG_GUINAME = "Dasaria2LanguagesPickGUI";
const string  LNG_XMLNAME = "Dasaria2LanguagesPickGUI.xml";

const string LISTBOX_AVAILABLE ="LISTBOX_AVAILABLE";
const string LISTBOX_AVAILABLE_TEXT ="LISTBOX_AVAILABLE_TEXT=";
const string LISTBOX_AVAILABLE_ICON  ="LISTBOX_AVAILABLE_ICON=";
const string LISTBOX_AVAILABLE_BUTTON  ="LISTBOX_AVAILABLE_BUTTON";

/*
const string LISTBOX_KNOWN ="LISTBOX_AVAILABLE";
const string LISTBOX_KNOWN_TEXT ="LISTBOX_AVAILABLE_TEXT=";
const string LISTBOX_KNOWN_ICON ="LISTBOX_AVAILABLE_ICON=";
*/

const string LISTBOX_SELECTED ="LISTBOX_SELECTED";
const string LISTBOX_SELECTED_TEXT ="LISTBOX_SELECTED_TEXT=";
const string LISTBOX_SELECTED_ICON ="LISTBOX_SELECTED_ICON=";
const string LISTBOX_SELECTED_BUTTON ="LISTBOX_SELECTED_BUTTON";

const string LNG_SKILLPOINTS ="LNG_SKILLPOINTS";
const string LNG_DESC ="LNG_DESC";

//================= Build_LanguageTable_For_GUI CONSTANTS =============

//const string LANG_ARRAY_NAME = "sLNG_N";
const string LANG_ARRAY_FEATID = "sLNG_FeatID";
const string LANG_ARRAY_FEATID0 = "sLNG_FeatID0";
const string LANG_ARRAY_SELECTED = "sLNG_S";
const string LANG_ARRAY_NAME = "sLNG_N";
const string LANG_ARRAY_DESCRIPT = "sLNG_D";
const string LANG_ARRAY_EFFECTICON = "sLNG_EI";
const string LANG_ARRAY_2DA_ROW = "sLNG_2DARow";
//11/11/12
const string LANG_ARRAY_SPELLID = "sLNG_SpellID";

const int LANG_ARRAY_SELECTED_FALSE = 0;
const int LANG_ARRAY_SELECTED_TRUE = 1;
const int LANG_ARRAY_SELECTED_KNOWN = 2;
const int LANG_ARRAY_SELECTED_UNAVAIL = 3;


// ************************** DECLARATIONS *************************************


//Purpose: Pseudo Array for managing Select Language GUI
//Reads from Das_Lang.2DA and stores data (temporarily) on oPC
void Build_LanguageTable_For_GUI(object oPC);

void DoLanguageListbox(object oPC, string sThis_GUIName, string  sThis_XMLName);

string GetLanguageIconResRef(int iRow);

int CountRacialLanguages(object oPC);

int CalculateBaseAbilityBonus(object oPC, int iAbility);

int CountKnownLanguages(object PC);

int CountSelectedLanguages(object PC);

int CalculateLngSkillPointsRemaining(object oPC);

void AddSelectLanguageFeatToPC(object oPC, int Das_Lang_2DARow);

void AddSelectedLanguages(object oPC);

void AddHumanHeritageLanguages(object oPC);

// ************************** FUNCTIONS ****************************************

int CalculateLngSkillPointsRemaining(object oPC )
{
	int iSpeakLanguageSkill = GetSkillRank(SKILL_SPEAK_LANGUAGE ,oPC, TRUE)+ CalculateBaseAbilityBonus(oPC, ABILITY_INTELLIGENCE);
	int iRacialLanguageModifer = CountRacialLanguages(oPC);
	int iKnownLanguages = CountKnownLanguages(oPC);
	int iSelectedLanguages = CountSelectedLanguages(oPC);
	int iSkillPointsRemaining;
	int iSubRace;	
	
	iSkillPointsRemaining = ((iSpeakLanguageSkill + iRacialLanguageModifer) - (iKnownLanguages + iSelectedLanguages));

	
//	SendMessageToPC(oPC, "iSpeakLanguageSkill " +IntToString(iSpeakLanguageSkill) + " + iRacialLanguageModifer " +IntToString(iRacialLanguageModifer)+ "- iKnownLanguages" +IntToString(iKnownLanguages)+" + iSelectedLanguages" +IntToString(iSelectedLanguages));
//	SendMessageToPC(oPC, "GetSkillRank " +IntToString(GetSkillRank(SKILL_SPEAK_LANGUAGE ,oPC, TRUE)) + " + CalculateBaseAbilityBonus " +IntToString(CalculateBaseAbilityBonus(oPC, ABILITY_INTELLIGENCE)) );
	
	
		
	return iSkillPointsRemaining;
}


int CountRacialLanguages(object oPC)
{
	int iPC_Race = GetRacialType(oPC);
	int iPC_Subrace = GetSubRace(oPC);
	int iRacialModifier;

	if(iPC_Subrace == RACIAL_SUBTYPE_HUMAN_VANILLA)
	{
	  iPC_Subrace = iReturnHumanSubRace(oPC);
	}
		
	//old vanilla races check
	
	if(iPC_Subrace < 49) //49 = cut off for old races in racilasubtypes.2da
	{
		switch(iPC_Race)
		{
		case RACIAL_TYPE_DWARF: //0
			iRacialModifier = 2;
			break;
        case RACIAL_TYPE_ELF: // 1
			iRacialModifier = 2;
			break;                  
        case RACIAL_TYPE_GNOME: //2
			iRacialModifier = 3;
			break;               
        case RACIAL_TYPE_HALFLING: //3
			iRacialModifier = 1;
			break;             
        case RACIAL_TYPE_HALFELF: // 4
			iRacialModifier = 2;
			break;
        case RACIAL_TYPE_HALFORC: //5
			iRacialModifier = 2;
			break;  
		case RACIAL_TYPE_HUMAN: //6
			iRacialModifier = 1;
			break;
		case RACIAL_TYPE_OUTSIDER: //20
			iRacialModifier = 2;
			break; 
  			  	 			           
		default:
			iRacialModifier = 0;
		break;
		}
		if (GetLevelByClass(CLASS_TYPE_CLERIC, oPC)!=0)
			iRacialModifier = iRacialModifier+1;	
			
		if (GetLevelByClass(CLASS_TYPE_DRAGONDISCIPLE, oPC)!=0)
		 	iRacialModifier = iRacialModifier+1;
	 	
		if (GetLevelByClass(CLASS_TYPE_DRUID, oPC)!=0)
		 	iRacialModifier = iRacialModifier+1;	
		
		if (GetLevelByClass(CLASS_TYPE_ROGUE, oPC)!=0)
		 	iRacialModifier = iRacialModifier+1;

	}
	else
	{	
		switch(iPC_Subrace)
		{
		case RACIAL_SUBTYPE_HUMAN_D:
			iRacialModifier = 1;
		break;
		case RACIAL_SUBTYPE_HUMAN_VO:
			iRacialModifier = 1;
		break;
		case RACIAL_SUBTYPE_HUMAN_VN:
			iRacialModifier = 1;
		break;	
		case RACIAL_SUBTYPE_HUMAN_VDA:
			iRacialModifier = 2;
		break;	
		case RACIAL_SUBTYPE_HUMAN_VDU:
			iRacialModifier = 1;
		break;
		case RACIAL_SUBTYPE_HUMAN_VR:
			iRacialModifier = 2;
		break;	
		case RACIAL_SUBTYPE_HUMAN_VI:
			iRacialModifier = 1;
		break;	
		case RACIAL_SUBTYPE_HUMAN_C:
			iRacialModifier = 1;
		break;	
		case RACIAL_SUBTYPE_HUMAN_T:
			iRacialModifier = 1;
		break;	
		case RACIAL_SUBTYPE_HUMAN_F:
			iRacialModifier = 1;
		break;	
		case RACIAL_SUBTYPE_DWARF_F:
			iRacialModifier = 1;
		break;	
		case RACIAL_SUBTYPE_DWARF_S:
			iRacialModifier = 1;
		break;
		case RACIAL_SUBTYPE_DWARF_R:
			iRacialModifier = 0; //inactive race
		break;
		case RACIAL_SUBTYPE_ELF_R:
			iRacialModifier = 1;
		break;
		case RACIAL_SUBTYPE_ELF_I:
			iRacialModifier = 2;
		break;
		case RACIAL_SUBTYPE_ELF_T:
			iRacialModifier = 1;
		break;
		case RACIAL_SUBTYPE_GNOME_D:
			iRacialModifier = 2;
		break;
		case RACIAL_SUBTYPE_GNOME_F:
			iRacialModifier = 0; //inactive race
		break;
		case RACIAL_SUBTYPE_HALFLING_F:
			iRacialModifier = 1;
		break;
		case RACIAL_SUBTYPE_HALFLING_B:
			iRacialModifier = 0; //inactive race
		break;
		case RACIAL_SUBTYPE_HALFELF_R:
			iRacialModifier = 2;
		break;
		case RACIAL_SUBTYPE_HALFELF_I:
			iRacialModifier = 2;
		break;
		case RACIAL_SUBTYPE_HALFORC_D:
			iRacialModifier = 1;
		break;
		case RACIAL_SUBTYPE_HALFORC_K:
			iRacialModifier = 1;
		break;
		case RACIAL_SUBTYPE_HALFORC_V:
			iRacialModifier = 2;
		break;
		case RACIAL_SUBTYPE_HALFORC_T:
			iRacialModifier = 1;
		break;
		case RACIAL_SUBTYPE_PT_BARAAN:
			iRacialModifier = 3;
		break;
		case RACIAL_SUBTYPE_PT_REL:
			iRacialModifier = 1;
		break;
		case RACIAL_SUBTYPE_PT_COLOTH:
			iRacialModifier = 1;
		break;
		case RACIAL_SUBTYPE_PT_NUARARI:
			iRacialModifier = 1;
		break;
		case RACIAL_SUBTYPE_PT_INEANIA:
			iRacialModifier = 1;
		break;	
		case RACIAL_SUBTYPE_PT_TESHALIA:
			iRacialModifier = 1;
		break;
		case RACIAL_SUBTYPE_PT_CHTAIA:
			iRacialModifier = 1;
		break;
		case RACIAL_SUBTYPE_PT_EXO:
			iRacialModifier = 1;
		break;																					
		default:
			iRacialModifier = 0;
		break;
		}
		
		if (GetLevelByClass(CLASS_TYPE_DRAGONDISCIPLE, oPC)!=0)
		 	iRacialModifier = iRacialModifier+1;
	 	
		if (GetLevelByClass(CLASS_TYPE_DRUID, oPC)!=0)
		 	iRacialModifier = iRacialModifier+1;	
		
		if (GetLevelByClass(CLASS_TYPE_ROGUE, oPC)!=0)
		 	iRacialModifier = iRacialModifier+1;
		
	}
	
	
	return iRacialModifier;
}

int CalculateBaseAbilityBonus(object oPC, int iAbility)
{

	int iAbilityToCheck = GetAbilityScore(oPC, iAbility, TRUE);
	int iAbilityMod = 0;
	int iSubRace;

	iSubRace = GetSubRace(oPC);	

	if(iSubRace == RACIAL_SUBTYPE_DROW){iAbilityToCheck = iAbilityToCheck +2;}
	if(iSubRace == RACIAL_SUBTYPE_HALFORC){iAbilityToCheck = iAbilityToCheck -2;}	
	if(iSubRace == RACIAL_SUBTYPE_SUN_ELF){iAbilityToCheck = iAbilityToCheck +2;}	
	if(iSubRace == RACIAL_SUBTYPE_WILD_ELF){iAbilityToCheck = iAbilityToCheck -2;}
	if(iSubRace == RACIAL_SUBTYPE_WOOD_ELF){iAbilityToCheck = iAbilityToCheck -2;}
	if(iSubRace == RACIAL_SUBTYPE_TIEFLING){iAbilityToCheck = iAbilityToCheck +2;}
				
	if(iSubRace == RACIAL_SUBTYPE_ELF_I){iAbilityToCheck = iAbilityToCheck +2;}
	if(iSubRace == RACIAL_SUBTYPE_ELF_T){iAbilityToCheck = iAbilityToCheck +2;}
	if(iSubRace == RACIAL_SUBTYPE_PT_COLOTH){iAbilityToCheck = iAbilityToCheck +2;}		
	if(iSubRace == RACIAL_SUBTYPE_PT_CHTAIA){iAbilityToCheck = iAbilityToCheck +2;}	
	if(iSubRace == RACIAL_SUBTYPE_PT_EXO){iAbilityToCheck = iAbilityToCheck +1;}	
	if(iSubRace == RACIAL_SUBTYPE_HALFORC_D){iAbilityToCheck = iAbilityToCheck -2 ;}	
	if(iSubRace == RACIAL_SUBTYPE_HALFORC_K){iAbilityToCheck = iAbilityToCheck -2 ;}	
	if(iSubRace == RACIAL_SUBTYPE_HALFORC_T){iAbilityToCheck = iAbilityToCheck -2 ;}	
	if(iSubRace == RACIAL_SUBTYPE_HALFORC_V){iAbilityToCheck = iAbilityToCheck -2 ;}	
												
	iAbilityMod = ( -5 + (iAbilityToCheck/2));
	
	return iAbilityMod;
}

int CountKnownLanguages(object oPC)
{
	int iCountKnownLanguages = 0;
	int iRow;
	int iMaxRows;
	int iShowRow;
	int iLanguage_FeatID;
	
	string sLng_Selected_Identifier;
	string sLng_FeatArray_Identifier;
	string sLanguage_FeatID;	
	
	iMaxRows = GetLocalInt(oPC, LANG_ARRAY_FEATID0 );
		
	//Loop over each stored language entry on the PC
	for(iRow=1;iRow < iMaxRows; iRow++)
	{
		sLng_FeatArray_Identifier = LANG_ARRAY_FEATID + IntToString(iRow);
		sLng_Selected_Identifier = LANG_ARRAY_SELECTED + IntToString(iRow);
		iLanguage_FeatID = GetLocalInt(oPC, sLng_FeatArray_Identifier);	
		
		if(GetHasFeat(iLanguage_FeatID, oPC, TRUE))
		{
			SetLocalInt(oPC, sLng_Selected_Identifier, LANG_ARRAY_SELECTED_KNOWN );
			iCountKnownLanguages = iCountKnownLanguages +1;
		}
	}

	return iCountKnownLanguages;
}


int CountSelectedLanguages(object oPC)
{
	int iCountSelectedLanguages = 0;
	int iRow;
	int iMaxRows;
	int iShowRow;
	int iLanguage_Selected;
	
	string sLng_Selected_Identifier;
	
	iMaxRows = GetLocalInt(oPC, LANG_ARRAY_FEATID0 );
		
	//Loop over each stored language entry on the PC
	for(iRow=1;iRow < iMaxRows; iRow++)
	{

		sLng_Selected_Identifier = LANG_ARRAY_SELECTED + IntToString(iRow);
		iLanguage_Selected = GetLocalInt(oPC, sLng_Selected_Identifier);	
		
		if(iLanguage_Selected == LANG_ARRAY_SELECTED_TRUE )
		{
			iCountSelectedLanguages = iCountSelectedLanguages +1;
		}
	}

	return iCountSelectedLanguages;
}



string GetLanguageIconResRef(int iRow) 
{ 
	string sIcon = Get2DAString("effecticons", "Icon", iRow); 
	return sIcon == "" ? "temp0.tga" : sIcon + ".tga"; 
}



void DoLanguageListbox(object oPC, string sThis_GUIName, string  sThis_XMLName) 
{ 

//SendMessageToPC(oPC, "DoLanguageListbox");
	int iRow;
	int iMaxRows;
	int iShowRow;
	string sTexts_A , sTexts_S ,  sTextures_A ,sTextures_S , sVariable1, sVariable2, sVariable3, sVariables;
	
	string sLng_2DA_Row;
	string sLng_FeatArray_Identifier;
	string sLng_Selected_Identifier;
	string sLng_Name_Identifier;
	string sLng_EffectIcon;

	int i2DA_Row;
	int iLanguage_FeatID;
	int iLanguage_Name_strRef;
	int iLanguage_EffectIcon;

	int iCountRacialLanguages =0;
	int iCountKnownLanguages =0;
	int iCountSelectedLanguages =0;
	int iCalculateLngSkillPoints =0;
	
	string sCountKnownLanguages;
	string sCountSelectedLanguages;
	string sCalculateLngSkillPoints;
	
	AddHumanHeritageLanguages(oPC);
	
	iCalculateLngSkillPoints = CalculateLngSkillPointsRemaining( oPC );
	
	//SendMessageToPC(oPC, "###iCalculateLngSkillPoints"+IntToString(iCalculateLngSkillPoints));	
	if(iCalculateLngSkillPoints <= 0 && GetLocalInt(oPC, "iCloseLanguageGUI")== 1)
	{
	  CloseGUIScreen(oPC, LNG_GUINAME);
	  SendMessageToPC(oPC, CLR_PC_CHAT_MESSAGE+ "No Language Skill points available" + CLR_END);
	}
	else{
	
		SetLocalInt(oPC, "iCloseLanguageGUI", 0);
		
		sCalculateLngSkillPoints = IntToString(iCalculateLngSkillPoints);
		
		//SendMessageToPC(oPC, "sCalculateLngSkillPoints###"+sCalculateLngSkillPoints);		
		
		SetGUIObjectText(oPC, LNG_GUINAME, LNG_SKILLPOINTS, -1, sCalculateLngSkillPoints);
		
		iMaxRows = GetLocalInt(oPC, LANG_ARRAY_FEATID0 );
		
		// open gui and clear any listbox items from an earlier viewing 
	 
		ClearListBox(oPC, LNG_GUINAME, LISTBOX_AVAILABLE); 
		ClearListBox(oPC, LNG_GUINAME, LISTBOX_SELECTED); 
			
		//Loop over each entry in the Languages2DA
		for(iRow=1;iRow <= iMaxRows; iRow++)
		{
			sLng_2DA_Row = LANG_ARRAY_2DA_ROW + IntToString(iRow);
			sLng_FeatArray_Identifier = LANG_ARRAY_FEATID + IntToString(iRow);
			sLng_Selected_Identifier = LANG_ARRAY_SELECTED + IntToString(iRow);
			sLng_Name_Identifier = LANG_ARRAY_NAME + IntToString(iRow);
			sLng_EffectIcon = LANG_ARRAY_EFFECTICON +  IntToString(iRow);
	
			i2DA_Row = GetLocalInt(oPC, sLng_2DA_Row);	
			iLanguage_FeatID = GetLocalInt(oPC, sLng_FeatArray_Identifier);	
			iShowRow = GetLocalInt(oPC, sLng_Selected_Identifier);
			iLanguage_Name_strRef = GetLocalInt(oPC, sLng_Name_Identifier);
			iLanguage_EffectIcon = GetLocalInt(oPC, sLng_EffectIcon);
	
			//This is how you make specialist languages available to specific classes only		
			if(iRow == LNG_KALEM || iRow == LNG_NITRIAD)
			{
				if(	GetLevelByClass(CLASS_TYPE_ROGUE, oPC) > 0  || GetLevelByClass(CLASS_TYPE_BARD, oPC) > 0  ||	GetLevelByClass(CLASS_TYPE_ASSASSIN, oPC) > 0 ||	GetLevelByClass(CLASS_TYPE_HARPER, oPC) > 0 ||	GetLevelByClass(CLASS_TYPE_SHADOWTHIEFOFAMN, oPC) > 0  ||	GetLevelByClass(CLASS_TYPE_SHADOWDANCER, oPC) > 0 )	
				{
					if(!GetHasFeat(StringToInt(Get2DAString(LANG_DAS_2DA, LANG_COL_FT, iRow)), oPC) )
					{
						iShowRow = LANG_ARRAY_SELECTED_FALSE;
					}
				}
			}
				
			if(iShowRow == LANG_ARRAY_SELECTED_UNAVAIL)	
			{
			
			}
			else
			{	
				sTexts_A = LISTBOX_AVAILABLE_TEXT + GetStringByStrRef(iLanguage_Name_strRef);     //(StringToInt(Get2DAString(LANG_DAS_2DA,LANG_COL_NAME,iRow)));
				sTextures_A = LISTBOX_AVAILABLE_ICON + GetLanguageIconResRef(iLanguage_EffectIcon); //StringToInt(Get2DAString(LANG_DAS_2DA,LANG_COL_SFX,iRow))); 
		
				sTexts_S = LISTBOX_SELECTED_TEXT + GetStringByStrRef(iLanguage_Name_strRef);     //+ GetStringByStrRef(StringToInt(Get2DAString(LANG_DAS_2DA,LANG_COL_NAME,iRow)));
				sTextures_S = LISTBOX_SELECTED_ICON + GetLanguageIconResRef(iLanguage_EffectIcon); //+ GetLanguageIconResRef(StringToInt(Get2DAString(LANG_DAS_2DA,LANG_COL_SFX,iRow))); 
		
				///
				sVariable2 = "2=" + IntToString(iRow);
				sVariable3 = "3=" +  IntToString(iLanguage_FeatID);
				
				if(iShowRow == LANG_ARRAY_SELECTED_FALSE)
				{
					sVariable1 = "1=" + IntToString(LANG_ARRAY_SELECTED_FALSE);
					sVariables = sVariable1+";"+sVariable2+";"+sVariable3;	
					AddListBoxRow(oPC, LNG_GUINAME , LISTBOX_AVAILABLE, "Entry_A" + IntToString(iRow), sTexts_A, sTextures_A, sVariables, ""); 
				}
		
				if(iShowRow == LANG_ARRAY_SELECTED_TRUE)
				{
					sVariable1 = "1=" + IntToString(LANG_ARRAY_SELECTED_TRUE);
					sVariables = sVariable1+";"+sVariable2+";"+sVariable3;
					AddListBoxRow(oPC, LNG_GUINAME , LISTBOX_SELECTED, "Entry_S" + IntToString(iRow), sTexts_S, sTextures_S, sVariables, ""); 
				}
			}		
		}
	}
}



void Build_LanguageTable_For_GUI(object oPC)
{
	//SendMessageToPC(oPC, CLR_PC_CHAT_MESSAGE+"Build_LanguageTable_For_GUI");
	string sLng_2DA_Row;
	string sLng_FeatArray_Identifier;
	string sLng_Selected_Identifier;
	string sLng_Name_Identifier;
	string sLng_Descript_Identifier;
	string sLng_EffectIcon;
	
	//11/11/12
	string sLng_SpellID_Identifier;	

		
	string sLanguage_FeatID;
	string sLanguage_Name;
	string sLanguage_Descript;
	string sLanguage_EffectIcon;
	//11/11/12
	string sLanguage_SpellID;		
			
	int iLanguage_2DARow = 1; //row 0 in Das_Lang.2DA is empty so start at 1
	int iLanguage_NoLngs = 0; 
	int iLanguage_FeatID;
	int iLanguage_Name_strRef;
	int iLanguage_Descript_strRef;
	int iLanguage_EffectIcon;
	int iLanguage_Available;
	
	//11/11/12
	int iLanguage_SpellID;	
			
	sLanguage_FeatID = Get2DAString(LANG_DAS_2DA, LANG_COL_FT, iLanguage_2DARow);

		while (sLanguage_FeatID!="")
		{
			
			sLng_2DA_Row = LANG_ARRAY_2DA_ROW + IntToString(iLanguage_2DARow);
			sLng_FeatArray_Identifier = LANG_ARRAY_FEATID + IntToString(iLanguage_2DARow);
			sLng_Selected_Identifier = LANG_ARRAY_SELECTED + IntToString(iLanguage_2DARow);
			sLng_Name_Identifier = LANG_ARRAY_NAME + IntToString(iLanguage_2DARow);
			sLng_Descript_Identifier = LANG_ARRAY_DESCRIPT + IntToString(iLanguage_2DARow);
			sLng_EffectIcon = LANG_ARRAY_EFFECTICON + IntToString(iLanguage_2DARow);
			//11/11/12
			sLng_SpellID_Identifier = LANG_ARRAY_SPELLID + IntToString(iLanguage_2DARow);
			//SendMessageToPC(oPC, CLR_PC_CHAT_MESSAGE+"sLanguage_SpellID #"+sLanguage_SpellID+"#");			
			sLanguage_Name = Get2DAString(LANG_DAS_2DA, LANG_COL_NAME, iLanguage_2DARow);
			sLanguage_Descript = Get2DAString(LANG_DAS_2DA, LANG_COL_DESCRIPT, iLanguage_2DARow);						
			sLanguage_EffectIcon = Get2DAString(LANG_DAS_2DA, LANG_COL_SFX, iLanguage_2DARow);
			//11/11/12			
			sLanguage_SpellID = Get2DAString(LANG_DAS_2DA, LANG_COL_SID, iLanguage_2DARow);
			//SendMessageToPC(oPC, CLR_PC_CHAT_MESSAGE+"sLanguage_SpellID #"+sLanguage_SpellID+"#");			
			iLanguage_FeatID = StringToInt(sLanguage_FeatID);
			iLanguage_Name_strRef = StringToInt(sLanguage_Name);
			iLanguage_Descript_strRef = StringToInt(sLanguage_Descript);
			iLanguage_EffectIcon = StringToInt(sLanguage_EffectIcon);
			//11/11/12				
			iLanguage_SpellID = StringToInt(sLanguage_SpellID);
			
			SetLocalInt(oPC , sLng_2DA_Row , iLanguage_2DARow );
			SetLocalInt(oPC , sLng_FeatArray_Identifier , iLanguage_FeatID );
			SetLocalInt(oPC , sLng_Name_Identifier , iLanguage_Name_strRef );			
			SetLocalInt(oPC , sLng_Descript_Identifier , iLanguage_Descript_strRef );
			SetLocalInt(oPC , sLng_EffectIcon , iLanguage_EffectIcon );
			//11/11/12
			SetLocalInt(oPC , sLng_SpellID_Identifier , iLanguage_SpellID );			
			
			iLanguage_Available = StringToInt(Get2DAString(LANG_DAS_2DA, LANG_COL_AVL, iLanguage_2DARow));

			if(iLanguage_Available)
			{
				if(GetHasFeat(iLanguage_FeatID, oPC, TRUE))
				{
					SetLocalInt(oPC , sLng_Selected_Identifier , LANG_ARRAY_SELECTED_KNOWN );
				}
				else{
					SetLocalInt(oPC , sLng_Selected_Identifier , LANG_ARRAY_SELECTED_FALSE );
				}
			}
			else
			{
				//added 11/11/12 - to allow for gui_setlanguage_mode			
				if(GetHasFeat(iLanguage_FeatID, oPC, TRUE))
				{
					SetLocalInt(oPC , sLng_Selected_Identifier , LANG_ARRAY_SELECTED_KNOWN );
				}
				else{
			
				SetLocalInt(oPC , sLng_Selected_Identifier , LANG_ARRAY_SELECTED_UNAVAIL );
				}
			}
			iLanguage_2DARow = iLanguage_2DARow + 1;
			//SendMessageToPC(oPC, "iLanguage_2DARow" +IntToString(iLanguage_2DARow));			
			sLanguage_FeatID = Get2DAString(LANG_DAS_2DA, LANG_COL_FT, iLanguage_2DARow);			
		}
		//row 0 in Das_Lang.2DA is empty of value, so now we store the total number of coloumns in the 2DS in LANG_ARRAY_FEATID0, 
		//so we don't need to recount them when using this data
		SetLocalInt(oPC , LANG_ARRAY_FEATID0 , iLanguage_2DARow - 1); 
}

void AddSelectLanguageFeatToPC(object oPC, int Das_Lang_2DARow)
{

	int iFeatIDToAdd = StringToInt(Get2DAString(LANG_DAS_2DA, LANG_COL_FT, Das_Lang_2DARow));
	string sLanguageFeatAdded = GetStringByStrRef( StringToInt(Get2DAString(LANG_DAS_2DA, LANG_COL_NAME, Das_Lang_2DARow)));
	
		if(!GetHasFeat(iFeatIDToAdd , oPC, TRUE))
		{
			FeatAdd(oPC, iFeatIDToAdd, FALSE);
			SendMessageToPC(oPC, CLR_PC_CHAT_MESSAGE + "Language Feat <i>speak " + sLanguageFeatAdded + "</i> added to " + GetName(oPC) );
		}
}	



void AddSelectedLanguages(object oPC)
{
	int iRow;
	int iMaxRows;

	int iLanguage_Selected;
	int iLng_2DA_Row;
	
	string sLng_Selected_Identifier;
	string sLng_2DA_Row;
		
	iMaxRows = GetLocalInt(oPC, LANG_ARRAY_FEATID0 );
		
	//Loop over each stored language entry on the PC
	for(iRow=1;iRow < iMaxRows; iRow++)
	{
		sLng_Selected_Identifier = LANG_ARRAY_SELECTED + IntToString(iRow);
		sLng_2DA_Row = LANG_ARRAY_2DA_ROW + IntToString(iRow);
		
		iLanguage_Selected = GetLocalInt(oPC, sLng_Selected_Identifier);	
		iLng_2DA_Row = GetLocalInt(oPC, sLng_2DA_Row);

		if(iLanguage_Selected == LANG_ARRAY_SELECTED_TRUE )
		{
			AddSelectLanguageFeatToPC( oPC, iLng_2DA_Row);
		}
	}
}

void AddHumanHeritageLanguages(object oPC)
{
	
	if(GetHasFeat(HIST_HUM_DASARIAN, oPC)) 
	{
		AddSelectLanguageFeatToPC(oPC, LNG_COMMON_D );
	}
	if(GetHasFeat(HIST_HUM_OLDV, oPC)) 
	{
		AddSelectLanguageFeatToPC(oPC, LNG_COMMON_D );
	}		
	if(GetHasFeat(HIST_HUM_NEWV, oPC))
	{
		AddSelectLanguageFeatToPC(oPC, LNG_COMMON_D );
	}		 
	if(GetHasFeat(HIST_HUM_DARS, oPC)) 
	{
		AddSelectLanguageFeatToPC(oPC, LNG_COMMON_D );
		AddSelectLanguageFeatToPC(oPC, LNG_DARISH );			
	}		
	if(GetHasFeat(HIST_HUM_DUSERIC, oPC))
	{
		AddSelectLanguageFeatToPC(oPC, LNG_COMMON_D );
	}	
	if(GetHasFeat(HIST_HUM_REL, oPC)) 
	{
		AddSelectLanguageFeatToPC(oPC, LNG_COMMON_D );
		AddSelectLanguageFeatToPC(oPC, LNG_RELLIAN );			
	}		
	if(GetHasFeat(HIST_HUM_IRYROD, oPC))
	{
		AddSelectLanguageFeatToPC(oPC, LNG_COMMON_D );
	}		 
	if(GetHasFeat(HIST_HUM_CUHANNA, oPC))
	{
		AddSelectLanguageFeatToPC(oPC, LNG_CUHANNAN );
	}		 
	if(GetHasFeat(HIST_HUM_TAHNAI, oPC)) 
	{
		AddSelectLanguageFeatToPC(oPC, LNG_TAHNAI );
	}		
	if(GetHasFeat(HIST_HUM_NULL, oPC))
	{
		AddSelectLanguageFeatToPC(oPC, LNG_COMMON_D );
	}				

}