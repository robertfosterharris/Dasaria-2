//2/9/12 RW Changed channel used for translations to CHAT_MODE_TELL
//9/9/12 RW working on oSender == oTarget code to reemove player echos
//20/11/12 RW added code to support select language gui fired from mode gui

#include "ginc_chat_const"
#include "ginc_chat_lang"
#include "ginc_gui_d2_languages"
#include "dmfi_inc_english"
#include "j4acs_uglyhack"
#include "std_quest_i0"

// ************************** COMMON CHAT DECLARATIONS *************************************

//Purpose: Used for checking for StoryDM status
int GetIsStoryDM(object oSender);

//Purpose: Staff DM check with check for possession of NPCs
int GetIsStaffDM(object oSender);

//Purpose: Sends a color coded message to Staff and Story DMs
void sInform_All_DMs(object oSender, object oTarget, string sMessage); //check this one actually works...

//Purpose: Checkes for a boolean value to detirmine whether to send debugging messages
//Set on OSender via !debug
void sChatSystemFeedback(int iSendFeedback, object oDM, string sMessage);

//Purpose: Sends a color coded message to oSender DMs (basically SendMessage with built in formating)
void sInform_oSenderDM(object oDM, string sMessage);

//Purpose: What is a players default language - DMs always default to Common
int GetDefaultLanguage(object oJournal, object oPC);

//Purpose: does PC know a language - DMs always know a language
int GetLanguageKnown(object oTarget, int iLanguageNowSpokenFeatID);

//Purpose: Set PC to use their default language
void SetToDefaultLanguage(object oSender, int iLanguageNowSpokenSID, int iDefaultLanguage) ;

//Purpose: Update the language effect icon (displays in the active spells icons)
void UpdateLanguageEffect(object oSender, int iLanguageNowSpokenSID, int iLanguageToSpeakSID, int iLanguageSpellEffectRow, int iNoLngSelected = FALSE );

// ************************** /COMMON CHAT DECLARATIONS *************************************


// ************************** COMMON  CHAT FUNCTIONS *****************************************

int GetIsStoryDM(object oSender)
{
	object oJournal = std_journal_get(oSender);
	int iStoryDM = FALSE;

	if( GetLocalInt(oJournal, STORY_DM) == TRUE && !GetIsDM(oSender)) {iStoryDM = TRUE;}
	
	return iStoryDM;
	
//	DoSweep(oSender);
}


int GetIsStaffDM(object oSender)
{

	int iStaffDM = FALSE;
	
	if ((GetIsStaff(oSender) && GetIsDM(oSender))||( GetIsStaff(oSender) && GetIsDMPossessed(oSender)) ) {iStaffDM=TRUE;}
	
	return iStaffDM;
}



void sInform_All_DMs(object oSender, object oTarget, string sMessage)
{
 	object oDMTarget;
	sMessage = CLR_DM + sMessage + CLR_END;
	//Normal DMs first
	SendChatMessage(oSender ,oTarget, CHAT_MODE_SILENT_SHOUT ,sMessage);
	//Now StoryDMs
	oDMTarget = GetFirstPC();
	while(oDMTarget != OBJECT_INVALID)
	{
		if(GetIsStoryDM(oDMTarget))
		{
			SendChatMessage(oSender,oDMTarget,CHAT_MODE_SERVER, sMessage);
		}
		oDMTarget = GetNextPC();
	}
}

void sInform_oSenderDM(object oDM, string sMessage)
{
	sMessage = CLR_DM + sMessage + CLR_END;
	SendChatMessage(OBJECT_INVALID ,oDM, CHAT_MODE_SERVER ,sMessage);
}

void sChatSystemFeedback(int iSendFeedback, object oDM, string sMessage)
{
	if(iSendFeedback)
	{
		sInform_oSenderDM(oDM, sMessage);
	}
}


int GetDefaultLanguage(object oJournal, object oPC)
{


	int iDefaultLanguage = GetLocalInt(oJournal,LANG_DEFAULT);
	if(iDefaultLanguage == 0) //there isn't a value set
		{
		iDefaultLanguage = LNG_COMMON_D; //set it to common as a catch all, covers DMs as well
		
		
		//Humans
		
		if(GetHasFeat(HIST_HUM_DARS , oPC)== TRUE)
		{
			iDefaultLanguage = LNG_DARISH;
		}
		if(GetHasFeat(HIST_HUM_REL , oPC)== TRUE)
		{
			iDefaultLanguage = LNG_RELLIAN;
		}		
		if(GetHasFeat(HIST_HUM_CUHANNA , oPC)== TRUE)
		{
			iDefaultLanguage =  LNG_CUHANNAN;
		}
		if(GetHasFeat(HIST_HUM_TAHNAI , oPC)== TRUE)
		{
			iDefaultLanguage =  LNG_TAHNAI;
		}				
		
		if( GetSubRace(oPC) == RACIAL_SUBTYPE_DWARF_F )
		{
			iDefaultLanguage =  LNG_DWARF_MODERN;
		}
		if(GetSubRace(oPC) == RACIAL_SUBTYPE_ELF_I)
		{
			iDefaultLanguage =  LNG_ELF_IRYROD;
		}		
		if(GetSubRace(oPC) == RACIAL_SUBTYPE_ELF_R)
		{
			iDefaultLanguage =  LNG_ELF_RIAN;
		}
		if(GetSubRace(oPC) == RACIAL_SUBTYPE_ELF_T)
		{
			iDefaultLanguage =  LNG_ELF_RIAN;
		}
		if(GetSubRace(oPC) == RACIAL_SUBTYPE_GNOME_D)
		{
			iDefaultLanguage =  LNG_GNOME_DUR;
		}
		if(GetSubRace(oPC) == RACIAL_SUBTYPE_HALFORC_K)
		{
			iDefaultLanguage =  LNG_KOR;
		}
		if(GetSubRace(oPC) == RACIAL_SUBTYPE_HALFORC_V)
		{
			iDefaultLanguage =  LNG_VOKK;
		}
		if(GetSubRace(oPC) == RACIAL_SUBTYPE_HALFORC_T)
		{
			iDefaultLanguage =  LNG_TAHNAI;
		}		
		
		
		SetLocalInt(oJournal, LANG_DEFAULT , iDefaultLanguage);
		}
	return iDefaultLanguage;
}

int GetLanguageKnown(object oTarget, int iLanguageNowSpokenFeatID)
{
	int iOutput = FALSE;
	
	if(GetHasFeat(iLanguageNowSpokenFeatID, oTarget, TRUE) || GetIsStoryDM(oTarget) || GetIsStaffDM(oTarget) )
	{ iOutput = TRUE;}
	
	return iOutput;
}

void SetToDefaultLanguage(object oSender, int iLanguageNowSpokenSID, int iDefaultLanguage) 
{
	int iNoLngSelected = FALSE;
	//string sLanguageName = Get2DAString(LANG_DAS_2DA, LANG_COL_LNG, iDefaultLanguage);
	int iLanguageFeatInUse = StringToInt(Get2DAString(LANG_DAS_2DA, LANG_COL_FT, iDefaultLanguage));
	int iLanguageToSpeakSID  = StringToInt(Get2DAString(LANG_DAS_2DA, LANG_COL_SID, iDefaultLanguage));
	int iLanguageSpellEffectRow = StringToInt(Get2DAString(LANG_DAS_2DA, LANG_COL_SFX, iDefaultLanguage));
	int iLanguageToSpeak = StringToInt(Get2DAString(LANG_DAS_2DA, LANG_COL_NAME, iDefaultLanguage));
	int iLanguageVerbal = StringToInt(Get2DAString(LANG_DAS_2DA, LANG_COL_VERBAL, iDefaultLanguage));
		
	if (iLanguageNowSpokenSID == 0)iNoLngSelected = TRUE;
	
	SetLocalString(oSender,LANG_SPOKEN, GetStringByStrRef(iLanguageToSpeak) );
	SetLocalInt(oSender, LANG_SPOKEN_2DA_ROW, iDefaultLanguage);
	SetLocalInt(oSender,LANG_SPOKEN_FT,iLanguageFeatInUse);
	SetLocalInt(oSender,LANG_SPOKEN_SID,iLanguageToSpeakSID);
	SetLocalInt(oSender,LANG_SPOKEN_SFX,iLanguageSpellEffectRow);
	SetLocalInt(oSender,LANG_SPOKEN_VERBAL,iLanguageVerbal);
	
	UpdateLanguageEffect(oSender, iLanguageNowSpokenSID, iLanguageToSpeakSID, iLanguageSpellEffectRow, iNoLngSelected );
}


void UpdateLanguageEffect(object oSender, int iLanguageNowSpokenSID, int iLanguageToSpeakSID, int iLanguageSpellEffectRow, int iNoLngSelected = FALSE )
{
	effect eSpeakLanguage;

	if(!iNoLngSelected)
	{
		RemoveEffectsFromSpell(oSender, iLanguageNowSpokenSID);
	}
	
	eSpeakLanguage = EffectEffectIcon(iLanguageSpellEffectRow);
	eSpeakLanguage = SetEffectSpellId(eSpeakLanguage, iLanguageToSpeakSID);
	eSpeakLanguage = SupernaturalEffect(ExtraordinaryEffect(eSpeakLanguage));
	
	ApplyEffectToObject(DURATION_TYPE_PERMANENT, eSpeakLanguage, oSender);
}



// ************************** /CHAT FUNCTIONS ****************************************



// ************************** LNG DECLARATIONS *************************************

//Purpose: set iChannel_To_use;
int iSetShoutChannel(int nChannel, int iIsStaffDM, int iIsStoryDM );

//Purpose: Used for returning the ranges to use with chat scripts
float fGetTalkRange(int nChannel);

//Purpose: Wrapper for general purpose error messages
void SendChatErrorMessage(object oSender, string sErrorMessage);

//Purpose: Prunes the leading ">>" ventiloquism characters from sMessage
//do it once... do it right
string sPruneVentriloSymbol(string sMessage);

//Purpose: Gets the local int LANG_SPOKEN_FT from oSender
//Used to quickly check if listeners can understand the speak
int iGetLanguageSpoken_Feat(object oSender);

//Purpose: Gets the local int LANG_SPOKEN_2DA_ROW from oSender
//This happens to be the the row of the language in LANG_DAS_2DA
//useful if we need to plumb the 2DA.
//This local int is also used  to create the "foreign languages" see ConvertLanguage()  
int iGetLanguageSpoken_Int(object oSender);

//Purpose: Checks speaker to see if they have been silenced. We look for EFFECT_TYPE_SILENCE to cover any new silence type spells
int CheckForSilence(object oSpeaker, int iLanguageVerbal, int iIsStaffDM=FALSE, int iIsStoryDM=FALSE );

//Purpose: sets the text colour of the  different langauages
string SetLanguageFontPrefix(object oSender, int iLanguageNowSpoken, int nChannel, string sLNG_PC_FontStart="null" );

//Purpose: Closes off the text colours for the various languages
string SetLanguageFontSuffix(string sPCFontStart );

//Purpose: Does a best effort to correct any "*" inbalances
//Carves up sMessage into Chat & Emote chunks this is used for chat obfuscation and playing emotes
string sBalanceEmotes(object oSender, string sMessage, string sEmoteSymbol_Start=CHAT_EMOTE_SYMBOL, string sEmoteSymbol_End=CHAT_EMOTE_SYMBOL);

//Purpose: uses iLanguageNowSpoken to decide what sOutPut_LNG_xxx script to run
string sObfuscateChatString(object oSender, string sSubString, int nChannel, int iLanguageNowSpoken, string sLNG_PC_EmoteSymbolStart = "*", string sLNG_PC_EmoteSymbolEnd = "*");

//Purpose: Picks which char set to replace plain txt with for text obfuscation
string sTranslateCharacter(string sCurrentCharacter, string sMessage, int nChannel, int iPosition, string sDefaultCharacter ="null", string sDefaultCharacter_Y ="null", string sCheckForPrior1 ="null", string sSetBasedOnPrior1="null", string sSetBasedOnPrior1_Y="null", string sCheckForPrior2 ="null" , string sSetBasedOnPrior2="null", string sSetBasedOnPrior2_Y="null", string sSetBasedOn_I="null" , string sSetBasedOn_I_Y="null"   );

//Purpose: Recombines the Chat and Emote  substrings and adds any text formating required
string sGlueMessage(object oSender, object oVoiceThrowTarget, int iOutPutType, int iLanguageNowSpoken, int iPlainText, int nChannel = CHAT_MODE_TALK, string sPCFontStart ="null", string sPCFontEnd ="null", string sLNG_PC_EmoteSymbolStart = "*", string sLNG_PC_EmoteSymbolEnd = "*" );

//Purpose: Sends necessary chat messages for talk/whisper/shout
void SendLocalChatMessageFunction( object oSender, object oVoiceThrowTarget, object oTarget, int nChannel, int iChannel_To_Use,  int iLngSpoken, int iActiveChat_Module, float fMax_Channel_Range, int iSilenced=FALSE, string sPCFontStart ="", string sPCFontEnd ="", string sLNG_PC_EmoteSymbolStart = "*", string sLNG_PC_EmoteSymbolEnd = "*" );


//Purpose: Sends necessary chat messages for talk/whisper/shout
void SendLocalPartyMessageFunction( object oSender, object oVoiceThrowTarget, object oTarget, int nChannel, int iChannel_To_Use,  int iLngSpoken, int iActiveChat_Module, float fMax_Channel_Range, int iSilenced=FALSE, string sPCFontStart ="", string sPCFontEnd ="", string sLNG_PC_EmoteSymbolStart = "*", string sLNG_PC_EmoteSymbolEnd = "*" );

//purpose : sends OCC chat in local/whisper and shout to DMs if chat logging is on. Required as OCC is processed differently.
void SendOOCChatToDMs(object oSender, string sMessage, int nChannel, int iActiveChat_Module );

// ************************** /LNG DECLARATIONS *************************************

// ************************** LNG FUNCTIONS *****************************************


int iSetShoutChannel(int nChannel, int iIsStaffDM, int iIsStoryDM )
{
		int iChannel_To_use;
		
		if( iIsStaffDM || iIsStoryDM)
		{
			iChannel_To_use = nChannel;		
		}
		else
		{
			iChannel_To_use = CHAT_MODE_TALK;
		}
	return iChannel_To_use;
}	

float fGetTalkRange(int nChannel)
{
	float fTalkBoundary;
	
	switch(nChannel)
	{
		case  CHAT_MODE_TALK:
			fTalkBoundary = CHAT_RANGE_TALK; 
		break;
		case CHAT_MODE_SHOUT:
			fTalkBoundary = CHAT_RANGE_SHOUT; 	
		break;
		case CHAT_MODE_WHISPER:
			fTalkBoundary = CHAT_RANGE_WHISPER; 
		break;
		default:
			//for all other values of nChannel
			fTalkBoundary = 0.0;
		break;
	}
	return fTalkBoundary;
}


void SendChatErrorMessage(object oSender, string sErrorMessage)
{ 
	SendChatMessage(oSender, oSender, CHAT_MODE_SERVER, CLR_PC_CHAT_MESSAGE  + sErrorMessage + CLR_END );
}

string sPruneVentriloSymbol(string sMessage)
{//Purpose: snip off those peskhy >>'s before processing sMessage further and also remove any white space between >> and typed text
	sMessage = GetSubString(sMessage,2,GetStringLength(sMessage) - 2);
	sMessage = StringTrim(sMessage);
	return sMessage;
}

int iGetLanguageSpoken_Feat(object oSender)
{//Purpose: use to get the LANG_SPOKEN_FT value from oSender - this is used in the translate functions 
//to tell if listens can understand ther speaker
	int iLanguageFeatInUse = GetLocalInt(oSender, LANG_SPOKEN_FT);
	
	//now what if somehow LANG_SPOKEN_FT hasn't been set, hmmm?
	//stuff does happen...
	if(iLanguageFeatInUse == 0)
	{
		SendMessageToPC(oSender, CLR_PC_CHAT_MESSAGE + "Unexpected Value for the Language you are speaking - please report in the Dasaria 2 forums.");
		SendMessageToPC(oSender, CLR_PC_CHAT_MESSAGE + "Language set to Common.");
	    iLanguageFeatInUse = StringToInt(Get2DAString(LANG_DAS_2DA, LANG_COL_FT, LNG_COMMON_D));
	}
	return iLanguageFeatInUse;
}

int iGetLanguageSpoken_Int(object oSender)
{
	int iLanguageSpoken = GetLocalInt(oSender, LANG_SPOKEN_FT);
	
	//now what if somehow LANG_SPOKEN_FT hasn't been set, hmmm?
	//sounding happen...
	if(iLanguageSpoken == 0)
	{
		SendMessageToPC(oSender, CLR_PC_CHAT_MESSAGE + "Unexpected Value for the Language you are speaking - please report in the Dasaria 2 forums.");
		SendMessageToPC(oSender, CLR_PC_CHAT_MESSAGE + "Language set to Common.");
		iLanguageSpoken = LNG_COMMON_D;
	}
	return iLanguageSpoken;
	
}


int CheckForSilence(object oSpeaker, int iLanguageVerbal, int iIsStaffDM=FALSE, int iIsStoryDM=FALSE )
{
   	effect eEffect = GetFirstEffect(oSpeaker);
   	int iSilence = FALSE;
	int iSilenced = FALSE;
	int iType;

	if(!iIsStaffDM || !iIsStoryDM ) //You can't silence the DMs
	{
	
	   	while(GetIsEffectValid(eEffect))
	   	{
			iType = GetEffectType(eEffect);
		  	if(iType == EFFECT_TYPE_SILENCE){iSilence = TRUE;}
	      	eEffect = GetNextEffect(oSpeaker);
	   	}
	   	if( iSilence == TRUE && iLanguageVerbal == FALSE )
		{
			iSilenced = TRUE;
		}
	}	
	return iSilenced;
}



string sBalanceEmotes(object oSender, string sMessage, string sEmoteSymbol_Start=CHAT_EMOTE_SYMBOL, string sEmoteSymbol_End=CHAT_EMOTE_SYMBOL)
{
	int iPosition, iCounter, iBreak, iBreak2;
	int iCountEmotes, iCountChats;
	int iChatStart, iChatEnd, iEmoteStart, iEmoteEnd;
	string sOutPutMessage = sMessage;
	int iChatBreakPoint  = 5;
	
	//First Clean up from any previous conversations
			
	for(iCounter = 1;iCounter <= iChatBreakPoint ; iCounter++)
	{
		SetLocalString(oSender, EMOTE_SUBSTRING+IntToString(iCounter),"");
		SetLocalString(oSender, CHAT_SUBSTRING+IntToString(iCounter),"");							
	}
	
	SetLocalInt(oSender, CHAT_INDEX, 0);
	SetLocalInt(oSender, EMOTE_INDEX, 0);	

	//Now balance the emotes and carve them up and store them for use
	iPosition = 0;
	iCountEmotes = 0;
	iCountChats = 1;	
	iChatStart = 0;
	iChatEnd = 0;
	iEmoteStart = 0;
	iEmoteEnd = 0;
			
	iBreak = FALSE;
	iBreak2 = FALSE;	


	//iPosition = iEmoteStart;
		
	for(iCounter = 1;iCounter <= iChatBreakPoint ; iCounter++)
	{
	

		iEmoteStart = FindSubString(sMessage,sEmoteSymbol_Start,iChatStart);

		if(iEmoteStart != -1 && sEmoteSymbol_Start == CHAT_EMOTE_SYMBOL  )
		{
			iBreak2 = FALSE;
			iPosition = iEmoteStart;
			
			do
			{
				if(GetSubString(sMessage,iPosition,2) == "**")
				{
					iPosition = iPosition+2;
					iPosition = FindSubString(sMessage,sEmoteSymbol_Start,iPosition);
				}
				else
				{
					iBreak2 = TRUE;
				}
					
			}while (iBreak2 == FALSE);
			
			iEmoteStart = iPosition;				
		}	
			
		
		if(iEmoteStart == -1)
		//we seem to have run out of emotes - go to the end of the string
		{
			iChatEnd = GetStringLength(sMessage);
			SetLocalString(oSender, CHAT_SUBSTRING+IntToString(iCountChats), GetSubString(sMessage,iChatStart, (iChatEnd - iChatStart)));
			iCounter = 6; //break character
		}			
		else
		{
			iCountEmotes = iCountEmotes+1;
			iChatEnd = iEmoteStart;
			SetLocalString(oSender, CHAT_SUBSTRING+IntToString(iCountChats), GetSubString(sMessage,iChatStart, (iChatEnd - iChatStart)));
			iEmoteEnd = FindSubString(sMessage,sEmoteSymbol_End, ( iEmoteStart + 2 ));	//was +1		

			if(iEmoteEnd != -1 && sEmoteSymbol_End == CHAT_EMOTE_SYMBOL  )
			{
				iBreak2 = FALSE;
				iPosition = iEmoteEnd;
				do
				{
					if(GetSubString(sMessage,iPosition,2) == "**")
					{
						iPosition = iPosition+2;
						iPosition = FindSubString(sMessage,sEmoteSymbol_End,iPosition);	
					}
					else
					{
						iBreak2 = TRUE;
					}

				}while (iBreak2 == FALSE);
				iEmoteEnd = iPosition;					
			}				

			if(iEmoteEnd == -1)
			//we seem to have run out of _closing_ emotes - bugger
			{
			//better safe than sorry, add an emote marker to the end of the string 
			//note if sEmoteSymbol_start and _end are different this means if oSender missing the start symbol
			//then the text will not be unmonged!! Tough really...
				sOutPutMessage = sMessage + sEmoteSymbol_End;
				iEmoteEnd = GetStringLength(sOutPutMessage);

				SetLocalString(oSender, EMOTE_SUBSTRING+IntToString(iCountEmotes),  GetSubString(sOutPutMessage,iEmoteStart, (iEmoteEnd - (iEmoteStart-1)))  );	
				iCounter = 6; //break character
			}
			else
			{
				SetLocalString(oSender, EMOTE_SUBSTRING+IntToString(iCountEmotes),  GetSubString(sMessage,iEmoteStart, (iEmoteEnd - (iEmoteStart-1)))  );	
				if(iEmoteEnd+1 <= GetStringLength(sMessage))
				{
					iCountChats = iCountChats+1;
					iChatStart =  iEmoteEnd+1;
				}
				else
				{
					iCounter = 6; //break character
				}
			}
		}
	}

	SetLocalInt(oSender, EMOTE_INDEX,iCountEmotes);
	SetLocalInt(oSender, CHAT_INDEX,iCountChats );								
			
return sOutPutMessage;		

}


string sObfuscateChatString(object oSender, string sSubString, int nChannel, int iLanguageNowSpoken, string sLNG_PC_EmoteSymbolStart = "*", string sLNG_PC_EmoteSymbolEnd = "*")
{
	string sOutput = "";

	switch (iLanguageNowSpoken)
	{
		case 1: //LNG_COMMON_D 
			sOutput =  sOutPut_LNG_COMMON_D(sSubString, nChannel,  oSender);
			break;	
			
		case 2: //LNG_ELF_RIAN
			sOutput = sOutPut_LNG_ELF_RIAN(sSubString, nChannel, oSender);
			break;

		case 3: //LNG_ELF_IRYROD
			sOutput = sOutPut_LNG_ELF_IRYROD(sSubString, nChannel, oSender);
			break;

		case 4: //LNG_DWARF_MODERN
			sOutput = sOutPut_LNG_DWARF_MODERN(sSubString, nChannel, oSender);
			break;
			
		case 5: //LNG_DWARF_DUNK
			sOutput = sOutPut_LNG_DWARF_DUNK(sSubString, nChannel, oSender);
			break;

		case 6: //LNG_DWARF_ANCIENT
			sOutput = sOutPut_LNG_DWARF_ANCIENT(sSubString, nChannel, oSender);
			break;

		case 7: //LNG_RELLIAN
			sOutput = sOutPut_LNG_RELLIAN(sSubString, nChannel, oSender);
			break;

		case 8: //LNG_DARISH
			sOutput = sOutPut_LNG_DARISH(sSubString, nChannel, oSender);
			break;

		case 9: //LNG_CUHANNAN
			sOutput = sOutPut_LNG_CUHANNAN(sSubString, nChannel, oSender);
			break;

		case 10: //LNG_KAOLISK
			sOutput = sOutPut_LNG_KAOLISK(sSubString, nChannel, oSender);
			break;

		case 11: //LNG_EXODONIAN
			sOutput = sOutPut_LNG_EXODONIAN(sSubString, nChannel, oSender);
			break;

		case 12: //LNG_DAWN_TONGUE
			sOutput = sOutPut_LNG_DAWN_TONGUE(sSubString, nChannel, oSender);
			break;

		case 13: //LNG_FIENDISH
			sOutput = sOutPut_LNG_FIENDISH(sSubString, nChannel, oSender);
			break;

		case 14: //LNG_GNOME_DUR
			sOutput = sOutPut_LNG_GNOME_DUR(sSubString, nChannel, oSender);
			break;

		case 15: //LNG_KOR
			sOutput = sOutPut_LNG_KOR(sSubString, nChannel, oSender);
			break;

		case 16: //LNG_VOKK
			sOutput = sOutPut_LNG_VOKK(sSubString, nChannel, oSender);
			break;

		case 17: //LNG_SHAI
			sOutput = sOutPut_LNG_SHAI(sSubString, nChannel, oSender);
			break;

		case 18: //LNG_TAHNAI
			sOutput = sOutPut_LNG_TAHNAI(sSubString, nChannel, oSender);
			break;

		case 19: //LNG_GIANT_D
			sOutput = sOutPut_LNG_GIANT_D(sSubString, nChannel, oSender);
			break;

		case 20: //LNG_DRAGON_D
			sOutput = sOutPut_LNG_DRAGON_D(sSubString, nChannel, oSender);
			break;

		case 21: //LNG_GNOLL_D
			sOutput = sOutPut_LNG_GNOLL_D(sSubString, nChannel, oSender);
			break;

		case 22: //LNG_FAYE
			sOutput = sOutPut_LNG_FAYE(sSubString, nChannel, oSender);
			break;

		case 23: //LNG_GOBLIN_D
			sOutput = sOutPut_LNG_GOBLIN_D(sSubString, nChannel, oSender);
			break;

		case 24: //LNG_ANJIRAN
			sOutput = sOutPut_LNG_ANJIRAN(sSubString, nChannel, oSender);
			break;

		case 25: //LNG_KOBOLD_D:
			sOutput = sOutPut_LNG_KOBOLD_D(sSubString, nChannel, oSender);
			break;

		case 26: //LNG_JILYN:
			sOutput = sOutPut_LNG_JILYN(sSubString, nChannel, oSender);
			break;

		case 27: //LNG_TRAILSIGN:
			//sOutput = sOutPut_LNG_TRAILSIGN(sSubString, nChannel, oSender);string sLNG_PC_EmoteSymbolStart = "*", string sLNG_PC_EmoteSymbolEnd = "*"
			sOutput = sOutPut_LNG_TRAILSIGN( sSubString, nChannel, oSender, sLNG_PC_EmoteSymbolStart , sLNG_PC_EmoteSymbolEnd );
			break;

		case 28: //LNG_DRUID_D:
			sOutput = sOutPut_LNG_DRUID_D(sSubString, nChannel, oSender);
			break;

		case 29: //LNG_SCOUTSIGN:
			sOutput = sOutPut_LNG_SCOUTSIGN(sSubString, nChannel, oSender, sLNG_PC_EmoteSymbolStart , sLNG_PC_EmoteSymbolEnd );
			break;
			
		case 30: //LNG_KALEM:
			sOutput = sOutPut_LNG_KALEM(sSubString, nChannel, oSender, sLNG_PC_EmoteSymbolStart , sLNG_PC_EmoteSymbolEnd );
			break;
			
		case 31: //LNG_NITRIAD:
			sOutput = sOutPut_LNG_NITRIAD(sSubString, nChannel, oSender, sLNG_PC_EmoteSymbolStart , sLNG_PC_EmoteSymbolEnd );
			break;
			
		case 32: //LNG_BARAAN:
			sOutput = sOutPut_LNG_BARAAN(sSubString, nChannel, oSender);
			break;			
		
		default	: 
			SendChatErrorMessage(oSender, CHAT_OBFUSCATE_ERROR);
		break;	
	}	

	
return sOutput;				
}

/*
string sTest_ConvertChat(object oSender, int nChannel, int iLanguageNowSpoken)
{

	string sInPutString, sObfuscatedString;
	int iCounter;
	int iCountChats = GetLocalInt(oSender, CHAT_INDEX );

	for(iCounter = 1;iCounter<=iCountChats; iCounter++)
	{
		sInPutString = GetLocalString(oSender, CHAT_SUBSTRING+IntToString(iCounter));
		SendMessageToPC(oSender, "Main C "+IntToString(iCounter)+":"+GetLocalString(oSender, CHAT_SUBSTRING+IntToString(iCounter)));
		sObfuscatedString =  sObfuscateChatString( oSender,  sInPutString,  nChannel, iLanguageNowSpoken);	
		SendMessageToPC(oSender, "Main O "+IntToString(iCounter)+":"+ sObfuscatedString );				
	}
return sObfuscatedString;
}
*/

string sGlueMessage(object oSender, object oVoiceThrowTarget, int iOutPutType, int iLanguageNowSpoken, int iPlainText, int nChannel = CHAT_MODE_TALK, string sPCFontStart ="null", string sPCFontEnd ="null", string sLNG_PC_EmoteSymbolStart = "*", string sLNG_PC_EmoteSymbolEnd = "*" )
{
	string sOutputMessage = "";
	string sEmoteStartSymbol, sEmoteEndSymbol, sChatPrefix, sChatSuffix ;
	string oSpeakerName = GetName(oVoiceThrowTarget);
	string 	sLanguageName; 
	int iCounter;
	int iCountChats = GetLocalInt(oSender, CHAT_INDEX );
	int	iCountEmotes = GetLocalInt(oSender, EMOTE_INDEX );
	string sChat, sEmote;
	int iUpperBound = (iCountChats > iCountEmotes) ? iCountChats : iCountEmotes ;

	
	sChatPrefix = SetLanguageFontPrefix(oSender, iLanguageNowSpoken, nChannel, sPCFontStart );
	sChatSuffix =  SetLanguageFontSuffix(sChatPrefix);

	if( iLanguageNowSpoken == LNG_COMMON_D )
	{
		sLanguageName = " ";
	}
	else
	{
		sLanguageName =	GetLocalString(oSender,LANG_SPOKEN);

		switch(nChannel)
		{
			case CHAT_MODE_TALK:
				sLanguageName =	 CLR_TALK + CHAT_LNG_TALK_ID + GetLocalString(oSender,LANG_SPOKEN) + CHAT_CLOSEBRACKET + CLR_END;
			break;
			case CHAT_MODE_SHOUT: 
				sLanguageName =	CLR_SHOUT + CHAT_LNG_SHOUT_ID + GetLocalString(oSender,LANG_SPOKEN)+ CHAT_CLOSEBRACKET + CLR_END;
			break;
		 	case CHAT_MODE_WHISPER:
				sLanguageName =	CLR_WHISPER + CHAT_LNG_WHISPER_ID + GetLocalString(oSender,LANG_SPOKEN) + CHAT_CLOSEBRACKET + CLR_END;
			break;
			default:
				sLanguageName =	 CLR_TALK + CHAT_LNG_TALK_ID + GetLocalString(oSender,LANG_SPOKEN) + CHAT_CLOSEBRACKET + CLR_END;
			break;
		}
	}
	
	//Do the Verbal / Non Verbal section here
	if(GetLocalInt(oSender, LANG_SPOKEN_VERBAL) == 1 && iPlainText == FALSE)
	{
		sOutputMessage = CLR_EMOTE + sObfuscateChatString( oSender,  GetLocalString(oSender, CHAT_SUBSTRING+IntToString(1)), nChannel, iLanguageNowSpoken, sLNG_PC_EmoteSymbolStart , sLNG_PC_EmoteSymbolEnd  ) + CLR_END ;
	}
	else
	{
	
		for(iCounter=1;iCounter<=iUpperBound;iCounter++)
		{
			sEmote = CLR_SPACE + CLR_EMOTE + GetLocalString(oSender, EMOTE_SUBSTRING+IntToString(iCounter))+ CLR_SPACE + CLR_END;
			if( iOutPutType == CHAT_OUTPUT_EMOTES_ONLY)
			{
				if(sChat != "") {sChat = " ... ";}
			}
			else
			{
				if(iPlainText == TRUE)
				{
					iLanguageNowSpoken = LNG_COMMON_D;
				}
				sChat =  sChatPrefix + sObfuscateChatString( oSender,  GetLocalString(oSender, CHAT_SUBSTRING+IntToString(iCounter)), nChannel, iLanguageNowSpoken ) + sChatSuffix ;
			}
		sOutputMessage = sOutputMessage + sChat + sEmote ;	
		}
	}	

	switch(iOutPutType)
	{
		case CHAT_OUTPUT_EMOTES_ONLY:
		
				sOutputMessage = sOutputMessage;//+ sChat + CLR_EMOTE+  sEmote +  CLR_END;
				
		break;
	
		case CHAT_OUTPUT_PLAIN_TXT:

			//For sending unobsurcated tex (but not common - common is just more obsfercated text!		
			sOutputMessage = sLanguageName + sOutputMessage;
			
		break;

		case CHAT_OUTPUT_PLAIN_TXT_WHISPER:
	
			sOutputMessage = sLanguageName + sOutputMessage;

		break;

		case CHAT_OUTPUT_PLAIN_TXT_YELL:

			sOutputMessage = sLanguageName + sOutputMessage;
			
		break;

		case CHAT_OUTPUT_OBSF_TXT:

				sOutputMessage = sOutputMessage;
					
		break;
		
		case CHAT_OUTPUT_OBSF_TXT_YELL:
	
			sOutputMessage = CLR_SHOUT + CHAT_SHOUT_ID + CLR_END + CLR_SPACE + sOutputMessage;
					
		break;
		
		case CHAT_OUTPUT_OBSF_TXT_YELL_R:

			sOutputMessage = CLR_SHOUT + CHAT_SHOUT_RANGE_ID + CLR_END + CLR_SPACE + sOutputMessage;
						
		break;													
	}
	return sOutputMessage;	
}	


void SendLocalChatMessageFunction( object oSender, object oVoiceThrowTarget, object oTarget, int nChannel, int iChannel_To_Use,  int iLngSpoken, int iActiveChat_Module, float fMax_Channel_Range,  int iSilenced=FALSE, string sPCFontStart ="", string sPCFontEnd ="", string sLNG_PC_EmoteSymbolStart = "*", string sLNG_PC_EmoteSymbolEnd = "*" )
{

	object oTarget;
	object oTargetArea;
	object  oSenderArea;
	
	string sSpeakerName = GetName(oVoiceThrowTarget);
	string sFinalCleanChatMessage;
	string sFinalObfuscatedChatMessage;	
	string sErrorMessage;
	int iDMActiveChat; 
	//, iCountDMActiveChat; 11/9/12 RW removed as we are not using Global var
	int iSpecialConditions = FALSE;
	int iActiveChatLoggingOn;
	
	int iDebug;
	
	float fDistanceToVoiceThrower;
	
	
	
	//replace this with a simple silence check
	if(iSilenced == TRUE )
	{
		
			sFinalObfuscatedChatMessage = sGlueMessage(oSender, oVoiceThrowTarget, CHAT_OUTPUT_EMOTES_ONLY, iLngSpoken, FALSE, nChannel, sPCFontStart, sPCFontEnd, sLNG_PC_EmoteSymbolStart , sLNG_PC_EmoteSymbolEnd  );
			SendChatMessage(oVoiceThrowTarget, oSender, nChannel , sFinalObfuscatedChatMessage );
			sErrorMessage =  sSpeakerName + CHAT_SILENCE_MESSAGE ;
			SendChatErrorMessage( oSender, sErrorMessage);				
	}
	//Speaker is not silenced... this is good
	else
	{
	//Send the clear text
	
		if(nChannel == CHAT_MODE_SHOUT )
		{
			sFinalObfuscatedChatMessage = sGlueMessage(oSender, oVoiceThrowTarget, CHAT_OUTPUT_OBSF_TXT_YELL, iLngSpoken, FALSE, nChannel, sPCFontStart, sPCFontEnd, sLNG_PC_EmoteSymbolStart , sLNG_PC_EmoteSymbolEnd  );
		}
		else //CHAT_OUTPUT_PLAIN_TXT  CHAT_OUTPUT_OBSF_TXT
		{
			sFinalObfuscatedChatMessage = sGlueMessage(oSender, oVoiceThrowTarget, CHAT_OUTPUT_OBSF_TXT, iLngSpoken, FALSE,  nChannel, sPCFontStart, sPCFontEnd, sLNG_PC_EmoteSymbolStart , sLNG_PC_EmoteSymbolEnd  );
		}

		SendChatMessage(oVoiceThrowTarget, oSender, iChannel_To_Use , sFinalObfuscatedChatMessage );

		if(iLngSpoken != LNG_COMMON_D || iActiveChat_Module == TRUE  || nChannel == CHAT_MODE_SHOUT || GetDistanceBetween(oSender, oVoiceThrowTarget) > fMax_Channel_Range )
		{
			//We certainly need a firstPC t start our loop
			oTarget = GetFirstPC(FALSE);
					
			//We may need to count the number of DMs with Active Chat Listening turned on
			//iCountDMActiveChat = 0;
			//We may need to know oSender/oVoiceThrowTarget's area
			oSenderArea = GetArea(oVoiceThrowTarget);
			
			//Lets just create sFinalCleanChatMessage once
			if(iLngSpoken != LNG_COMMON_D || nChannel == CHAT_MODE_SHOUT)
			{
				switch(nChannel)
				{
					case CHAT_MODE_TALK:
						sFinalCleanChatMessage = sGlueMessage(oSender, oVoiceThrowTarget, CHAT_OUTPUT_PLAIN_TXT, iLngSpoken, TRUE, nChannel, sPCFontStart, sPCFontEnd, sLNG_PC_EmoteSymbolStart , sLNG_PC_EmoteSymbolEnd  );
					break;
					
					case CHAT_MODE_SHOUT:
						sFinalCleanChatMessage = sGlueMessage(oSender, oVoiceThrowTarget, CHAT_OUTPUT_PLAIN_TXT_YELL, iLngSpoken, TRUE, nChannel, sPCFontStart, sPCFontEnd, sLNG_PC_EmoteSymbolStart , sLNG_PC_EmoteSymbolEnd  );
						sFinalObfuscatedChatMessage = sGlueMessage(oSender, oVoiceThrowTarget, CHAT_OUTPUT_OBSF_TXT_YELL_R, iLngSpoken, FALSE, nChannel, sPCFontStart, sPCFontEnd, sLNG_PC_EmoteSymbolStart , sLNG_PC_EmoteSymbolEnd  );
					break;
					
					case CHAT_MODE_WHISPER:
						sFinalCleanChatMessage = sGlueMessage(oSender, oVoiceThrowTarget, CHAT_OUTPUT_PLAIN_TXT_WHISPER, iLngSpoken, TRUE, nChannel, sPCFontStart, sPCFontEnd, sLNG_PC_EmoteSymbolStart , sLNG_PC_EmoteSymbolEnd  );
					break;
					
					default:
						SendChatErrorMessage( oSender, CHAT_INVALID_CHANNEL2);
					break;
				}
			}
			
			//Now lets cycle through the PCs
			
			while(GetIsObjectValid(oTarget) == TRUE)
			{
				oTargetArea = GetArea(oTarget);
				fDistanceToVoiceThrower = GetDistanceBetween(oTarget, oVoiceThrowTarget);
				
				if(iSpecialConditions == FALSE && GetIsStoryDM(oTarget) == TRUE && iActiveChat_Module == TRUE || iSpecialConditions == FALSE && GetIsStaffDM (oTarget) == TRUE && iActiveChat_Module == TRUE)
				{

					iDebug = GetLocalInt(oTarget, LANG_DEBUG);
					sChatSystemFeedback(iDebug, oTarget, "Debug On - special conditions loop - speaker = "+GetName(oSender)+"; oVoiceThrowTarget = "+GetName(oVoiceThrowTarget));
					
				
					iDMActiveChat = GetLocalInt(oTarget, ACTIVE_CHAT_DM);
					sChatSystemFeedback(iDebug, oTarget, "iDMActiveChat = "+IntToString(iDMActiveChat));

					
					if(	iDMActiveChat == TRUE && oTarget != oSender)
					{
					
						sChatSystemFeedback(iDebug, oTarget, "Condition: oDM Met");					
					
					
						if(oSenderArea != oTargetArea || ( oSenderArea == oTargetArea && fDistanceToVoiceThrower > fMax_Channel_Range))
						{
						
						
							SendChatMessage(OBJECT_INVALID, oTarget, CHAT_MODE_SERVER , CLR_SERVER + sSpeakerName + " : " + CLR_END + sFinalObfuscatedChatMessage );
							if(iLngSpoken != LNG_COMMON_D)
							{
							
								sChatSystemFeedback(iDebug, oTarget, "Condition: iLngSpoken != LNG_COMMON_D"); //9/9/12								
							
								SendChatMessage(OBJECT_INVALID, oTarget, CHAT_MODE_SERVER , sFinalCleanChatMessage );
							}
							
							iSpecialConditions = TRUE;						
						}
					}
				
				}				
				//oSender always hears their messages even if they are a player and out of range 
				if(iSpecialConditions == FALSE && oTarget == oSender && fDistanceToVoiceThrower > fMax_Channel_Range &&  oTargetArea == oSenderArea )
				{
				
					sChatSystemFeedback(iDebug, oTarget, "Condition: oVoiceThrowTarget == oSender Met");
					sChatSystemFeedback(iDebug, oTarget, "Condition: fDistanceToVoiceThrower = "+FloatToString(fDistanceToVoiceThrower)+" fMax_Channel_Range = "+FloatToString(fMax_Channel_Range) ); //9/9/12					
					
					SendChatMessage(OBJECT_INVALID, oTarget, CHAT_MODE_SERVER , CLR_SERVER + sSpeakerName + " : " + CLR_END + sFinalObfuscatedChatMessage );
					if(iLngSpoken != LNG_COMMON_D)
					{
					
						sChatSystemFeedback(iDebug, oTarget, "Condition: iLngSpoken != LNG_COMMON_D"); //9/9/12						
						SendChatMessage(OBJECT_INVALID, oTarget, CHAT_MODE_SERVER , sFinalCleanChatMessage );
					}
					
					iSpecialConditions = TRUE;
					
				}
				
				if(iSpecialConditions == FALSE && nChannel == CHAT_MODE_SHOUT)
				{

					sChatSystemFeedback(iDebug, oTarget, "Condition: CHAT_MODE_SHOUT Met");				
								
					if( GetIsStoryDM(oSender) || GetIsStaffDM(oSender) )
					{
						sChatSystemFeedback(iDebug, oTarget, "Condition: is a DM");					
						SendChatMessage(oSender , oTarget, CHAT_MODE_SHOUT , sFinalObfuscatedChatMessage );
						iSpecialConditions = TRUE;					
					}
					else
					{
						if( fDistanceToVoiceThrower > CHAT_RANGE_TALK && fDistanceToVoiceThrower <= CHAT_RANGE_SHOUT  &&  oTargetArea == oSenderArea )
						{
						
							SendChatMessage(OBJECT_INVALID, oTarget, CHAT_MODE_SERVER , sFinalObfuscatedChatMessage );
							iSpecialConditions = TRUE;
						}
					}
				
				}	
				if(iSpecialConditions == FALSE && iLngSpoken != LNG_COMMON_D  &&  oTargetArea == oSenderArea )
				{
					sChatSystemFeedback(iDebug, oTarget, "Condition: != LNG_COMMON Met");
					
					if( GetHasFeat( iGetLanguageSpoken_Feat(oSender), oTarget) && fDistanceToVoiceThrower <= fMax_Channel_Range || GetIsStoryDM(oTarget) && fDistanceToVoiceThrower <= fMax_Channel_Range || GetIsStaffDM (oTarget) && fDistanceToVoiceThrower <= fMax_Channel_Range )
					{
					
						sChatSystemFeedback(iDebug, oTarget, "Condition: oTarget has Feat. fDistanceToVoiceThrower = "+FloatToString(fDistanceToVoiceThrower)+" fMax_Channel_Range = "+FloatToString(fMax_Channel_Range) ); //9/9/12					
					
						SendChatMessage(OBJECT_INVALID, oTarget, CHAT_MODE_SERVER , sFinalCleanChatMessage );					
					}
					
					iSpecialConditions = TRUE;					
				}
				
			
			iSpecialConditions = FALSE;	
			oTarget = GetNextPC();

			}

		
		}

	}
	
}	
		
		
		
		
		
		
//		
// code for speak language type spells will go here...		
//




/*				
		if(iLngSpoken != LNG_COMMON_D || iActiveChat_Module == TRUE  || nChannel == CHAT_MODE_SHOUT || GetDistanceBetween(oSender, oVoiceThrowTarget) > fMax_Channel_Range )
		{
			//We certainly need a firstPC t start our loop
			oTarget = GetFirstPC(FALSE);

			//We may need to know oSender/oVoiceThrowTarget's area
			oSenderArea = GetArea(oVoiceThrowTarget);
			
			//Lets just create sFinalCleanChatMessage once
			if(iLngSpoken != LNG_COMMON_D || nChannel == CHAT_MODE_SHOUT)
			{
				switch(nChannel)
				{
					case CHAT_MODE_TALK:
						sFinalCleanChatMessage = sGlueMessage(oSender, oVoiceThrowTarget, CHAT_OUTPUT_PLAIN_TXT, iLngSpoken, TRUE, nChannel, sPCFontStart, sPCFontEnd, sLNG_PC_EmoteSymbolStart , sLNG_PC_EmoteSymbolEnd  );
					break;
					
					case CHAT_MODE_SHOUT:
						sFinalCleanChatMessage = sGlueMessage(oSender, oVoiceThrowTarget, CHAT_OUTPUT_PLAIN_TXT_YELL, iLngSpoken, TRUE, nChannel, sPCFontStart, sPCFontEnd, sLNG_PC_EmoteSymbolStart , sLNG_PC_EmoteSymbolEnd  );
						sFinalObfuscatedChatMessage = sGlueMessage(oSender, oVoiceThrowTarget, CHAT_OUTPUT_OBSF_TXT_YELL_R, iLngSpoken, FALSE, nChannel, sPCFontStart, sPCFontEnd, sLNG_PC_EmoteSymbolStart , sLNG_PC_EmoteSymbolEnd  );
					break;
					
					case CHAT_MODE_WHISPER:
						sFinalCleanChatMessage = sGlueMessage(oSender, oVoiceThrowTarget, CHAT_OUTPUT_PLAIN_TXT_WHISPER, iLngSpoken, TRUE, nChannel, sPCFontStart, sPCFontEnd, sLNG_PC_EmoteSymbolStart , sLNG_PC_EmoteSymbolEnd  );
					break;
					
					default:
						SendChatErrorMessage( oSender, CHAT_INVALID_CHANNEL2);
					break;
				}
			}
			
			//Now lets cycle through the PCs
			
			while(GetIsObjectValid(oTarget) == TRUE)
			{
				iDebug = GetLocalInt(oTarget, LANG_DEBUG);
				sChatSystemFeedback(iDebug, oTarget, "Debug On - special conditions loop - speaker = "+GetName(oSender)+"; oVoiceThrowTarget = "+GetName(oVoiceThrowTarget));
				oTargetArea = GetArea(oTarget);
				fDistanceToVoiceThrower = GetDistanceBetween(oTarget, oVoiceThrowTarget);

				if(iSpecialConditions == FALSE && oSender != oTarget && GetIsStoryDM(oTarget) == TRUE  || iSpecialConditions == FALSE && oSender != oTarget && GetIsStaffDM (oTarget) == TRUE )
				{
					sChatSystemFeedback(iDebug, oTarget, "Condition: oDM Met");
					iSpecialConditions = TRUE;
				
					iDMActiveChatOff = GetLocalInt(oTarget, ACTIVE_CHAT_DM);

					if(	iDMActiveChatOff == FALSE )					
					{
						if(oSenderArea != oTargetArea ||  oSenderArea == oTargetArea && fDistanceToVoiceThrower > fMax_Channel_Range )
						{
							SendChatMessage(oVoiceThrowTarget, oTarget, CHAT_MODE_TELL , sFinalObfuscatedChatMessage );
						}
						SendChatMessage(oVoiceThrowTarget, oTarget, CHAT_MODE_TELL , sFinalCleanChatMessage );								

					}
					if(iDMActiveChatOff == TRUE && iLngSpoken != LNG_COMMON_D && fDistanceToVoiceThrower <= fMax_Channel_Range )
					{
						SendChatMessage(oVoiceThrowTarget, oTarget, CHAT_MODE_TELL , sFinalCleanChatMessage );								
					}					
	
				}				
				//oSender always hears their messages even if they are a player and out of range 
				if(iSpecialConditions == FALSE && oTarget == oVoiceThrowTarget )
				{
					sChatSystemFeedback(iDebug, oTarget, "Condition: oVoiceThrowTarget == oSender Met");
					iSpecialConditions = TRUE;	
								
					if( oTargetArea == oSenderArea && fDistanceToVoiceThrower > fMax_Channel_Range  )
					{
						sChatSystemFeedback(iDebug, oTarget, "Condition: fDistanceToVoiceThrower = "+FloatToString(fDistanceToVoiceThrower)+" fMax_Channel_Range = "+FloatToString(fMax_Channel_Range) ); //9/9/12					
						SendChatMessage(oVoiceThrowTarget, oTarget, CHAT_MODE_TELL , sFinalObfuscatedChatMessage );
					}
					if(iLngSpoken != LNG_COMMON_D)
					{
						sChatSystemFeedback(iDebug, oTarget, "Condition: iLngSpoken != LNG_COMMON_D"); //9/9/12						
						SendChatMessage(oVoiceThrowTarget, oTarget, CHAT_MODE_TELL , sFinalCleanChatMessage );						
					}
							
				}
				
		
				
				
				if(iSpecialConditions == FALSE && nChannel == CHAT_MODE_SHOUT)
				{
					sChatSystemFeedback(iDebug, oTarget, "Condition: CHAT_MODE_SHOUT Met");
					iSpecialConditions = TRUE;
					
					if( GetIsStoryDM(oSender) || GetIsStaffDM(oSender) )
					{
						SendChatMessage(oSender , oTarget, CHAT_MODE_SHOUT , sFinalObfuscatedChatMessage );
										
					}
					else
					{
						if( fDistanceToVoiceThrower > CHAT_RANGE_TALK && fDistanceToVoiceThrower <= CHAT_RANGE_SHOUT  &&  oTargetArea == oSenderArea )
						{
		
							SendChatMessage(oVoiceThrowTarget, oTarget, CHAT_MODE_SERVER , sFinalObfuscatedChatMessage );
						}
					}
				
				}
					
//9/9/12				if(iSpecialConditions == FALSE && iLngSpoken != LNG_COMMON_D  &&  oTargetArea == oSenderArea )
				if(iSpecialConditions == FALSE && iLngSpoken != LNG_COMMON_D  &&  oVoiceThrowTarget != oTarget )				
				{
					sChatSystemFeedback(iDebug, oTarget, "Condition: != LNG_COMMON Met");				
					iSpecialConditions = TRUE;
//9/9/12					if( GetHasFeat( iGetLanguageSpoken_Feat(oSender), oTarget) && fDistanceToVoiceThrower <= fMax_Channel_Range )
					
					if( GetHasFeat( iGetLanguageSpoken_Feat(oSender), oTarget) &&  oTargetArea == oSenderArea && fDistanceToVoiceThrower <= fMax_Channel_Range )
					{
						SendChatMessage(oVoiceThrowTarget, oTarget, CHAT_MODE_TELL , sFinalCleanChatMessage );											
					}
					
				}
				
			
			iSpecialConditions = FALSE;	
			oTarget = GetNextPC();

			}

		
		}

	}
	
	
}	

*/

void SendPartyChatMessageFunction( object oSender, object oVoiceThrowTarget, object oTarget, int nChannel, int iLngSpoken, int iLNG_MOD_PartyChatOff, int iSilenced=FALSE, string sPCFontStart ="", string sPCFontEnd ="", string sLNG_PC_EmoteSymbolStart = "*", string sLNG_PC_EmoteSymbolEnd = "*" )
{

	object oTarget;
	object oPartyLeader;
	
	string sSpeakerName = GetName(oVoiceThrowTarget);
	string sFinalCleanChatMessage;
	string sFinalObfuscatedChatMessage;	
	string sErrorMessage;
	int iDMPartyChat;

	int iPartyChatLoggingOff;
	
	sFinalCleanChatMessage = sGlueMessage(oSender, oVoiceThrowTarget, CHAT_OUTPUT_PLAIN_TXT, iLngSpoken, TRUE, nChannel, sPCFontStart, sPCFontEnd, sLNG_PC_EmoteSymbolStart , sLNG_PC_EmoteSymbolEnd  );	
	sFinalObfuscatedChatMessage = sGlueMessage(oSender, oVoiceThrowTarget, CHAT_OUTPUT_OBSF_TXT, iLngSpoken, FALSE,  nChannel, sPCFontStart, sPCFontEnd, sLNG_PC_EmoteSymbolStart , sLNG_PC_EmoteSymbolEnd  );
	
	

	if(iLNG_MOD_PartyChatOff == 0)	
	{
			SendChatMessage(oSender, oTarget, CHAT_MODE_PARTY , sFinalObfuscatedChatMessage );
				
			if(iLngSpoken != LNG_COMMON_D)
			{				 
				oTarget = GetFirstFactionMember(oSender);
				
				while(GetIsObjectValid(oTarget))
				{
					if( GetHasFeat( iGetLanguageSpoken_Feat(oSender), oTarget)  || GetIsStoryDM(oTarget) || GetIsStaffDM (oTarget)  )
					{
							SendChatMessage(OBJECT_INVALID, oTarget, CHAT_MODE_SERVER , sFinalCleanChatMessage );					
//11/9/12					SendChatMessage(oVoiceThrowTarget, oTarget, CHAT_MODE_TELL , sFinalCleanChatMessage );					
						
					}					
					
					oTarget = GetNextFactionMember(oSender);
    			}				
						
			}
	}
	else
	{
		oTarget = GetFirstPC();
		oPartyLeader = GetFactionLeader(oSender);
				
		while(GetIsObjectValid(oTarget))
		{
			if( GetIsStoryDM(oTarget) || GetIsStaffDM (oTarget))
			{
				iDMPartyChat = GetLocalInt( oSender, SUPRESS_PARTY_CHAT_DM);
			
				if(iDMPartyChat)
				{
				SendChatMessage(OBJECT_INVALID, oTarget, CHAT_MODE_SERVER , sFinalObfuscatedChatMessage );
				SendChatMessage(OBJECT_INVALID, oTarget, CHAT_MODE_SERVER , sFinalCleanChatMessage );					

				iPartyChatLoggingOff = (iDMPartyChat) ? iPartyChatLoggingOff+1 : iPartyChatLoggingOff;
				}
			}
			
			if(oPartyLeader == GetFactionLeader(oTarget))
			{
				SendChatMessage(OBJECT_INVALID, oTarget, CHAT_MODE_SERVER , sFinalObfuscatedChatMessage );
				
				if( GetHasFeat( iGetLanguageSpoken_Feat(oSender), oTarget) )
				{
					SendChatMessage(OBJECT_INVALID, oTarget, CHAT_MODE_SERVER , sFinalCleanChatMessage );					
				}
			}
			oTarget = GetNextPC();
  		}				
	}
	
	if(iLNG_MOD_PartyChatOff && !iPartyChatLoggingOff )
	{
		SetLocalInt(GetModule(),MOD_LNG_SUPRESS_PARTY_CHAT, FALSE);
	}
}

void SendOOCChatToDMs(object oSender, string sMessage, int nChannel, int iActiveChat_Module )
{
	object oSenderArea;
	object oTargetArea;
	int iDMActiveChat;
	float fDistanceToSpeaker;
	object oTarget = GetFirstPC(FALSE);
	string sSpeakerName = GetName(oSender);				
	//We should count the number of DMs with Active Chat Listening turned on
//	int iCountDMActiveChat = 0;
	//We may need to know oSender/oVoiceThrowTarget's area
	oSenderArea = GetArea(oSender);
 		
	float fMax_Channel_Range = fGetTalkRange(nChannel);
	if(iActiveChat_Module == TRUE && nChannel == CHAT_MODE_TALK || iActiveChat_Module == TRUE && nChannel == CHAT_MODE_WHISPER || iActiveChat_Module == TRUE && nChannel == CHAT_MODE_SHOUT )
	{
		while(GetIsObjectValid(oTarget) == TRUE)	
		{
			oTargetArea = GetArea(oTarget);
			fDistanceToSpeaker = GetDistanceBetween(oTarget, oSender);
					
			if(GetIsStoryDM(oTarget) == TRUE && iActiveChat_Module == TRUE || GetIsStaffDM (oTarget) == TRUE && iActiveChat_Module == TRUE)
			{
				iDMActiveChat = GetLocalInt(oTarget, ACTIVE_CHAT_DM);
//				iCountDMActiveChat = (iDMActiveChat) ? iCountDMActiveChat+1 : iCountDMActiveChat;
						
				if(	iDMActiveChat == TRUE && oTarget != oSender)
//11/9/12		if(	iDMActiveChat == FALSE && oTarget != oSender)				
				{
					if(oSenderArea != oTargetArea || ( oSenderArea == oTargetArea && fDistanceToSpeaker > fMax_Channel_Range))
					{
						SendChatMessage(OBJECT_INVALID, oTarget, CHAT_MODE_SERVER , CLR_SERVER + sSpeakerName + " : " + CLR_END + sMessage );
					
//11/9/12				SendChatMessage(oSender, oTarget, CHAT_MODE_TELL , CLR_SERVER + sSpeakerName + " : " + CLR_END + CLR_OOC + sMessage + CLR_END );
					}
				}
					
			}	
			oTarget = GetNextPC();
		}
	}
	
/*	if(iActiveChat_Module == TRUE && !iDMActiveChat)
	{
	
		sInform_All_DMs(oSender, oTarget, "Deactivating Chat Monitoring - Chat executed by  " + GetName(oSender) );
		sInform_All_DMs(oSender, oTarget, "MOD_LNG_ACTIVE_CHAT = "+IntToString(iActiveChat_Module));	

		oTarget = GetFirstPC();
		while(oTarget != OBJECT_INVALID)
		{
			if(GetIsStoryDM(oTarget) || GetIsStaffDM(oTarget))
			{
				sInform_All_DMs(oSender, oTarget,  "ACTIVE_CHAT_DM "+GetName(oTarget)+" = "+IntToString(GetLocalInt(oTarget, ACTIVE_CHAT_DM)));		
			}
			oTarget = GetNextPC();
		}
	
		
	SetLocalInt(GetModule(),MOD_LNG_ACTIVE_CHAT, FALSE);	
	}	
*/
}

// *************************** /LNG FUNCTIONS *****************************************



// ************************** ADDING LNG Feats DECLARATIONS ****************************************
//
//These functions control the addition of Language feats, both for Vanilla Races and Dasaria2 custom races
//
// **************************************************************************************************


//Purpose: Add a Language Feat (Hertitage feat) to a PC using just the Das_Lang.2DA row number
void AddLanguageFeatToPC(object oPC, int Das_Lang_2DARow);

//Purpose: Adds Language Feats (Hertitage feats) to OLD_SKOOL PCs
//Uses LANGUAGE CONSTANTS (strings) from dmfi_inc_english & LANGUAGE CONSTANTS (int) from ginc_chat_const
//This only need to run once per PC!
void Add_LNG_Feats(object oPC);

//Purpose: Adds the language feat being used to oTarget (assuming oTarget is valid, ie a creature) 
//Used to allow players possessing NPCs to use languages while they are possessed...
//...though oSender will need to use ventriloquism on them first.
void AddLanguageFeatToNPC(object oSender, object oTarget, int iStaffDM, int iStoryDM, string sLanguageNowSpoken, int iFeatIDToAdd);

// ************************** /ADDING LNG Feats DECLARATIONS ***************************************


// ************************** FUNCTIONS for ADDING LNG Feats  ****************************************
//These functions control the addition of Language feats, both for Vanilla Races and Dasaria2 custom races


void AddLanguageFeatToPC(object oPC, int Das_Lang_2DARow)
{

	int iFeatIDToAdd = StringToInt(Get2DAString(LANG_DAS_2DA, LANG_COL_FT, Das_Lang_2DARow));
	string sLanguageFeatAdded = GetStringByStrRef( StringToInt(Get2DAString(LANG_DAS_2DA, LANG_COL_NAME, Das_Lang_2DARow)));
	
		if(!GetHasFeat(iFeatIDToAdd , oPC, TRUE))
		{
			FeatAdd(oPC, iFeatIDToAdd, FALSE);
			SendMessageToPC(oPC, CLR_PC_CHAT_MESSAGE + "Language Feat <i>speak " + sLanguageFeatAdded + "</i> added to " + GetName(oPC) );
		}
}		


void AddLanguageFeatToNPC(object oSender, object oTarget, int iStaffDM, int iStoryDM, string sLanguageNowSpoken, int iFeatIDToAdd)
{
	;
	if(GetObjectType(oTarget) == OBJECT_TYPE_CREATURE)
	{
		if(GetIsPlayerCharacter(oSender))
		{
			if (GetAssociate(ASSOCIATE_TYPE_FAMILIAR,oSender) == oTarget)  //familiars only
			{
				if(!GetHasFeat(iFeatIDToAdd , oTarget, TRUE))
				{
					FeatAdd(oTarget, iFeatIDToAdd, FALSE);
					SendMessageToPC(oSender, CLR_PC_CHAT_MESSAGE + "Language Feat <i>speak " + sLanguageNowSpoken + "</i> added to " + GetName(oTarget) );
				}
			}
		}
		else //DM, but not Story DMs as they can't possess NPCs
		{
			if(!GetIsPC(oTarget) && !GetIsPC(GetMaster(oTarget)))
			{
				if(!GetHasFeat(iFeatIDToAdd , oTarget, TRUE))
				{
					FeatAdd(oTarget, iFeatIDToAdd, FALSE);
					SendMessageToPC(oSender, CLR_PC_CHAT_MESSAGE + "Language Feat <i>speak " + sLanguageNowSpoken + "</i> added to " + GetName(oTarget) );
				}
			}	
		}
	}
}


void Add_LNG_Feats(object oPC)
{

    object oTool = DMFI_GetTool(oPC);
  	string sKnownLanguages = "DMFI_EXTRACT:";
    string sLang;
    int n;
	int nMax;

	nMax = GetLocalInt(oTool, DMFI_STRING_LANGUAGE + DMFI_STRING_MAX);
	
	if (nMax==0) 
	{
		AddLanguageFeatToPC(oPC, LNG_COMMON_D );
	}
	else
	{
	    for (n=0; n<nMax; n++)
		    {
		        sLang = DMFI_CapitalizeWord(GetLocalString(oTool, DMFI_STRING_LANGUAGE + IntToString(n)));
		        sKnownLanguages = sKnownLanguages + " " + sLang;
		    }

	sKnownLanguages = GetStringLowerCase(sKnownLanguages);

	if(	FindSubString(sKnownLanguages, LNG_COMMON)!= -1 ) 	{ AddLanguageFeatToPC(oPC, LNG_COMMON_D ); }	
//	if(	FindSubString(sKnownLanguages, LNG_ANIMAL)!= -1 ) 	{ AddLanguageFeatToPC(oPC, LNG_COMMON_D ); }
	if(	FindSubString(sKnownLanguages, LNG_ASSASSIN)!= -1 ) { AddLanguageFeatToPC(oPC, LNG_NITRIAD ); }
	if(	FindSubString(sKnownLanguages, LNG_ABYSSAL)!= -1 )	{ AddLanguageFeatToPC(oPC, LNG_FIENDISH );}
//	if(	FindSubString(sKnownLanguages, LNG_ALZHEDO)!= -1 ) AddLanguageFeatToPC(oPC, LNG_COMMON_D );
//	if(	FindSubString(sKnownLanguages, LNG_AQUAN)!= -1 ) AddLanguageFeatToPC(oPC, LNG_COMMON_D );
//	if(	FindSubString(sKnownLanguages, LNG_AURAN)!= -1 ) AddLanguageFeatToPC(oPC, LNG_COMMON_D );
//	if(	FindSubString(sKnownLanguages, LNG_ALGARONDAN)!= -1 ) AddLanguageFeatToPC(oPC, LNG_COMMON_D );
	if(	FindSubString(sKnownLanguages, LNG_CANT)!= -1 ) 	{ AddLanguageFeatToPC(oPC, LNG_KALEM );}
	if(	FindSubString(sKnownLanguages, LNG_CELESTIAL)!= -1 ){ AddLanguageFeatToPC(oPC, LNG_DAWN_TONGUE );}
//	if(	FindSubString(sKnownLanguages, LNG_CHESSENTAN)!= -1 ) AddLanguageFeatToPC(oPC, LNG_BEAST_D );
//	if(	FindSubString(sKnownLanguages, LNG_CHONDATHAN)!= -1 ) AddLanguageFeatToPC(oPC, LNG_COMMON_D );
//	if(	FindSubString(sKnownLanguages, LNG_CHULTAN)!= -1 ) AddLanguageFeatToPC(oPC, LNG_COMMON_D );
	if(	FindSubString(sKnownLanguages, LNG_DWARF)!= -1 ) 	{ AddLanguageFeatToPC(oPC, LNG_DWARF_MODERN );}
	if(	FindSubString(sKnownLanguages, LNG_DROW)!= -1 ) 	{ AddLanguageFeatToPC(oPC, LNG_ELF_RIAN );}
	if(	FindSubString(sKnownLanguages, LNG_DROWSIGN)!= -1 ) { AddLanguageFeatToPC(oPC, LNG_TRAILSIGN );}
	if(	FindSubString(sKnownLanguages, LNG_DRUIDIC)!= -1 )	{ AddLanguageFeatToPC(oPC, LNG_DRUID_D );}
	if(	FindSubString(sKnownLanguages, LNG_DRACONIC)!= -1 ) { AddLanguageFeatToPC(oPC, LNG_DRAGON_D );}
//	if(	FindSubString(sKnownLanguages, LNG_DAMARAN)!= -1 ) AddLanguageFeatToPC(oPC, LNG_COMMON_D );
//	if(	FindSubString(sKnownLanguages, LNG_DAMBRATHAN)!= -1 ) AddLanguageFeatToPC(oPC, LNG_COMMON_D );
	if(	FindSubString(sKnownLanguages, LNG_DURPARI)!= -1 ) AddLanguageFeatToPC(oPC, LNG_CUHANNAN );
	if(	FindSubString(sKnownLanguages, LNG_ELVEN)!= -1 ) AddLanguageFeatToPC(oPC, LNG_ELF_RIAN );
	if(	FindSubString(sKnownLanguages, LNG_GNOME)!= -1 ) AddLanguageFeatToPC(oPC, LNG_GNOME_DUR );
	if(	FindSubString(sKnownLanguages, LNG_GOBLIN)!= -1 ) AddLanguageFeatToPC(oPC, LNG_GOBLIN_D );
	if(	FindSubString(sKnownLanguages, LNG_GIANT)!= -1 ) AddLanguageFeatToPC(oPC, LNG_GIANT_D );
	if(	FindSubString(sKnownLanguages, LNG_GNOLL)!= -1 ) AddLanguageFeatToPC(oPC, LNG_GNOLL_D );
	if(	FindSubString(sKnownLanguages, LNG_HALFLING)!= -1 ) AddLanguageFeatToPC(oPC, LNG_COMMON_D );
//	if(	FindSubString(sKnownLanguages, LNG_HALARDRIM)!= -1 ) AddLanguageFeatToPC(oPC, LNG_COMMON_D );
//	if(	FindSubString(sKnownLanguages, LNG_HALRUAAN)!= -1 ) AddLanguageFeatToPC(oPC, LNG_COMMON_D );
//	if(	FindSubString(sKnownLanguages, LNG_ILLUSKAN)!= -1 ) AddLanguageFeatToPC(oPC, LNG_COMMON_D );
//	if(	FindSubString(sKnownLanguages, LNG_IMASKAR)!= -1 ) AddLanguageFeatToPC(oPC, LNG_COMMON_D );
	if(	FindSubString(sKnownLanguages, LNG_INFERNAL)!= -1 ) AddLanguageFeatToPC(oPC, LNG_FIENDISH );
	if(	FindSubString(sKnownLanguages, LNG_LEETSPEAK)!= -1 ) AddLanguageFeatToPC(oPC, LNG_COMMON_D );
//	if(	FindSubString(sKnownLanguages, LNG_LANTANESE)!= -1 ) AddLanguageFeatToPC(oPC, LNG_COMMON_D );
//	if(	FindSubString(sKnownLanguages, LNG_MIDANI)!= -1 ) AddLanguageFeatToPC(oPC, LNG_COMMON_D );
//	if(	FindSubString(sKnownLanguages, LNG_MULHORANDI)!= -1 ) AddLanguageFeatToPC(oPC, LNG_COMMON_D );
//	if(	FindSubString(sKnownLanguages, LNG_RASHEMI)!= -1 ) AddLanguageFeatToPC(oPC, LNG_COMMON_D );
//	if(	FindSubString(sKnownLanguages, LNG_RAUMVIRA)!= -1 ) AddLanguageFeatToPC(oPC, LNG_COMMON_D );
//	if(	FindSubString(sKnownLanguages, LNG_SERUSAN)!= -1 ) AddLanguageFeatToPC(oPC, LNG_COMMON_D );
//	if(	FindSubString(sKnownLanguages, LNG_SHAARAN)!= -1 ) AddLanguageFeatToPC(oPC, LNG_COMMON_D );
//	if(	FindSubString(sKnownLanguages, LNG_SHOU)!= -1 ) AddLanguageFeatToPC(oPC, LNG_COMMON_D );
	if(	FindSubString(sKnownLanguages, LNG_SYLVAN)!= -1 ) AddLanguageFeatToPC(oPC, LNG_FAYE );
//	if(	FindSubString(sKnownLanguages, LNG_TERRAN)!= -1 ) AddLanguageFeatToPC(oPC, LNG_COMMON_D );
	if(	FindSubString(sKnownLanguages, LNG_TREANT)!= -1 ) AddLanguageFeatToPC(oPC, LNG_DRUID_D );
//	if(	FindSubString(sKnownLanguages, LNG_TALFIRIC)!= -1 ) AddLanguageFeatToPC(oPC, LNG_COMMON_D );
//	if(	FindSubString(sKnownLanguages, LNG_TASHALAN)!= -1 ) AddLanguageFeatToPC(oPC, LNG_COMMON_D );
//	if(	FindSubString(sKnownLanguages, LNG_TUIGAN)!= -1 ) AddLanguageFeatToPC(oPC, LNG_COMMON_D );
//	if(	FindSubString(sKnownLanguages, LNG_TURMIC)!= -1 ) AddLanguageFeatToPC(oPC, LNG_COMMON_D );
	if(	FindSubString(sKnownLanguages, LNG_ORC)!= -1 ) AddLanguageFeatToPC(oPC, LNG_VOKK );
//	if(	FindSubString(sKnownLanguages, LNG_NEXALAN)!= -1 ) AddLanguageFeatToPC(oPC, LNG_COMMON_D );
	if(	FindSubString(sKnownLanguages, LNG_OILLUSK)!= -1 ) AddLanguageFeatToPC(oPC, LNG_GIANT_D	);
	if(	FindSubString(sKnownLanguages, LNG_UNDERCOMMON)!= -1 ) AddLanguageFeatToPC(oPC, LNG_COMMON_D );
//	if(	FindSubString(sKnownLanguages, LNG_ULUIK)!= -1 ) AddLanguageFeatToPC(oPC, LNG_COMMON_D );
//	if(	FindSubString(sKnownLanguages, LNG_UNTHERIC)!= -1 ) AddLanguageFeatToPC(oPC, LNG_COMMON_D );
//	if(	FindSubString(sKnownLanguages, LNG_VAASAN)!= -1 ) AddLanguageFeatToPC(oPC, LNG_COMMON_D );																							
	}
}

// ************************** /FUNCTIONS for ADDING LNG Feats  ****************************************






// ************************** COMMAND DECLARATIONS *************************************

//Purpose: enable server/dm listen. !quiet is depreciated, onchat now automatically handles deactivating if no DM is using
void CMD_activechat(object oSender, object oTarget, string sCmd_Word_Quantifier);

//Purpose: !addhench ###. Where ### is the NPC/critter tag to add to a PC as henchman (with target PC highlighted)
void CMD_addhench(object oSender, object oTarget, string sCmd_Word_Quantifier);

//Purpose: turns target AI off in area
void CMD_aioff(object oSender, object oTarget, string sCmd_Word_Quantifier);

//Purpose: turns target AI on in area
void CMD_aion(object oSender, object oTarget, string sCmd_Word_Quantifier);

//Purpose: asks for appearance code and apply to oTarget
void CMD_appear(object oSender, object oTarget, string sCmd_Word_Quantifier);

//Purpose: if you used !come, send them back to where they came from
void CMD_back(object oSender, object oTarget, string sCmd_Word_Quantifier);

//Purpose: Boots the targeted Player from the server
void CMD_boot(object oSender, object oTarget, string sCmd_Word_Quantifier);

//Purpose: sets oTarget  to faction "canite"
void CMD_canite(object oSender, object oTarget, string sCmd_Word_Quantifier);

//Purpose: gimmie player's cdkey
void CMD_cdkey(object oSender, object oTarget, string sCmd_Word_Quantifier);

//Purpose: like the rod of cleaning (may not work?)
//need to target something for this to work - OBJECT_SELF is good :)
void CMD_clean(object oSender, object oTarget, string sCmd_Word_Quantifier);

//Purpose: jump oTarget to oSender(DM)
void CMD_come(object oSender, object oTarget, string sCmd_Word_Quantifier);

//Purpose: sets oTarget to faction "commoner"
void CMD_commoner(object oSender, object oTarget, string sCmd_Word_Quantifier);

//Purpose: applies entered damaged to selected oTarget
void CMD_damage(object oSender, object oTarget, string sCmd_Word_Quantifier);

//Purpose: Toogles a local int for getting debugging statements in chat code, see sChatSystemFeedback();
void CMD_debug(object oSender, string sCmd_Word_Quantifier);

//Purpose: sets oTarget to faction "defender"
void CMD_defender(object oSender, object oTarget, string sCmd_Word_Quantifier);

//Purpose: Get player's descripion text
void CMD_desc(object oSender, object oTarget, string sCmd_Word_Quantifier);

//Purpose: allows you to change target's deity selection
void CMD_deity(object oSender, object oTarget, string sCmd_Word_Quantifier);

//Purpose: Destroy object - NPC or object
void CMD_destroy(object oSender, object oTarget, string sCmd_Word_Quantifier);

//Purpose: Jump DM to slected target
void CMD_dmgo(object oSender, object oTarget, string sCmd_Word_Quantifier);

//Purpose: Tag oTarget as EOS (Enemy of the State)
void CMD_eos(object oSender, object oTarget, string sCmd_Word_Quantifier);

//Purpose: Undo to pc !freeze
//Deprecated by new CMD_freeze
void CMD_free(object oSender, object oTarget, string sCmd_Word_Quantifier);

//Purpose: Pc is frozen (no need to pause the whole server)
void CMD_freeze(object oSender, object oTarget, string sCmd_Word_Quantifier);

//Purpose: returns tag of selected NPC/critter (for !addhench)
void CMD_gettag(object oSender, object oTarget, string sCmd_Word_Quantifier);

//Purpose: Gives feat ### to NPC/critter (### from 2da or google 'feat codes') (may invalidate PC!)
void CMD_givefeat(object oSender, object oTarget, string sCmd_Word_Quantifier);

//Purpose: heals oTarget
void CMD_heal(object oSender, object oTarget, string sCmd_Word_Quantifier);

//Purpose: list current available commands
void CMD_help(object oSender, string sCMD_ABCDE, string sCMD_FGHIJ, string sCMD_KLMNO , string sCMD_PQRST, string sCMD_UVWXYZ );

//Purpose: Allows oSender to select a heritage feat(if they are human)
void CMD_heritage( object oSender, object oTarget, string sCmd_Word_Quantifier );


//Purpose: sets oTarget  to faction "hostile"
void CMD_hostile(object oSender, object oTarget, string sCmd_Word_Quantifier);

//Purpose: sets oTarget  to faction "imperial"
void CMD_imperial(object oSender, object oTarget, string sCmd_Word_Quantifier);

//Purpose: sets DM avatar truly invisible (may be buggy when viewing inventories)
void CMD_invis(object oSender, object oTarget, string sCmd_Word_Quantifier);

//Purpose: issue warrant on oTarget and port them to jail
void CMD_jail(object oSender, object oTarget, string sCmd_Word_Quantifier);

//Purpose: kill oTarget - bwhahahaha
void CMD_kill(object oSender, object oTarget, string sCmd_Word_Quantifier);

//Purpose: examine (not sure if this works across zones but that was the idea - may need testing)
void CMD_look(object oSender, object oTarget, string sCmd_Word_Quantifier);

//Purpose: Sets a prefix to auto color / set style of chat text
void CMD_language( object oSender, object oTarget, string sCmd_Word_Quantifier );



//Purpose: (right-click object to modify after firing) allows you to modify features
void CMD_moditem(object oSender, object oTarget, string sCmd_Word_Quantifier);

//Purpose: asks for polymorph code
void CMD_morph(object oSender, object oTarget, string sCmd_Word_Quantifier);

//Purpose: sets the message of the day, this is a floatytext that displays 5 on login (100 char max)
void CMD_motd(object oSender, object oTarget, string sCmd_Word_Quantifier); 

//Purpose: sets oTarget  to faction "neutral"
void CMD_neutral(object oSender, object oTarget, string sCmd_Word_Quantifier);

//Purpose: removes EOS
void CMD_pardon(object oSender, object oTarget, string sCmd_Word_Quantifier);

//Purpose: Allows a DM to suppress partychat so they do not receive it
void CMD_partychat(object oSender, object oTarget, string sCmd_Word_Quantifier);

//Purpose: Jumps oTarget and all party members to the DM
void CMD_partyjump(object oSender, object oTarget, string sCmd_Word_Quantifier);

//Purpose: grant ### xp to entire party of selected target
void CMD_partyxp(object oSender, object oTarget, string sCmd_Word_Quantifier );

//Purpose: raise dead
void CMD_raise(object oSender, object oTarget, string sCmd_Word_Quantifier);

//Purpose: sets oTarget  to faction "rebel"
void CMD_rebel(object oSender, object oTarget, string sCmd_Word_Quantifier);

//Purpose: removes feat ### from NPC/critter (see ! CMD_givefeat)
void CMD_removefeat(object oSender, object oTarget, string sCmd_Word_Quantifier);

//Purpose: where ### is new player name
void CMD_rename(object oSender, object oTarget, string sCmd_Word_Quantifier); 

//Purpose: give player ### renown
void CMD_renown(object oSender, object oTarget, string sCmd_Word_Quantifier); 

//Purpose: forcerest the player (strips all non-supernatural effects as well)
void CMD_rest(object oSender, object oTarget, string sCmd_Word_Quantifier);

//Purpose: resurrect palyer(s)
void CMD_rez(object oSender, object oTarget, string sCmd_Word_Quantifier);

//Purpose: rez for whole area (deprecated)
void CMD_rezarea(object oSender, object oTarget, string sCmd_Word_Quantifier);

//Purpose: make a skill check
void CMD_skillroll(int iSkillUsed, object oSender, object oTarget, string sCmd_Word_Quantifier );

//Purpose: sets trap CR for detection to ###
void CMD_setdetect(object oSender, object oTarget, string sCmd_Word_Quantifier);

//Purpose:  sets trap CR for disarming to ###
void CMD_setdisarm(object oSender, object oTarget, string sCmd_Word_Quantifier);

void CMD_setskill( object oSender, object oTarget, string sCmd_Word_Quantifier );

//Purpose: sets unlock CR of target to ###
void CMD_setunlock(object oSender, object oTarget, string sCmd_Word_Quantifier); 

//Purpose: shrinks or restores PC to 1/2 size and speed
void CMD_shrink(object oSender, object oTarget, string sCmd_Word_Quantifier);

//Purpose: Opens a webpage - used with CMD_sendurl
void CSLOpenUrl( string sUrl, object oPlayer = OBJECT_SELF );

//Purpose: Send a popup box with ### hyperlink to player
void CMD_sendurl(object oSender, object oTarget, string sCmd_Word_Quantifier); 

//Purpose: Where ### is resref of creature to be spawned directly behind player
void CMD_spawn(object oSender, object oTarget, string sCmd_Word_Quantifier); 

//Purpose: Toggles area encounters on/off
void CMD_togencs(object oSender, object oTarget, string sCmd_Word_Quantifier);

void CMD_togOLM(object oSender, object oTarget, string sCmd_Word_Quantifier);

void CMD_unvis(object oSender, object oTarget, string sCmd_Word_Quantifier);

//Purpose: used with CMD_vars to list all the variables on an object
void ListVars( object oSender, object oTarget );

//Purpose: List all the variables on an object
void CMD_vars(object oSender, object oTarget, string sCmd_Word_Quantifier );

//Purpose: the hell is everyone?
void CMD_where(object oSender, object oTarget, string sCmd_Word_Quantifier);

//Purpose: grant ### xp to selected target
void CMD_xp(object oSender, object oTarget, string sCmd_Word_Quantifier ); 

//Purpose: Applies zombie effect to oTarget
void CMD_zombie(object oSender, object oTarget, string sCmd_Word_Quantifier);

//Purpose: Lists all feats on oTarget
void CMD_feats( object oSender, object oTarget, string sCmd_Word_Quantifier );

//Purpose: opens the Scry GUI
void CMD_scry( object oSender, object oTarget, string sCmd_Word_Quantifier );

//Purpose: What version of chat is running - use to debug
void CMD_version(object oSender, string sCmd_Word_Quantifier );

//Purpose: Manages !commands
void Dasaria2_Chat_Commands(object oSender, object oTarget, int nChannel, string sMessage, int iStaffDM = FALSE , int iStoryDM = FALSE, int iStaff = FALSE);

//Purpose: Completely remove the 'Dakhen Curse' from a PC
void CMD_Dakhen(object oTarget );

// ************************** /COMMAND DECLARATIONS *************************************


// ************************** COMMAND FUNCTIONS ****************************************

void Dasaria2_Chat_Commands(object oSender, object oTarget, int nChannel, string sMessage, int iStaffDM = FALSE , int iStoryDM = FALSE, int iStaff = FALSE)
{

	object oArea_Sender;
	object oArea_oTarget;
	location lSender;
	location lTarget;
	
	string sCmd_CheckChar;
	string sCmd_Char;
	string sCmd_Message;
	string sCmd_Word;
	string sCmd_Word_Quantifier;

	int iCmd_Switch;
	int iCmd_Check;
	int iCmd_Word;
	
	string sCMD_ABCDE  = CMD_ABCDE_PC_A + CMD_ABCDE_PC_B ;
	string sCMD_FGHIJ  = CMD_FGHIJ_PC_A ;
	string sCMD_KLMNO  = CMD_KLMNO_PC_A ;
	string sCMD_PQRST  = CMD_PQRST_PC_A +CMD_PQRST_PC_B ;
	string sCMD_UVWXYZ = CMD_UVWXYZ_PC_A ;

	
	//Set up CMD strings

	if(iStaffDM)
	{
		sCMD_ABCDE  = CMD_ABCDE_STAFF_DM_A +CMD_ABCDE_STAFF_DM_B ; 
		sCMD_FGHIJ  = CMD_FGHIJ_STAFF_DM_A ;
		sCMD_KLMNO  = CMD_KLMNO_STAFF_DM_A ;
		sCMD_PQRST  = CMD_PQRST_STAFF_DM_A + CMD_PQRST_STAFF_DM_B ;
		sCMD_UVWXYZ = CMD_UVWXYZ_STAFF_DM_A ;
	}

	if(iStoryDM)
	{
		sCMD_ABCDE  = CMD_ABCDE_STORY_DM_A + CMD_ABCDE_STORY_DM_B;
		sCMD_FGHIJ  = CMD_FGHIJ_STORY_DM_A ;
		sCMD_KLMNO  = CMD_KLMNO_STORY_DM_A ;
		sCMD_PQRST  = CMD_PQRST_STORY_DM_A + CMD_PQRST_STORY_DM_B ;
		sCMD_UVWXYZ = CMD_UVWXYZ_STORY_DM_A ;	
	}

	if(iStaff) //PC
	{
		if(!iStaffDM)
		{
			sCMD_ABCDE  = CMD_ABCDE_STAFF_A + CMD_ABCDE_STAFF_B ;
			sCMD_FGHIJ  = CMD_FGHIJ_STAFF_A ;
			sCMD_KLMNO  = CMD_KLMNO_STAFF_A ;
			sCMD_PQRST  = CMD_PQRST_STAFF_A + CMD_PQRST_STAFF_B ;
			sCMD_UVWXYZ = CMD_UVWXYZ_STAFF_A ;
		}	
	}
						
	sCmd_Message =  GetStringLowerCase(sMessage);
	sCmd_Char = GetSubString(sCmd_Message, 1 ,1 ); 
	iCmd_Word = FindSubString(sCmd_Message, " ");

	if(iCmd_Word == -1)
	{
		sCmd_Word = GetStringLowerCase(sCmd_Message);
	}
	else
	{
		sCmd_Word = GetStringLowerCase(GetStringLeft(sCmd_Message, iCmd_Word ));
	}
	
	if(iCmd_Word != -1)
	{
		sCmd_Word_Quantifier = StringTrim(GetStringRight(sCmd_Message, GetStringLength(sCmd_Message)-  FindSubString(sCmd_Message, " ")));
	}

	sCmd_Word = sCmd_Word + " "; //its a security feature :)
	
	sCmd_CheckChar = "abcdefghijklmnopqrstuvwxyz";

	iCmd_Switch = FindSubString(sCmd_CheckChar, sCmd_Char);

	if (oTarget == OBJECT_INVALID) oTarget = GetPlayerCurrentTarget(oSender);
	
	switch (iCmd_Switch)
	{
		case 0:
		case 1:
		case 2:
		case 3:
		case 4:
			iCmd_Check = FindSubString(sCMD_ABCDE , sCmd_Word, 0);
			if(iCmd_Check != -1)
			{
				if(sCmd_Word ==  "!addhench ")	{ CMD_addhench(oSender, oTarget, sCmd_Word_Quantifier);}
				if(sCmd_Word ==  "!aioff ")		{ CMD_aioff(oSender, oTarget, sCmd_Word_Quantifier);}
				if(sCmd_Word ==  "!aion ")		{ CMD_aion(oSender, oTarget, sCmd_Word_Quantifier);}
				if(sCmd_Word ==  "!appear ")		{ CMD_appear(oSender, oTarget, sCmd_Word_Quantifier);}
				if(sCmd_Word ==  "!appraise ")	{ CMD_skillroll(SKILL_APPRAISE, oSender, oTarget, sCmd_Word_Quantifier );}
				if(sCmd_Word ==  "!back ")		{ CMD_back(oSender, oTarget, sCmd_Word_Quantifier);}
				if(sCmd_Word ==  "!bluff ")	{ CMD_skillroll(SKILL_BLUFF, oSender, oTarget, sCmd_Word_Quantifier );}
				if(sCmd_Word ==  "!boot ")		{ CMD_boot(oSender, oTarget, sCmd_Word_Quantifier);}
				if(sCmd_Word ==  "!canite ")		{ CMD_canite(oSender, oTarget, sCmd_Word_Quantifier);}
				if(sCmd_Word ==  "!cdkey ")		{ CMD_cdkey(oSender, oTarget, sCmd_Word_Quantifier);}
				if(sCmd_Word ==  "!chat ")		{ CMD_activechat(oSender, oTarget, sCmd_Word_Quantifier);}				
				if(sCmd_Word ==  "!clean ")		{ CMD_clean(oSender,oTarget, sCmd_Word_Quantifier);}
				if(sCmd_Word ==  "!come ")		{ CMD_come(oSender, oTarget, sCmd_Word_Quantifier);}
				if(sCmd_Word ==  "!commoner ")	{ CMD_commoner(oSender, oTarget, sCmd_Word_Quantifier);}
				if(sCmd_Word ==  "!concentration ")	{ CMD_skillroll(SKILL_CONCENTRATION, oSender, oTarget, sCmd_Word_Quantifier );}
				if(sCmd_Word ==  "!craftalchemy ")	{ CMD_skillroll(SKILL_CRAFT_ALCHEMY, oSender, oTarget, sCmd_Word_Quantifier );}
				if(sCmd_Word ==  "!craftarmor ")	{ CMD_skillroll(SKILL_CRAFT_ARMOR, oSender, oTarget, sCmd_Word_Quantifier );}
				if(sCmd_Word ==  "!crafttrap ")	{ CMD_skillroll(SKILL_CRAFT_TRAP, oSender, oTarget, sCmd_Word_Quantifier );}				
				if(sCmd_Word ==  "!craftweapon ")	{ CMD_skillroll(SKILL_CRAFT_WEAPON, oSender, oTarget, sCmd_Word_Quantifier );}				
				if(sCmd_Word ==  "!damage ")		{ CMD_damage(oSender, oTarget, sCmd_Word_Quantifier);}
				if(sCmd_Word ==  "!debug ")		{ CMD_debug(oSender, sCmd_Word_Quantifier);}
				if(sCmd_Word ==  "!defender ")	{ CMD_defender(oSender, oTarget, sCmd_Word_Quantifier);}
				if(sCmd_Word ==  "!desc ")		{ CMD_desc(oSender, oTarget, sCmd_Word_Quantifier);}				
				if(sCmd_Word ==  "!deity ")		{ CMD_deity(oSender, oTarget, sCmd_Word_Quantifier);}
				if(sCmd_Word ==  "!destroy ")	{ CMD_destroy(oSender, oTarget, sCmd_Word_Quantifier);}
				if(sCmd_Word ==  "!diplomacy ")	{ CMD_skillroll(SKILL_DIPLOMACY, oSender, oTarget, sCmd_Word_Quantifier );}
				if(sCmd_Word ==  "!disabledevice ")	{ CMD_skillroll(SKILL_DISABLE_TRAP, oSender, oTarget, sCmd_Word_Quantifier );}
				if(sCmd_Word ==  "!discipline ")	{ CMD_skillroll(SKILL_DISCIPLINE, oSender, oTarget, sCmd_Word_Quantifier );}				
				if(sCmd_Word ==  "!dmgo ")		{ CMD_dmgo(oSender, oTarget, sCmd_Word_Quantifier);}	
				if(sCmd_Word ==  "!dmg ")		{ CMD_damage(oSender, oTarget, sCmd_Word_Quantifier);}																											
				if(sCmd_Word ==  "!eos ")		{ CMD_eos(oSender, oTarget, sCmd_Word_Quantifier);}
				if(sCmd_Word ==  "!dakhen ")	{ CMD_Dakhen(oTarget ); }
			}
		break;
		
		case 5:
		case 6:
		case 7:
		case 8:
		case 9:	
			iCmd_Check = FindSubString(sCMD_FGHIJ , sCmd_Word, 0);	
	
			if(iCmd_Check != -1)
			{
				if(sCmd_Word ==  "!feats ")		{ CMD_feats(oSender, oTarget, sCmd_Word_Quantifier);}
				if(sCmd_Word ==  "!free ")		{ CMD_free(oSender, oTarget, sCmd_Word_Quantifier);}
				if(sCmd_Word ==  "!freeze ")		{ CMD_freeze(oSender, oTarget, sCmd_Word_Quantifier);}
				if(sCmd_Word ==  "!gettag ")		{ CMD_gettag(oSender, oTarget, sCmd_Word_Quantifier);}
				if(sCmd_Word ==  "!givefeat ")	{ CMD_givefeat(oSender, oTarget, sCmd_Word_Quantifier);}
				if(sCmd_Word ==  "!heal ")		{ CMD_heal(oSender, oTarget, sCmd_Word_Quantifier);}
				if(sCmd_Word ==  "!healskill ")	{ CMD_skillroll(SKILL_HEAL, oSender, oTarget, sCmd_Word_Quantifier );}
				if(sCmd_Word ==  "!help ")		{CMD_help(oSender, sCMD_ABCDE, sCMD_FGHIJ, sCMD_KLMNO , sCMD_PQRST, sCMD_UVWXYZ );}
				if(sCmd_Word ==  "!heritage ")	{ CMD_heritage(oSender, oTarget, sCmd_Word_Quantifier );}
				if(sCmd_Word ==  "!hide ")	{ CMD_skillroll(SKILL_HIDE, oSender, oTarget, sCmd_Word_Quantifier );}
				if(sCmd_Word ==  "!hostile ")	{ CMD_hostile(oSender, oTarget, sCmd_Word_Quantifier);}
				if(sCmd_Word ==  "!imperial ")	{ CMD_imperial(oSender, oTarget, sCmd_Word_Quantifier);}
				if(sCmd_Word ==  "!intimidate ")	{ CMD_skillroll(SKILL_INTIMIDATE, oSender, oTarget, sCmd_Word_Quantifier );}
				if(sCmd_Word ==  "!invis ")		{ CMD_invis(oSender, oTarget, sCmd_Word_Quantifier);}
				if(sCmd_Word ==  "!jail ")		{ CMD_jail(oSender, oTarget, sCmd_Word_Quantifier);}
			}		
		break;

		case 10:
		case 11:
		case 12:
		case 13:
		case 14:
			iCmd_Check = FindSubString(sCMD_KLMNO , sCmd_Word, 0);	
				
			if(iCmd_Check != -1)
			{
				if(sCmd_Word ==  "!kill ")		{  CMD_kill(oSender, oTarget, sCmd_Word_Quantifier);}
				if(sCmd_Word ==  "!listen ")	{ CMD_skillroll(SKILL_LISTEN, oSender, oTarget, sCmd_Word_Quantifier );}
				if(sCmd_Word ==  "!look ")		{ CMD_look(oSender, oTarget, sCmd_Word_Quantifier);}
				if(sCmd_Word ==  "!lore ")	{ CMD_skillroll(SKILL_LORE, oSender, oTarget, sCmd_Word_Quantifier );}
				if(sCmd_Word ==  "!language ")	{ CMD_language(oSender, oTarget, sCmd_Word_Quantifier);}
				if(sCmd_Word ==  "!lng ")		{ CMD_language(oSender, oTarget, sCmd_Word_Quantifier);}
				if(sCmd_Word ==  "!moditem ")	{ CMD_moditem(oSender, oTarget, sCmd_Word_Quantifier);}
				if(sCmd_Word ==  "!morph ")		{ CMD_morph(oSender, oTarget, sCmd_Word_Quantifier); }
				if(sCmd_Word ==  "!motd ")		{ CMD_motd(oSender, oTarget, sCmd_Word_Quantifier);}
				if(sCmd_Word ==  "!movesilently ")	{ CMD_skillroll(SKILL_MOVE_SILENTLY, oSender, oTarget, sCmd_Word_Quantifier );}
				if(sCmd_Word ==  "!neutral ")	{ CMD_neutral(oSender, oTarget, sCmd_Word_Quantifier);}
				if(sCmd_Word ==  "!openlock ")	{ CMD_skillroll(SKILL_OPEN_LOCK, oSender, oTarget, sCmd_Word_Quantifier );}			
			}
		break;			

		case 15:
		case 16:
		case 17:
		case 18:
		case 19:
			iCmd_Check = FindSubString(sCMD_PQRST , sCmd_Word, 0);
					
			if(iCmd_Check != -1)
			{
				if(sCmd_Word ==  "!pardon ")		{ CMD_pardon(oSender, oTarget, sCmd_Word_Quantifier);}
				if(sCmd_Word ==  "!parry ")		{ CMD_skillroll(SKILL_PARRY, oSender, oTarget, sCmd_Word_Quantifier );}
				if(sCmd_Word ==  "!partychat ")	{ CMD_partychat(oSender, oTarget, sCmd_Word_Quantifier);}
				if(sCmd_Word ==  "!partyjump ")	{ CMD_partyjump(oSender, oTarget, sCmd_Word_Quantifier);}
				if(sCmd_Word ==  "!partyxp ")	{ CMD_partyxp(oSender, oTarget, sCmd_Word_Quantifier );}
				//!quiet - Deprecated - onchat handles chat deactivation
				if(sCmd_Word ==  "!perform ")	{ CMD_skillroll(SKILL_PERFORM, oSender, oTarget, sCmd_Word_Quantifier );}				
				if(sCmd_Word ==  "!raise ")		{ CMD_raise(oSender, oTarget, sCmd_Word_Quantifier);}
				if(sCmd_Word ==  "!rebel ")		{ CMD_rebel(oSender, oTarget, sCmd_Word_Quantifier);}
				if(sCmd_Word ==  "!removefeat ")	{ CMD_removefeat(oSender, oTarget, sCmd_Word_Quantifier);}
				if(sCmd_Word ==  "!rename ")		{ CMD_rename(oSender, oTarget, sCmd_Word_Quantifier);}
				if(sCmd_Word ==  "!renown ")		{ CMD_renown(oSender,  oTarget,  sCmd_Word_Quantifier);}
				if(sCmd_Word ==  "!rest ")		{ CMD_rest(oSender, oTarget, sCmd_Word_Quantifier);}
				if(sCmd_Word ==  "!rez ")		{ CMD_rez(oSender,  oTarget,  sCmd_Word_Quantifier);}
				if(sCmd_Word ==  "!rezarea ")	{ CMD_rezarea(oSender, oTarget, sCmd_Word_Quantifier);}			
				if(sCmd_Word ==  "!ride ")		{ CMD_skillroll(SKILL_RIDE, oSender, oTarget, sCmd_Word_Quantifier );}
				
				if(sCmd_Word ==  "!scry ")		{ CMD_scry(oSender, oTarget, sCmd_Word_Quantifier);}
				if(sCmd_Word ==  "!sendurl ")	{ CMD_sendurl(oSender, oTarget, sCmd_Word_Quantifier);}
				if(sCmd_Word ==  "!search ")		{ CMD_skillroll(SKILL_SEARCH, oSender, oTarget, sCmd_Word_Quantifier );}
				if(sCmd_Word ==  "!sensemotive "){ CMD_skillroll(SKILL_SENSE_MOTIVE, oSender, oTarget, sCmd_Word_Quantifier );}		
				if(sCmd_Word ==  "!setdetect ")	{ CMD_setdetect(oSender, oTarget, sCmd_Word_Quantifier);}	
				if(sCmd_Word ==  "!setdisarm ")	{ CMD_setdisarm(oSender, oTarget, sCmd_Word_Quantifier);}				
				if(sCmd_Word ==  "!setskill ")	{ CMD_setskill(oSender, oTarget, sCmd_Word_Quantifier);}
				if(sCmd_Word ==  "!settrap ")	{ CMD_skillroll(SKILL_SET_TRAP, oSender, oTarget, sCmd_Word_Quantifier );}
				if(sCmd_Word ==  "!setunlock ")	{ CMD_setunlock(oSender, oTarget, sCmd_Word_Quantifier);}
				if(sCmd_Word ==  "!shrink ")		{ CMD_shrink(oSender, oTarget, sCmd_Word_Quantifier);}
				if(sCmd_Word ==  "!sleightofhand ")	{ CMD_skillroll(SKILL_SLEIGHT_OF_HAND, oSender, oTarget, sCmd_Word_Quantifier );}	
				if(sCmd_Word ==  "!spawn ")		{ CMD_spawn(oSender, oTarget, sCmd_Word_Quantifier);}
				if(sCmd_Word ==  "!speaklanguage ")	{ CMD_skillroll(SKILL_SPEAK_LANGUAGE, oSender, oTarget, sCmd_Word_Quantifier );}
				if(sCmd_Word ==  "!spellcraft ")	{ CMD_skillroll(SKILL_SPELLCRAFT, oSender, oTarget, sCmd_Word_Quantifier );}
				if(sCmd_Word ==  "!spot ")		{ CMD_skillroll(SKILL_SPOT, oSender, oTarget, sCmd_Word_Quantifier );}
				if(sCmd_Word ==  "!survival ")	{ CMD_skillroll(SKILL_SURVIVAL, oSender, oTarget, sCmd_Word_Quantifier );}
				if(sCmd_Word ==  "!togencs ")	{ CMD_togencs(oSender, oTarget, sCmd_Word_Quantifier);}
				if(sCmd_Word ==  "!togolm ")		{ CMD_togOLM(oSender, oTarget, sCmd_Word_Quantifier);}																									
				if(sCmd_Word ==  "!taunt ")		{ CMD_skillroll(SKILL_TAUNT, oSender, oTarget, sCmd_Word_Quantifier );}
				if(sCmd_Word ==  "!tumble ")		{ CMD_skillroll(SKILL_TUMBLE, oSender, oTarget, sCmd_Word_Quantifier );}

				}		
		break;

		case 20: 
		case 21:
		case 22:
		case 23:
		case 24:
		case 25:
			iCmd_Check = FindSubString(sCMD_UVWXYZ , sCmd_Word, 0);	
				
			if(iCmd_Check != -1)
			{
				if(sCmd_Word ==  "!unvis "){ CMD_unvis(oSender, oTarget, sCmd_Word_Quantifier);}
				if(sCmd_Word ==  "!usemagicdevice ")	{ CMD_skillroll(SKILL_USE_MAGIC_DEVICE, oSender, oTarget, sCmd_Word_Quantifier );}
				if(sCmd_Word ==  "!vars "){CMD_vars(oSender, oTarget, sCmd_Word_Quantifier );}
				if(sCmd_Word ==  "!version "){CMD_version(oSender, sCmd_Word_Quantifier );}				
				if(sCmd_Word ==  "!where "){CMD_where(oSender, oTarget, sCmd_Word_Quantifier);}
				if(sCmd_Word ==  "!xp "){ CMD_xp(oSender, oTarget, sCmd_Word_Quantifier );}
				if(sCmd_Word ==  "!zombie "){ CMD_zombie(oSender, oTarget, sCmd_Word_Quantifier);}
			}
		break;
		
		default:
		//error message goes here
			sInform_oSenderDM(oSender,"Invalid command. Use !help to see valid commands.");
		break;	
	}	
}	


void CMD_activechat( object oSender, object oTarget, string sCmd_Word_Quantifier )
{
	int iDM_Chat_On;
	object oModule = GetModule();
	if(sCmd_Word_Quantifier == "?")
	{
		sInform_oSenderDM(oSender,"Command: !chat");	
		sInform_oSenderDM(oSender, "Use this command to toggle Module wide listening on/off on the Talk/Whisper/Shout channels." );
		sInform_oSenderDM(oSender, "The previous !quiet command is deprecated as onchat will turn off chat logging if there isn't a DM logged in and using it." );			
//		sInform_oSenderDM(oSender, "MOD_LNG_ACTIVE_CHAT =  " + IntToString(GetLocalInt(GetModule(),MOD_LNG_ACTIVE_CHAT)) );			

	}	

	else
	{		
		iDM_Chat_On = GetLocalInt(oSender, ACTIVE_CHAT_DM);
		if(iDM_Chat_On)		
		//if(iDM_Chat)
		{

			SetLocalInt(oSender, ACTIVE_CHAT_DM, FALSE);	
					
			sInform_oSenderDM(oSender, "Chat Capture Off." );
			//No need to change the module variable as the main on chat script manages this.
			//9/9/12 actually no need to change as we're not using the module var anymore		
		}
		else
		{
					
			SetLocalInt(oSender, ACTIVE_CHAT_DM, TRUE);
			//SetLocalInt(oModule,MOD_LNG_ACTIVE_CHAT, TRUE);			
			sInform_oSenderDM(oSender, "Chat Capture On." );
			//sInform_oSenderDM(oSender, "ACTIVE_CHAT_DM " +IntToString(GetLocalInt(oSender, ACTIVE_CHAT_DM )) );
			//sInform_oSenderDM(oSender, "MOD_LNG_ACTIVE_CHAT "  +IntToString(GetLocalInt(oModule, MOD_LNG_ACTIVE_CHAT )));			
			
		}
	}		
}

void CMD_addhench( object oSender, object oTarget, string sCmd_Word_Quantifier )
{
	object oHenchman;

	if(sCmd_Word_Quantifier == "?")
	{
		sInform_oSenderDM(oSender,"Command: !addhench xxx");	
			sInform_oSenderDM(oSender, "Use this command to add an NPC henchmen to your current Target." );
			sInform_oSenderDM(oSender, "You need the Henchman's tag, xxx, to do this. Use !gettag to retreive this.");
			sInform_oSenderDM(oSender, "If there are multiple NPCs of tag xxx in the area this command will target the nearest NPC.");			
	}	
	else
	{	
		oHenchman = GetNearestObjectByTag(sCmd_Word_Quantifier , oTarget);
			
		HenchmanAdd(oTarget, oHenchman,TRUE,TRUE);
		sInform_oSenderDM(oSender,"Adding henchman (Tag:"+sCmd_Word_Quantifier+") to "+GetFirstName(oTarget)+".");
	}		
}

void CMD_aioff( object oSender, object oTarget, string sCmd_Word_Quantifier )
{
	int n;

	if(sCmd_Word_Quantifier == "?")
	{
		sInform_oSenderDM(oSender,"Command: !aioff");	
			sInform_oSenderDM(oSender, "Purpose:Default, use this command to set the AI of your current Target to <i>Low</i>." );
			sInform_oSenderDM(oSender, "Option: !aioff all - <i>Sets the AI of all NPCs in the current area to Low.</i>");
	}
	else if(sCmd_Word_Quantifier == "all")
	{
		n = 1;
		oTarget = GetNearestCreature(CREATURE_TYPE_PLAYER_CHAR, PLAYER_CHAR_NOT_PC, oSender, n);
		while (GetIsObjectValid(oTarget))
		{
			SetAILevel(oTarget,AI_LEVEL_VERY_LOW);
			sInform_oSenderDM(oSender, "AI off: " + GetName(oTarget)+".");
			n++;
			oTarget = GetNearestCreature(CREATURE_TYPE_PLAYER_CHAR, PLAYER_CHAR_NOT_PC, oSender, n);
		}
	}
	else
	{
		SetAILevel(oTarget,AI_LEVEL_VERY_LOW);
	}		
}		

void CMD_aion( object oSender, object oTarget, string sCmd_Word_Quantifier )
{
	int n;

	if(sCmd_Word_Quantifier == "?")
	{
		sInform_oSenderDM(oSender,"Command: !aion");	
			sInform_oSenderDM(oSender, "Default, use this command to restore the AI of your current Target to <i>Default</i>." );
			sInform_oSenderDM(oSender, "Option: !aion all - <i>Sets the AI of all NPCs in the current area to Default.");
	}
	else if(sCmd_Word_Quantifier == "all")
	{
		n = 1;
		oTarget = GetNearestCreature(CREATURE_TYPE_PLAYER_CHAR, PLAYER_CHAR_NOT_PC, oSender, n);
		while (GetIsObjectValid(oTarget))
		{
			SetAILevel(oTarget,AI_LEVEL_DEFAULT);
			sInform_oSenderDM(oSender, "AI off: " + GetName(oTarget)+".");
			n++;
			oTarget = GetNearestCreature(CREATURE_TYPE_PLAYER_CHAR, PLAYER_CHAR_NOT_PC, oSender, n);
		}
	}
	else
	{
		SetAILevel(oTarget,AI_LEVEL_DEFAULT);
	}			
}		

void CMD_appear( object oSender, object oTarget, string sCmd_Word_Quantifier )
{
	if(sCmd_Word_Quantifier == "?")
	{
		sInform_oSenderDM(oSender,"Command: !appear ###");	
		sInform_oSenderDM(oSender, "Use this command to set the appearance of the your current target. See appearance.2da for values." );
	}
	else 
	{
		SetLocalObject(oSender, "oTarget", oTarget);	
		DisplayInputBox (oSender, 0, "Enter Appearance #", "gui_wand_appearance_ok", "gui_wand_appearance_cancel", TRUE, "", 0, "", 0, "", "");
	}
}	
	
void CMD_back( object oSender, object oTarget, string sCmd_Word_Quantifier )
{
	if(sCmd_Word_Quantifier == "?")
	{
		sInform_oSenderDM(oSender,"Command: !back");	
		sInform_oSenderDM(oSender, "Use this command to return a player summoned by !come or !partycome to their point of origin." );
	}
	else 
	{
		AssignCommand(oTarget,JumpToLocation( GetLocalLocation(oTarget,"came_from")) );
		sInform_oSenderDM(oSender, "Jumping " + GetName(oTarget)+ " to their previous location.");
	}		
}

void CMD_boot( object oSender, object oTarget, string sCmd_Word_Quantifier )
{
	if(sCmd_Word_Quantifier == "?")
	{
		sInform_oSenderDM(oSender,"Command: !boot");	
		sInform_oSenderDM(oSender, "Use this command to boot the current target from the server." );
	}
	else 
	{
		sInform_oSenderDM(oSender, GetName(oTarget)+ " booted from server!" );
		sInform_oSenderDM(oSender, GetPCPlayerName(oTarget)+"'s CD Key is: "+GetPCPublicCDKey(oTarget)+" & IP Address is: "+GetPCIPAddress(oTarget)+"." );
		
		BootPC(oTarget);
	}
}

void CMD_canite( object oSender, object oTarget, string sCmd_Word_Quantifier )
{
	if(sCmd_Word_Quantifier == "?")		
	{
		sInform_oSenderDM(oSender,"Command: !canite");	
		sInform_oSenderDM(oSender,"Purpose: Change current target to the Canite faction.");
	} 			
	else
	{
		sInform_oSenderDM(oSender, GetName(oTarget)+ "'s faction has been set to Canite." );
		ChangeFaction(oTarget, GetObjectByTag(METAFAC_CANITE_PROXY));
	}
}

void CMD_cdkey( object oSender, object oTarget, string sCmd_Word_Quantifier )
{
	if(sCmd_Word_Quantifier == "?")
	{
		sInform_oSenderDM(oSender,"Command: !cdkey");	
		sInform_oSenderDM(oSender, "Use this command to get the Public CD key of your current target." );
	}
	else 
	{
		sInform_oSenderDM(oSender, GetPCPlayerName(oTarget)+"'s CD Key is: "+GetPCPublicCDKey(oTarget)+" & IP Address is: "+GetPCIPAddress(oTarget)+"." );
	}
}

void CMD_clean( object oSender, object oTarget, string sCmd_Word_Quantifier )
{
	object oCharacter;
	object oArea = GetArea(oSender);
	float fRadius;
	int bAreaEmpty;
	//Set oTarget to oSender = this command is always targeted on the DM
	oTarget = oSender;

		if(sCmd_Word_Quantifier == "?")
	{
		sInform_oSenderDM(oSender,"Command: !clean ###");	
		sInform_oSenderDM(oSender, "Default, use this command to destroy Placed Effects, Objects or Lights in a small radius from your current target." );
		sInform_oSenderDM(oSender, "Option: !clean m - <i> Cleans within a medium radius from your current target.</i>." );	
		sInform_oSenderDM(oSender, "Option: !clean l - <i> Cleans within a large radius from your current target.</i>." );
		sInform_oSenderDM(oSender, "Option: !clean h - <i> Cleans within a huge radius from your current target.</i>." );
		sInform_oSenderDM(oSender, "Option: !clean area - <i> Cleans the area you are currently in, if free of PCs.</i>." );								
	}
	else 
	{		
		if(sCmd_Word_Quantifier  == ""){fRadius= RADIUS_SIZE_SMALL;}
		if(sCmd_Word_Quantifier  == "m"){fRadius= RADIUS_SIZE_MEDIUM;}
		if(sCmd_Word_Quantifier  == "l"){fRadius= RADIUS_SIZE_LARGE;}
		if(sCmd_Word_Quantifier  == "h"){fRadius= RADIUS_SIZE_HUGE;}
	
		object oInShape = GetFirstObjectInShape(SHAPE_SPHERE, fRadius, GetLocation(oTarget), TRUE, OBJECT_TYPE_PLACED_EFFECT | OBJECT_TYPE_PLACEABLE | OBJECT_TYPE_LIGHT);
		//Cycle through the targets within the spell shape until an invalid object is captured.
									
		while (GetIsObjectValid(oInShape))
		{
			DestroyObject(oInShape);
			sInform_oSenderDM(oSender, "Destroyed Object " + GetTag(oInShape)+".");
		    oInShape = GetNextObjectInShape(SHAPE_SPHERE, fRadius, GetLocation(oTarget), TRUE, OBJECT_TYPE_PLACED_EFFECT | OBJECT_TYPE_PLACEABLE | OBJECT_TYPE_LIGHT);
		}
		
		
		if(sCmd_Word_Quantifier  == "area")
		{
		
			bAreaEmpty = TRUE;
	
	        oCharacter = GetFirstPC();
	        while (GetIsObjectValid(oCharacter) && bAreaEmpty)
	        {
				if (oCharacter != oSender) 
				{
	           		if (GetArea(oCharacter) == oArea ) bAreaEmpty = FALSE;
				}
	            oCharacter = GetNextPC();
	        }
	
	        if (bAreaEmpty )
	        {
	            SetLocalInt(oArea, "bAreaEmpty", bAreaEmpty);
				sInform_oSenderDM(oSender, "bAreaEmpty set to" +IntToString(GetLocalInt(oArea, "bAreaEmpty"))+".");				
				
	            DoSweep(oArea);
	        }		
		
		
		}
		
		
	}
}

void CMD_come( object oSender, object oTarget, string sCmd_Word_Quantifier )
{
	if(sCmd_Word_Quantifier == "?")		
	{
		sInform_oSenderDM(oSender,"Command: !come");	
		sInform_oSenderDM(oSender,"Purpose: Jump the current target to your location. Use !back to return them to their point of origin.");
	} 			
	else
	{
		SetLocalLocation(oTarget,"came_from",GetLocation(oTarget)); 
		AssignCommand(oTarget,JumpToLocation(GetLocation(oSender)));
		sInform_oSenderDM(oSender, "Jumping " + GetName(oTarget)+ " to your location. Use !back to return them to their point of origin." );
	}	
}

void CMD_commoner( object oSender, object oTarget, string sCmd_Word_Quantifier )
{
	if(sCmd_Word_Quantifier == "?")		
	{
		sInform_oSenderDM(oSender,"Command: !commoner");	
		sInform_oSenderDM(oSender,"Purpose: Change current target to the Commoner faction.");
	} 			
	else
	{
		ChangeToStandardFaction(oTarget,STANDARD_FACTION_COMMONER);  
		sInform_oSenderDM(oSender, GetName(oTarget)+ "'s faction has been set to Commoner." );
	}
}

void CMD_damage(object oSender, object oTarget, string sCmd_Word_Quantifier)
{
	int nDamage;
	
	if(sCmd_Word_Quantifier == "?")		
	{
		sInform_oSenderDM(oSender,"Command: !damage ### / !dmg ###");	
		sInform_oSenderDM(oSender,"Purpose: Apply ### damage to your current target.");
	}	
	else
	{
		nDamage=StringToInt(sCmd_Word_Quantifier);
		ApplyEffectToObject(0,EffectDamage(nDamage,DAMAGE_TYPE_BLUDGEONING,DAMAGE_POWER_PLUS_FIVE,TRUE),oTarget); 
		sInform_oSenderDM(oSender, "Applied "+sCmd_Word_Quantifier+" dmg to " + GetName(oTarget)+"." );
	}
}

void CMD_debug(object oSender, string sCmd_Word_Quantifier)
{
	int iDebug;
	if(sCmd_Word_Quantifier == "?")		
	{
		sInform_oSenderDM(oSender,"Command: !debug");	
		sInform_oSenderDM(oSender,"Purpose: Toggles debugging for chat system on/off.");
	} 			
	else
	{
		iDebug = GetLocalInt(oSender, LANG_DEBUG);	
		if(iDebug)
		{
			SetLocalInt(oSender, LANG_DEBUG, FALSE);
		}
		else
		{
			SetLocalInt(oSender, LANG_DEBUG, TRUE);		
		}
		
	}
}

void CMD_defender( object oSender, object oTarget, string sCmd_Word_Quantifier )
{
	if(sCmd_Word_Quantifier == "?")		
	{
		sInform_oSenderDM(oSender,"Command: !defender");	
		sInform_oSenderDM(oSender,"Purpose: Change current target to the Defender faction.");
	} 			
	else
	{
		ChangeToStandardFaction(oTarget,STANDARD_FACTION_DEFENDER);
		sInform_oSenderDM(oSender, GetName(oTarget)+ "'s faction has been set to Defender." );	
	}
}

void CMD_desc( object oSender, object oTarget, string sCmd_Word_Quantifier )
{
	if(sCmd_Word_Quantifier == "?")		
	{
		sInform_oSenderDM(oSender,"Command: !desc");	
		sInform_oSenderDM(oSender,"Purpose: Get the description of your current target.");
	} 			
	else
	{
		// only works on PCs
		if ( GetIsPC( oTarget ) )
		{
			DisplayGuiScreen(oTarget,"SCREEN_EXAMINE_DESCRIPTION", FALSE, "_SCdescription_data.xml");
			// SetLocalGUIVariable(oDM,"SCREEN_EXAMINE_DESCRIPTION", 0, ObjectToString(oDM) ); //IntToString(ObjectToInt(oDM) )
			int iRandom = Random(20000)+1;
			SetLocalInt( oTarget, "CSL_DATACALLBACKDESCRIPTION", iRandom );
			SetLocalGUIVariable(oTarget,"SCREEN_EXAMINE_DESCRIPTION", 5, IntToString(iRandom) );
			DelayCommand( 2.0f, DeleteLocalInt( oTarget,"CSL_DATACALLBACKDESCRIPTION") );
	
			DelayCommand( 2.0f, 	sInform_oSenderDM( oSender, GetName(oTarget)+" Description: "+GetLocalString( oTarget, "DESCRIPTION") ) );
		}
		else
		{
			sInform_oSenderDM( oSender, "The only valid target for this command is a PC.");
		}
	}
}

void CMD_deity( object oSender, object oTarget, string sCmd_Word_Quantifier )
{
	if(sCmd_Word_Quantifier == "?")		
	{
		sInform_oSenderDM(oSender,"Command: !deity");	
		sInform_oSenderDM(oSender,"Purpose: Fires the change diety conversation for your current target.");
	} 			
	else
	{
		SetLocalObject(oSender,"deity_switch_player",oTarget);
		AssignCommand(oSender,ActionStartConversation(oSender,"dmwand_cnv_setdeity",TRUE,FALSE));
	}
}

void CMD_destroy( object oSender, object oTarget, string sCmd_Word_Quantifier )
{
	string sName;
	if(sCmd_Word_Quantifier == "?")		
	{
		sInform_oSenderDM(oSender,"Command: !destroy");	
		sInform_oSenderDM(oSender,"Purpose: Destroy your current target, (automatically marks the target as destroyable).");
	} 			
	else
	{
		SetObjectIsDestroyable(oTarget, TRUE, FALSE, FALSE);
		sName = GetName(oTarget);
		DestroyObject(oTarget);	
		sInform_oSenderDM(oSender, "You have destroyed " + sName);
	}		
}

void CMD_dmgo( object oSender, object oTarget, string sCmd_Word_Quantifier )
{
	if(sCmd_Word_Quantifier == "?")		
	{
		sInform_oSenderDM(oSender,"Command: !dmgo");	
		sInform_oSenderDM(oSender,"Purpose: Jump to your currently selected target.");
	} 			
	else
	{
		AssignCommand(oSender,JumpToLocation(GetLocation(oTarget)));
	}
}

void CMD_eos( object oSender, object oTarget, string sCmd_Word_Quantifier )
{
	if(sCmd_Word_Quantifier == "?")		
	{
		sInform_oSenderDM(oSender,"Command: !eos");	
		sInform_oSenderDM(oSender,"Purpose: Set your currently selected target to EOS, (make guards hostile).");
	} 			
	else
	{
		std_reputation_set( oTarget, "cearguard", 1 ); std_reputation_reset( oTarget, "cearguard" );
	}
}

void CMD_free( object oSender, object oTarget, string sCmd_Word_Quantifier )
{
	if(sCmd_Word_Quantifier == "?")		
	{
		sInform_oSenderDM(oSender,"Command: !free");	
		sInform_oSenderDM(oSender,"Purpose: Removes the effects of !freeze. Deprecated command, use !freeze off.");
	} 			
	else
	{
		AssignCommand(oTarget,ClearAllActions()); 
		SetCommandable(TRUE,oTarget);
		sInform_oSenderDM(oSender, GetName(oSender)+" is unfrozen!");
	}		 
}

void CMD_freeze(object oSender, object oTarget, string sCmd_Word_Quantifier)
{
	if(sCmd_Word_Quantifier == "?")		
	{
		sInform_oSenderDM(oSender,"Command: !freeze");	
		sInform_oSenderDM(oSender,"Purpose: Freezes your current target in place, (PC's become non responsive to keyboard and mouse).");		
		sInform_oSenderDM(oSender,"Option: !freeze off / !freeze 0 - <i>Removes the effects of !freeze.</i>");
	} 			
	else if(sCmd_Word_Quantifier == "0" ||  sCmd_Word_Quantifier == "off")
	{
		AssignCommand(oTarget,ClearAllActions()); 
		SetCommandable(TRUE,oTarget); 
		sInform_oSenderDM(oSender, GetName(oTarget)+" is unfrozen!");	
	}
	else 
	{
		AssignCommand(oTarget,ClearAllActions()); 
		SetCommandable(FALSE,oTarget); 
		sInform_oSenderDM(oSender, GetName(oTarget)+" is frozen!");
	}
}

void CMD_gettag( object oSender, object oTarget, string sCmd_Word_Quantifier )
{
	if(sCmd_Word_Quantifier == "?")		
	{
		sInform_oSenderDM(oSender,"Command: !gettag");	
		sInform_oSenderDM(oSender,"Purpose: Gets the tag of your current target.");		
	} 			
	else
	{
		sInform_oSenderDM(oSender, "Tag of target is " + GetTag(oTarget)+".");	
	}
}

void CMD_givefeat(object oSender, object oTarget, string sCmd_Word_Quantifier)
{
	string sFeatGiven;
	
	if(sCmd_Word_Quantifier == "?")		
	{
		sInform_oSenderDM(oSender,"Command: !givefeat ###");	
		sInform_oSenderDM(oSender,"Purpose: Adds feat ### to your current target.");
		sInform_oSenderDM(oSender, "Warning: Adding feats may invalidate a player character!");		
	} 			
	else
	{
		sFeatGiven = GetStringByStrRef( StringToInt(Get2DAString("feat", "FEAT", StringToInt(sCmd_Word_Quantifier)))); 
		FeatAdd(oTarget, StringToInt(sCmd_Word_Quantifier), TRUE);
		sInform_oSenderDM(oSender, "Adding Feats may invalidate a character!");
		sInform_oSenderDM(oSender, "Feat "+ sFeatGiven+" added to "+GetName(oTarget)+".");	
	}
	
}

void CMD_heal( object oSender, object oTarget, string sCmd_Word_Quantifier )
{
	if(sCmd_Word_Quantifier == "?")		
	{
		sInform_oSenderDM(oSender,"Command: !heal");	
		sInform_oSenderDM(oSender,"Purpose: Heals current target to max hit points.");
	} 			
	else
	{
		ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectHeal(GetMaxHitPoints(oTarget)),oTarget);
	}
}

void CMD_help(object oSender, string sCMD_ABCDE, string sCMD_FGHIJ, string sCMD_KLMNO , string sCMD_PQRST, string sCMD_UVWXYZ )
{
	string sHelpMessage;
	sHelpMessage = ( "HELP"+CLR_NEWLINE+ sCMD_ABCDE + sCMD_FGHIJ + sCMD_KLMNO + sCMD_PQRST + sCMD_UVWXYZ );
	sInform_oSenderDM(oSender, sHelpMessage);
}


void CMD_heritage( object oSender, object oTarget, string sCmd_Word_Quantifier )
{
	if(sCmd_Word_Quantifier == "?")		
	{
		sInform_oSenderDM(oSender,"Command: !heritage");	
		sInform_oSenderDM(oSender,"Purpose: Allows legacy humans to select a heritage from Dasarian lore.");
	} 			
	else
	{
		OpenHumanGUI(oSender);
	}
}


void CMD_hostile( object oSender, object oTarget, string sCmd_Word_Quantifier )
{
	if(sCmd_Word_Quantifier == "?")		
	{
		sInform_oSenderDM(oSender,"Command: !hostile");	
		sInform_oSenderDM(oSender,"Purpose: Change current target to the Hostile faction.");
	} 			
	else
	{
		ChangeToStandardFaction(oTarget,STANDARD_FACTION_HOSTILE);  
		sInform_oSenderDM(oSender, GetName(oTarget)+ "'s faction has been set to Hostile" );
	}
}

void CMD_imperial( object oSender, object oTarget, string sCmd_Word_Quantifier )
{

	if(sCmd_Word_Quantifier == "?")		
	{
		sInform_oSenderDM(oSender,"Command: !imperial");	
		sInform_oSenderDM(oSender,"Purpose: Change current target to the Imperial faction.");
	} 			
	else
	{
		ChangeFaction(oTarget, GetObjectByTag(METAFAC_IMPERIAL_PROXY));
		sInform_oSenderDM(oSender, GetName(oTarget)+ "'s faction has been set to Imperial." );
	}
}

void CMD_invis( object oSender, object oTarget, string sCmd_Word_Quantifier )
{
	effect eEffect;
	
	if(sCmd_Word_Quantifier == "?")		
	{
		sInform_oSenderDM(oSender,"Command: !invis");	
		sInform_oSenderDM(oSender,"Purpose: Super DM invisability.");
		sInform_oSenderDM(oSender,"Option: !invis 0 / !invis off - <i>Turn off super DM invisability.</i>");		
		sInform_oSenderDM(oSender, "Please be aware veiwing inventories may cause unwelcome results - ie client crashes.");		
	} 
	else
	{
		eEffect = EffectCutsceneGhost();
		eEffect = EffectLinkEffects(eEffect, EffectVisualEffect(VFX_DUR_CUTSCENE_INVISIBILITY) );
		eEffect = EffectLinkEffects(eEffect, EffectEthereal() );
		eEffect = SupernaturalEffect( eEffect );
		eEffect = SetEffectSpellId(eEffect, -55 );
	
		
		if(GetIsStoryDM(oSender) || GetIsStaffDM(oSender))
		{	
			if( sCmd_Word_Quantifier == "0" || sCmd_Word_Quantifier == "off")
			{
				SetCollision(oSender, TRUE);
				DelayCommand(2.0, SetCreatureAppearanceType(oSender, GetLocalInt(oSender, "DM_INVIS")));
					
				effect eff = GetFirstEffect(oSender);
				while (GetIsEffectValid(eff))
				{
			    	if(GetEffectSpellId(eff) == -55)
			        {
			        	RemoveEffect(oSender, eff);
			 		}
					eff=GetNextEffect(oSender);
				}			
			
			}
			else
			{	
				sInform_oSenderDM(oSender, "Please be aware veiwing inventories may cause unwelcome results - ie client crashes.");	
				SetCollision(oSender, FALSE);
				ApplyEffectToObject(DURATION_TYPE_PERMANENT, eEffect, oSender );
				SetLocalInt(oSender, "DM_INVIS", GetAppearanceType(oSender));	
				SetCreatureAppearanceType(oSender, 611);
			}
		}
		else
		{
			sInform_oSenderDM(oSender, "Only DM's are valid targets for this command.");	
		}
	}
}

void CMD_jail( object oSender, object oTarget, string sCmd_Word_Quantifier )
{ 
	location lDest;
		
	if(sCmd_Word_Quantifier == "?")		
	{
		sInform_oSenderDM(oSender,"Command: !jail");	
		sInform_oSenderDM(oSender,"Purpose: Sends your current target to jail.");
	} 
	else
	{	
		issueWarrant(oTarget,oSender); 
		lDest = GetOpenCell(oTarget); 
		AssignCommand( oTarget, JumpToLocation(lDest)); 
	}	
} 

void CMD_kill( object oSender, object oTarget, string sCmd_Word_Quantifier )
{
	if(sCmd_Word_Quantifier == "?")		
	{
		sInform_oSenderDM(oSender,"Command: !kill");	
		sInform_oSenderDM(oSender,"Purpose: Kills your current target, dead.");
	} 
	else
	{	
		ApplyEffectToObject(0,EffectDeath(0,1,1),oTarget);
		sInform_oSenderDM(oSender, "You have killed "+ GetName(oTarget)+"." );	
	}
}

void CMD_look( object oSender, object oTarget, string sCmd_Word_Quantifier )
{
	string sParty;
	object oPartyTarget;

	if(sCmd_Word_Quantifier == "?")		
	{
		sInform_oSenderDM(oSender,"Command: !look");	
		sInform_oSenderDM(oSender,"Purpose: Gather details of your current Target while they are in another area.");
		sInform_oSenderDM(oSender,"May return some invalid results depending on the nature of the target.");		
	} 			
	else
	{
		//This doesn't actually work outside of oArea - either add a gui or

		sInform_oSenderDM(oSender, "Name :"+ GetName(oTarget) );
		sInform_oSenderDM(oSender, "Current Location :" + GetName(GetArea(oTarget)));
		sInform_oSenderDM(oSender, "Alignment (GE/LC) :" + IntToString(GetAlignmentGoodEvil(oTarget)) +"/"  + IntToString(GetAlignmentLawChaos(oTarget))   );				
		sInform_oSenderDM(oSender, "Race/Subrace :" + IntToString(GetRacialType(oTarget))+"/"+ IntToString(GetSubRace(oTarget)) );
		sInform_oSenderDM(oSender, "Classes :" + IntToString(GetClassByPosition(1, oTarget))+"/"+IntToString(GetClassByPosition(2, oTarget))+"/"+IntToString(GetClassByPosition(3, oTarget))+"/"+IntToString(GetClassByPosition(4, oTarget)) );					
		sInform_oSenderDM(oSender, "Level :" + IntToString(GetTotalLevels(oTarget, 1))  + " ( " + IntToString(GetLevelByPosition(1, oTarget)) + "/" + IntToString(GetLevelByPosition(2, oTarget)) + "/" + IntToString(GetLevelByPosition(3, oTarget)) +" )" );					
		sInform_oSenderDM(oSender, "XP :"+ IntToString(GetXP(oTarget)));
		sInform_oSenderDM(oSender, "Str: " + IntToString(GetAbilityScore(oTarget, ABILITY_STRENGTH )) + " (" + IntToString(GetAbilityScore(oTarget, ABILITY_STRENGTH ,TRUE)) + ")" );
		sInform_oSenderDM(oSender, "Dex: " + IntToString(GetAbilityScore(oTarget, ABILITY_DEXTERITY )) + " (" + IntToString(GetAbilityScore(oTarget, ABILITY_DEXTERITY ,TRUE)) + ")" );
		sInform_oSenderDM(oSender, "Con: " + IntToString(GetAbilityScore(oTarget, ABILITY_CONSTITUTION )) + " (" + IntToString(GetAbilityScore(oTarget, ABILITY_CONSTITUTION ,TRUE)) + ")" );
		sInform_oSenderDM(oSender, "Wis: " + IntToString(GetAbilityScore(oTarget, ABILITY_WISDOM )) + " (" + IntToString(GetAbilityScore(oTarget, ABILITY_WISDOM ,TRUE)) + ")" );
		sInform_oSenderDM(oSender, "Int: " + IntToString(GetAbilityScore(oTarget, ABILITY_INTELLIGENCE )) + " (" + IntToString(GetAbilityScore(oTarget, ABILITY_INTELLIGENCE ,TRUE)) + ")" );
		sInform_oSenderDM(oSender, "Cha: " + IntToString(GetAbilityScore(oTarget, ABILITY_CHARISMA )) + " (" + IntToString(GetAbilityScore(oTarget,ABILITY_CHARISMA ,TRUE)) + ")" );
		sInform_oSenderDM(oSender, "Fort: " + IntToString(GetFortitudeSavingThrow(oTarget )));
		sInform_oSenderDM(oSender, "Ref: " + IntToString(GetReflexSavingThrow(oTarget ))); 
		sInform_oSenderDM(oSender, "Will: " + IntToString(GetWillSavingThrow(oTarget ))); 
		sInform_oSenderDM(oSender, "AC: " + IntToString(GetAC(oTarget ))); 
		sInform_oSenderDM(oSender, "BAB: " + IntToString(GetBaseAttackBonus(oTarget ))); 		
		sInform_oSenderDM(oSender, "Description: " + GetDescription(oTarget )); 

		sParty = "";
		oPartyTarget = GetFirstFactionMember(oTarget, FALSE);
		while (GetIsObjectValid(oPartyTarget)) 
		{
			if(oPartyTarget != oSender)
			{
				sParty = sParty + GetName(oPartyTarget) +", ";
			}
			oPartyTarget = GetNextFactionMember(oTarget, FALSE);
	    }		
		sInform_oSenderDM(oSender, "Party: " + sParty ); 
	}
}



void CMD_language( object oSender, object oTarget, string sCmd_Word_Quantifier )
{
	object oJournal = std_journal_get( oSender );
	int iDefaultLanguage, iCurrentLanguage, iEmoOn;
	int iStoryDM = GetIsStoryDM(oSender);
 	int iStaffDM = GetIsStaffDM(oSender);
	int iIsDM = FALSE;
	string sDefaultLanguage, sEmoOn, sFirstChar, sLNG_PC_EmoteSymbolStart, sLNG_PC_EmoteSymbolEnd, sLNG_PC_FontStart;
	string sLanguage_FeatID    ;
	
	if(iStoryDM || iStaffDM){iIsDM = TRUE;}
		
	sCmd_Word_Quantifier = GetStringLowerCase(sCmd_Word_Quantifier);
	sFirstChar = GetStringLeft(sCmd_Word_Quantifier, 1);
	iEmoOn = FALSE;
	
	if(sCmd_Word_Quantifier == "?")	
	{
		sInform_oSenderDM(oSender, "Command: !language or !lng ");
		sInform_oSenderDM(oSender, "Purpose: Manages PC settings for languages.");
		sInform_oSenderDM(oSender, "Option: !language/!lng default -<i>Sets currently selected language as your default language.</i>");
		sInform_oSenderDM(oSender, "Option: !language/!lng emote -<i>Toggles emote animations on/off, (currently inactive).</i>");
		sInform_oSenderDM(oSender, "Option: !language/!lng XemoteX -<i>Sets emote symbol to X.</i>");
		if(iIsDM) {sInform_oSenderDM(oSender, "Option: !language/!lng font# <i>Sets your common font color and style based on the numeric value of X. Type </i>!colours?<i> to see a list of values.</i>");}	
		sInform_oSenderDM(oSender, "Option: !language/!lng pick <i>Opens the lanugage GUI, allows you to pick new languages.</i>");	

	}
		
	if(sCmd_Word_Quantifier == "default")
	
	{	
		iCurrentLanguage = GetLocalInt( oSender, LANG_SPOKEN_2DA_ROW);
		iDefaultLanguage = GetDefaultLanguage(oJournal, oSender);
		sDefaultLanguage = GetLocalString ( oSender, LANG_SPOKEN );
			
		if(iDefaultLanguage != iCurrentLanguage )
		{
			SetLocalInt(oJournal, LANG_DEFAULT, iCurrentLanguage);
			sInform_oSenderDM(oSender, "You have set your default language to "+ sDefaultLanguage );
		}
		else
		{
			sInform_oSenderDM(oSender, "Your default language is already set to "+ sDefaultLanguage );	
		}
	}
	
	if(sCmd_Word_Quantifier == "emote")
	{	
		iEmoOn = (GetLocalInt(oJournal, PC_EMOTE_VERBAL_OFF)) ? FALSE : TRUE;
		sEmoOn = (iEmoOn) ? "off" : "on";
					
		SetLocalInt(oJournal, PC_EMOTE_VERBAL_OFF, iEmoOn);
		SetLocalInt(oSender, PC_EMOTE_VERBAL_OFF, iEmoOn);
		sInform_oSenderDM(oSender, "You have turned emoting animations " + sEmoOn);	
		sInform_oSenderDM(oSender, "(This function is currently inactive)");			
	}	

	if(sCmd_Word_Quantifier == "on")
	{	
		if(GetSubRace(oSender) < 49  &&  !GetHasFeat(LNG_FEAT_COMMON_D, oSender))
		{
			if(GetSubRace(oSender) != RACIAL_SUBTYPE_HUMAN )
			{		
				Add_LNG_Feats(oSender);	
			}
		}
	
	}
	
		
	if(sCmd_Word_Quantifier == "pick")
	{	
		SetLocalInt(oSender, "iCloseLanguageGUI", 1);
		
		if(	GetLevelByClass(CLASS_TYPE_ROGUE, oSender) > 0 )	
		{
			if(!GetHasFeat(StringToInt(Get2DAString(LANG_DAS_2DA, LANG_COL_FT, LNG_KALEM)), oSender) )
			{
				AddLanguageFeatToPC( oSender, LNG_KALEM );
			}
		}
		
		if(	GetLevelByClass(CLASS_TYPE_DRAGON, oSender) > 0 )	
		{
			if(!GetHasFeat(StringToInt(Get2DAString(LANG_DAS_2DA, LANG_COL_FT, LNG_DRAGON_D)), oSender) )
			{
				AddLanguageFeatToPC( oSender, LNG_DRAGON_D );
			}
		}
		
		if(	GetLevelByClass(CLASS_TYPE_CLERIC, oSender) > 0 || GetLevelByClass(CLASS_TYPE_PALADIN, oSender) > 0 )	
		{
			if(!GetHasFeat(StringToInt(Get2DAString(LANG_DAS_2DA, LANG_COL_FT, LNG_DAWN_TONGUE)), oSender) )
			{
				AddLanguageFeatToPC( oSender, LNG_DAWN_TONGUE );
			}
		}
		
		if(	GetLevelByClass(CLASS_TYPE_DRUID, oSender) > 0 )	
		{
			if(!GetHasFeat(StringToInt(Get2DAString(LANG_DAS_2DA, LANG_COL_FT, LNG_DRUID_D)), oSender) )
			{
				AddLanguageFeatToPC( oSender, LNG_DRUID_D );
			}
		}	
		Build_LanguageTable_For_GUI(oSender);
		DisplayGuiScreen(oSender, LNG_GUINAME, FALSE, LNG_XMLNAME); 
		DoLanguageListbox(oSender, LNG_GUINAME, LNG_XMLNAME);
		
	}	
	
	if(GetSubString(sCmd_Word_Quantifier, 0, 4) == "font" && iIsDM )
	{

		sLNG_PC_FontStart = GetSubString(sCmd_Word_Quantifier,4, GetStringLength(sCmd_Word_Quantifier)-4);

		
		SetLocalString( oJournal, CHAT_MY_CHAT_SUFFIX, sLNG_PC_FontStart );
		SetLocalString( oSender, CHAT_MY_CHAT_SUFFIX, sLNG_PC_FontStart );		
	
		sInform_oSenderDM(oSender, "You have set your chat style to <color="+ sLNG_PC_FontStart +">~this~" );	
	}
	
	if(GetStringLength(sCmd_Word_Quantifier) == 7 && GetSubString(sCmd_Word_Quantifier,1 , 5) == "emote")
	{
		 sLNG_PC_EmoteSymbolStart = GetSubString(sCmd_Word_Quantifier,0 , 1);
		 sLNG_PC_EmoteSymbolEnd = GetSubString(sCmd_Word_Quantifier,6 , 1);
		
		 SetLocalString( oJournal, CHAT_MY_EMO_PREFIX, sLNG_PC_EmoteSymbolStart );
		 SetLocalString( oJournal, CHAT_MY_EMO_SUFFIX, sLNG_PC_EmoteSymbolEnd );
		 SetLocalString( oSender, CHAT_MY_EMO_PREFIX, sLNG_PC_EmoteSymbolStart );
		 SetLocalString( oSender, CHAT_MY_EMO_SUFFIX, sLNG_PC_EmoteSymbolEnd );
		 		 
		sInform_oSenderDM(oSender, "You have set your emote symbols to " + sLNG_PC_EmoteSymbolStart + "emote" + sLNG_PC_EmoteSymbolEnd );		
	}

	

	
	if(GetSubString(sCmd_Word_Quantifier, 0, 4) == "list" && iIsDM)
	{
		sInform_oSenderDM(oSender, CLR_DM + GetName(oTarget)+": Languages Known" );

		int iLanguage_2DARow = 1;
		int iLanguage_Name_strRef, iLanguage_FeatID; 
		string sLanguage_Name;

		sLanguage_FeatID = Get2DAString(LANG_DAS_2DA, LANG_COL_FT, iLanguage_2DARow);
		while (sLanguage_FeatID!="")
		{
			iLanguage_FeatID = StringToInt(sLanguage_FeatID);
			if(GetLanguageKnown(oSender, iLanguage_FeatID))
			{
				sLanguage_Name = GetStringByStrRef( StringToInt(Get2DAString(LANG_DAS_2DA, LANG_COL_NAME, iLanguage_2DARow)));				
				sInform_oSenderDM(oSender, CLR_DM + sLanguage_Name +" ("+sLanguage_FeatID+")");
			}		
			iLanguage_2DARow = iLanguage_2DARow + 1;
			sLanguage_FeatID = Get2DAString(LANG_DAS_2DA, LANG_COL_FT, iLanguage_2DARow);
		}
	}	
	
	
	
}

void CMD_moditem( object oSender, object oTarget, string sCmd_Word_Quantifier )
{
	if(sCmd_Word_Quantifier == "?")		
	{
		sInform_oSenderDM(oSender,"Command: !moditem");	
		sInform_oSenderDM(oSender,"Purpose: Fires the modify item conversation. Right click on object you'd like to modify after the conversation starts.");
	} 			
	else
	{
		AssignCommand(oSender, ActionStartConversation(oSender,"vn_mdp_moditem_conversation",TRUE,FALSE));
	}
}

void CMD_morph( object oSender, object oTarget, string sCmd_Word_Quantifier )
{
	if(sCmd_Word_Quantifier == "?")		
	{
		sInform_oSenderDM(oSender,"Command: !morph ###");	
		sInform_oSenderDM(oSender,"Purpose: Polymorph the current target to creature type ###. See polymorph.2da for valid values.");
	} 			
	else
	{
		SetLocalObject(oSender, "oTarget", oTarget);
		
		DisplayInputBox (oSender, 0, "Enter POLYMORPH_TYPE", "gui_wand_polymorph_ok", "gui_wand_polymorph_cancel",
		TRUE, "", 0, "", 0, "", "");
	}
}

void CMD_motd(object oSender, object oTarget, string sCmd_Word_Quantifier )
{
	string sMotD;
	if(sCmd_Word_Quantifier == "?")		
	{
		sInform_oSenderDM(oSender,"Command: !motd xxx");	
		sInform_oSenderDM(oSender,"Purpose: Set the current Message Of The Day.");
	} 			
	else
	{
		sMotD = GetSubString(sCmd_Word_Quantifier, 0 , 99);
		SetLocalString(GetModule(),"motd",sCmd_Word_Quantifier);
		sInform_oSenderDM(oSender, "Motd set to: " + sCmd_Word_Quantifier );
	}	
}

void CMD_neutral( object oSender, object oTarget, string sCmd_Word_Quantifier )
{
	if(sCmd_Word_Quantifier == "?")		
	{
		sInform_oSenderDM(oSender,"Command: !neutral");	
		sInform_oSenderDM(oSender,"Purpose: Change current target to the Neutral faction.");
	} 			
	else
	{
		ChangeFaction(oTarget, GetObjectByTag("d2_faction_neutral"));
		sInform_oSenderDM(oSender, GetName(oTarget)+ "'s faction has been set to Neutral." );
	}


	
}

void CMD_pardon( object oSender, object oTarget, string sCmd_Word_Quantifier )
{
	if(sCmd_Word_Quantifier == "?")
	{
		sInform_oSenderDM(oSender,"Command: !pardon");	
		sInform_oSenderDM(oSender,"Purpose: Removes EOS from your current target.");
	} 
	else
	{
		std_reputation_set( oTarget, "cearguard", 80 ); std_reputation_reset( oTarget, "cearguard" );
		sInform_oSenderDM(oSender, "You have removed the EOS status from "+GetName(oTarget)+"." );
	}
}

void CMD_partychat( object oSender, object oTarget, string sCmd_Word_Quantifier )
{
	if(sCmd_Word_Quantifier == "?")		
	{
		sInform_oSenderDM(oSender,"Command: !partychat");	
		sInform_oSenderDM(oSender,"Purpose: Toggle suppression of party chat on/off. Repeat command to toggle.");
	} 			
	else
	{	
		if(GetLocalInt(oSender, SUPRESS_PARTY_CHAT_DM))
		{
			SetLocalInt(oSender, SUPRESS_PARTY_CHAT_DM, FALSE);
			sInform_oSenderDM(oSender, "Party Chat Suppress Off");
		}
		else{
			SetLocalInt(oSender, SUPRESS_PARTY_CHAT_DM, TRUE);
			sInform_oSenderDM(oSender, "Party Chat Suppress On" );
			SetLocalInt(GetModule(),MOD_LNG_SUPRESS_PARTY_CHAT, TRUE);		
		}
	}
}

void CMD_partyjump( object oSender, object oTarget, string sCmd_Word_Quantifier )
{
	object oPartyMem;
	if(sCmd_Word_Quantifier == "?")		
	{
		sInform_oSenderDM(oSender,"Command: !partyjump");	
		sInform_oSenderDM(oSender,"Purpose: Jump all players in current target's party to your location.");
	} 			
	else
	{	
		oPartyMem = GetFirstFactionMember(oTarget, FALSE);
		while (GetIsObjectValid(oPartyMem)) 
		{
			SetLocalLocation(oPartyMem,"came_from",GetLocation(oPartyMem));
			FadeToBlack(oPartyMem);
			AssignCommand(oPartyMem, JumpToLocation(GetLocation(oSender)));
			FadeFromBlack(oPartyMem);
			sInform_oSenderDM(oSender, "Target "+GetName(oPartyMem)+" has been jumped to your location. Use !back to return an individual." );
	        oPartyMem = GetNextFactionMember(oTarget, FALSE);
	    }
	}
}

void CMD_partyxp(object oSender, object oTarget, string sCmd_Word_Quantifier )
{
	int iXP;
	object oPartyMem;
	if(sCmd_Word_Quantifier == "?")		
	{
		sInform_oSenderDM(oSender,"Command: !partyxp ###");	
		sInform_oSenderDM(oSender,"Purpose: Grant ### xp to all players in current target's party.");
	} 			
	else
	{
		oPartyMem = GetFirstFactionMember(oTarget, FALSE);
		while (GetIsObjectValid(oPartyMem)) 
		{
			iXP = StringToInt(sCmd_Word_Quantifier);
			sInform_All_DMs(oSender, oTarget, GetName(oSender)+" awarded "+sCmd_Word_Quantifier+" xp to "+GetName(oPartyMem)+".");
			GiveXPToCreature(oPartyMem, iXP ); 
			oPartyMem = GetNextFactionMember(oTarget, FALSE);
	    }	
	}
}

void CMD_raise(object oSender, object oTarget, string sCmd_Word_Quantifier)
{
	if(sCmd_Word_Quantifier == "?")		
	{
		sInform_oSenderDM(oSender,"Command: !raise");	
		sInform_oSenderDM(oSender,"Purpose: Default raise the current target from the dead.");
		sInform_oSenderDM(oSender,"Option: !raise all - <i> Raise all players in your current area from the dead.");
	} 			
	else if(sCmd_Word_Quantifier == "all")
	{
	 	oTarget = GetFirstPC();
		while (GetIsObjectValid(oTarget) && GetIsPC(oTarget) && GetArea(oTarget) == GetArea(oSender))
		{
			ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectResurrection(),oTarget); 
			std_death_mark_remove( oTarget ); 
			sInform_oSenderDM(oSender, "You have raised "+GetName(oTarget)+" from the dead.");	 			
			oTarget = GetNextPC();
		}	
	}
	else
	{
		ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectResurrection(),oTarget); 
		std_death_mark_remove( oTarget ); 
		sInform_oSenderDM(oSender, "You have raised "+GetName(oTarget)+" from the dead");
	}
}

void CMD_rebel( object oSender, object oTarget, string sCmd_Word_Quantifier )
{
	if(sCmd_Word_Quantifier == "?")		
	{
		sInform_oSenderDM(oSender,"Command: !rebel");	
		sInform_oSenderDM(oSender,"Purpose: Change current target to the Rebel faction.");
	} 			
	else
	{
		ChangeFaction(oTarget, GetObjectByTag(METAFAC_REBEL_PROXY));
		sInform_oSenderDM(oSender, GetName(oTarget)+ "'s faction has been set to Rebel." );
	}
}

void CMD_removefeat(object oSender, object oTarget, string sCmd_Word_Quantifier)
{
	string sFeatRemoved;

	
	if(sCmd_Word_Quantifier == "?")		
	{
		sInform_oSenderDM(oSender,"Command: !removefeat ###");	
		sInform_oSenderDM(oSender,"Purpose: Remove feat ### from your current target.");
		sInform_oSenderDM(oSender, "Warning: Removing feats may invalidate a player character!");		
	} 			
	else
	{
		sFeatRemoved = GetStringByStrRef( StringToInt(Get2DAString("feat", "FEAT", StringToInt(sCmd_Word_Quantifier))));
		FeatRemove( oTarget, StringToInt(sCmd_Word_Quantifier));
		sInform_oSenderDM(oSender, "Removing Feats may invalidate a character!");
		sInform_oSenderDM(oSender, "Feat "+ sFeatRemoved+" removed from "+GetName(oTarget)+".");	
	}
		
}

void CMD_rename(object oSender, object oTarget, string sCmd_Word_Quantifier)
{
	int nCharacter;
	string sCharacter;
	string sFirstName;
	string sLastName;
	string sOriginalName = GetName(oTarget);

	if(sCmd_Word_Quantifier == "?")		
	{
		sInform_oSenderDM(oSender,"Command: !rename xxx");	
		sInform_oSenderDM(oSender,"Purpose: Changes the current target's name to xxx.");
	} 
	else
	{
	//copied from gui_name_change_ok - undesirable to use executescriptenhanced
	//sOriginalName = GetName(oTarget);

	switch (GetObjectType(oTarget))
	{
		//
		//	CREATURES HAVE BOTH FIRST AND LAST NAMES
		//
		case OBJECT_TYPE_CREATURE:
			//
			//	PARSE OUT FIRST NAME DELIMITED BY SPACE
			//
			nCharacter = 0;
			sCharacter = GetSubString(sCmd_Word_Quantifier, nCharacter, 1);
			while ((sCharacter != " ") && (sCharacter != ""))
			{
				sFirstName += sCharacter;
				nCharacter++;
				sCharacter = GetSubString(sCmd_Word_Quantifier, nCharacter, 1);
			}
			//
			//	PARSE OUT LAST NAME DELIMITED BY EOL
			//
			nCharacter++;
			sCharacter = GetSubString(sCmd_Word_Quantifier, nCharacter, 1);
			while (sCharacter != "")
			{
				sLastName += sCharacter;
				nCharacter++;
				sCharacter = GetSubString(sCmd_Word_Quantifier, nCharacter, 1);
			}
	
			SetFirstName(oTarget, sFirstName);
			SetLastName(oTarget, sLastName);
			break;
		//
		//	EVERYTHING ELSE ONLY HAS ONE NAME
		//	
			default:
			SetFirstName(oTarget, sCmd_Word_Quantifier);		
			break;
	}
	
	WriteTimestampedLogEntry("NAME CHANGE: " + sOriginalName + " to " + sCmd_Word_Quantifier);
	}		
	
}

void CMD_renown(object oSender, object oTarget, string sCmd_Word_Quantifier)
{
	
	if(sCmd_Word_Quantifier == "?")		
	{
		sInform_oSenderDM(oSender,"Command: !renown ###");	
		sInform_oSenderDM(oSender,"Purpose: Reward ### renown to your current target.");
	} 		
	else
	{
		changePCMetaFactionRenown(oTarget,StringToInt(sCmd_Word_Quantifier)); 
		sInform_All_DMs(oSender, oTarget, GetName(oSender)+" awarded "+ sCmd_Word_Quantifier +" renown to "+GetName(oTarget));	
		sInform_oSenderDM(oTarget,"DM rewarded you "+ sCmd_Word_Quantifier +" renown." );	
	}
		
}

void CMD_rest( object oSender, object oTarget, string sCmd_Word_Quantifier )
{
	
	if(sCmd_Word_Quantifier == "?")		
	{
		sInform_oSenderDM(oSender,"Command: !rest ###");	
		sInform_oSenderDM(oSender,"Purpose: Default, force rest your current target.");
		sInform_oSenderDM(oSender,"Option: !rest all - <i>Force rest all players in your current area.");
	} 	
	else if(sCmd_Word_Quantifier == "all")
	{
		oTarget = GetFirstPC();
		while (GetIsObjectValid(oTarget) && GetIsPC(oTarget) && GetArea(oTarget) == GetArea(oSender))
		{
			ForceRest(oTarget); 
			sInform_oSenderDM(oSender, "You have force rested " + GetName(oTarget)+".");	 			
			oTarget = GetNextPC();
		}
	}
	else
	{
		ForceRest(oTarget);
		sInform_oSenderDM(oSender, "You have force rested " + GetName(oTarget)+"." );					
	}	
}

void CMD_rez(object oSender, object oTarget, string sCmd_Word_Quantifier)
{

	if(sCmd_Word_Quantifier == "?")
	{
		sInform_oSenderDM(oSender,"Command: !rez ###");	
		sInform_oSenderDM(oSender,"Purpose: Default, resurrect your current target.");
		sInform_oSenderDM(oSender,"Option: !rez all - <i>Resurrect all players in your current area.");
	} 
	
	else if(sCmd_Word_Quantifier == "all")
	{
		oTarget = GetFirstPC();
		while (GetIsObjectValid(oTarget) && GetIsPC(oTarget) && GetArea(oTarget) == GetArea(oSender))
		{
			ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectResurrection(),oTarget); 
			std_death_mark_remove( oTarget ); 
			ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectHeal(GetMaxHitPoints(oTarget)),oTarget); 
			sInform_oSenderDM(oSender, GetName(oTarget)+ " has been resurrected." );	 			
			oTarget = GetNextPC();
		}
	}
	else
	{
		ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectResurrection(),oTarget); std_death_mark_remove( oTarget ); 
		ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectHeal(GetMaxHitPoints(oTarget)),oTarget);
		sInform_oSenderDM(oSender, GetName(oTarget)+ " has been resurrected." );	 
	}
 

 
}

void CMD_rezarea( object oSender, object oTarget, string sCmd_Word_Quantifier )
{
	object oRezTarget;

	if(sCmd_Word_Quantifier == "?")
	{
		sInform_oSenderDM(oSender,"Command: !rezarea");	
		sInform_oSenderDM(oSender,"Purpose: Used to fully resurrect all players in your current area.");
		sInform_oSenderDM(oSender,"Deprecated command, use !rez all.");		
	}	
	else
	{	
		oRezTarget = GetFirstPC();
		
		while (GetIsObjectValid(oRezTarget) && GetIsPC(oRezTarget) && GetArea(oRezTarget) == GetArea(oSender))
		{
			ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectResurrection(),oRezTarget); 
			std_death_mark_remove( oRezTarget ); 
			ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectHeal(GetMaxHitPoints(oRezTarget)),oRezTarget); 
			sInform_oSenderDM(oSender, GetName(oRezTarget)+ " has been resurrected." );	 			
			oRezTarget = GetNextPC();
		}
	}
		
}

void CMD_setdetect( object oSender, object oTarget, string sCmd_Word_Quantifier )
{
	int nDC;
	
	if(sCmd_Word_Quantifier == "?")
	{
		sInform_oSenderDM(oSender,"Command: !setdetect ###");	
		sInform_oSenderDM(oSender,"Purpose: Used to set the detect difficultly for the targeted object.");
	}
	else
	{
		nDC=StringToInt(sCmd_Word_Quantifier); 
		SetTrapDisarmDC(oTarget, nDC);
	}		
		
}

void CMD_setdisarm( object oSender, object oTarget, string sCmd_Word_Quantifier )
{
	int nDC; 

	if(sCmd_Word_Quantifier == "?")
	{
		sInform_oSenderDM(oSender,"Command: !setdisarm ###");	
		sInform_oSenderDM(oSender,"Purpose: Used to set the disarm difficultly for the targeted object.");
	}
	else
	{
		nDC=StringToInt(sCmd_Word_Quantifier); 
		SetTrapDisarmDC(oTarget, nDC);	
	}		
		
}

void CMD_setunlock( object oSender, object oTarget, string sCmd_Word_Quantifier )
{
	int nDC; 
	
	if(sCmd_Word_Quantifier == "?")
	{
		sInform_oSenderDM(oSender,"Command: !setunlock ###");	
		sInform_oSenderDM(oSender,"Purpose: Used to set the unlock difficultly for the targeted object.");
	}
	else
	{
		nDC=StringToInt(sCmd_Word_Quantifier); 
		SetLockUnlockDC(oTarget, nDC);	
	}	
	
}

void CMD_shrink( object oSender, object oTarget, string sCmd_Word_Quantifier )
{
	if(sCmd_Word_Quantifier == "?")
	{
		sInform_oSenderDM(oSender,"Command: !shrink");	
		sInform_oSenderDM(oSender,"Purpose: Used to toggle a shrink effect on/off the targeted player. Effect is of type Supernatural/Permanent.");
		sInform_oSenderDM(oSender,"Repeat command to toggle effect on and off.");
	}
	else
	{
		if (GetLocalInt(oTarget, "pcshrunk") == 1)
		{
			effect eff = GetFirstEffect(oTarget);
			
		    while (GetIsEffectValid(eff))
		    {
		    	if(GetEffectSpellId(eff) == -1066)
		        {
		        	RemoveEffect(oTarget, eff);
		 		}
		         eff=GetNextEffect(oTarget);
			}
			SetMovementRateFactor(oTarget, 1.00f);
			DeleteLocalInt(oTarget, "pcshrunk");
			sInform_oSenderDM(oSender, "Unshrinking Player "+GetName(oTarget)+".");		
		}
		else if (GetLocalInt(oTarget, "pcshrunk") != 1)
		{
	
			ApplyEffectToObject(DURATION_TYPE_PERMANENT, SetEffectSpellId(SupernaturalEffect(EffectSetScale(0.5, 0.5, 0.5)),-1066),oTarget);
			SetMovementRateFactor(oTarget, 0.5f);
			SetLocalInt(oTarget, "pcshrunk", 1);
			sInform_oSenderDM(oSender, "Shrinking Player "+GetName(oTarget)+".");		
		}
	}

	
}

void CSLOpenUrl( string sUrl, object oPlayer = OBJECT_SELF )
{
	DisplayGuiScreen( oPlayer, "SCREEN_OPENURL", TRUE, "_CSLOpenURL.xml");
	SetLocalGUIVariable( oPlayer, "SCREEN_OPENURL", 1, sUrl );
}

void CMD_sendurl( object oSender, object oTarget, string sCmd_Word_Quantifier )
{

	if(sCmd_Word_Quantifier == "?")
	{
		sInform_oSenderDM(oSender,"Command: !sendurl xxx");	
		sInform_oSenderDM(oSender,"Purpose: Used to open a pop up for the targeted player which will send them to the url ### in their web browser.");
	}
	else
	{
		CSLOpenUrl( sCmd_Word_Quantifier ,oTarget );	
	}	
	
}

void CMD_spawn( object oSender, object oTarget, string sCmd_Word_Quantifier )
{

	if(sCmd_Word_Quantifier == "?")
	{
		sInform_oSenderDM(oSender,"Command: !spawn xxx");	
		sInform_oSenderDM(oSender,"Purpose: Used to spawn a creature of resref xxx directly behind the targeted player.");
	}
	else
	{
		CreateObject(OBJECT_TYPE_CREATURE,sCmd_Word_Quantifier,CalcSafeLocation(oTarget,GetBehindLocation(oTarget),30.0,TRUE,FALSE));
	}		

}

void CMD_togencs( object oSender, object oTarget, string sCmd_Word_Quantifier )
{
  	int i;
  	object oEncounter;

	if(sCmd_Word_Quantifier == "?")
	{
		sInform_oSenderDM(oSender,"Command: !togencs");	
		sInform_oSenderDM(oSender,"Purpose: Used to toggle all ecounters for your current area off/on. Broadcasts to all DMs.");
	}
	else
	{
		i = 1;
  		oEncounter = GetNearestObject( OBJECT_TYPE_ENCOUNTER, oSender );
	
	  	while ( GetIsObjectValid( oEncounter ) )
	  	{
			if (GetEncounterActive( oEncounter ))
			{
			   // disable the encounter and flag as dm disabled
			   SetEncounterActive( 0, oEncounter );
			   SetLocalInt(oEncounter, "DM_DISABLED", 1);
			   sInform_All_DMs(oSender, oTarget, "Encounter " + GetName(oEncounter) + " in " + GetName( GetArea( oSender ) ) +
			      " switched off by " + GetName( oSender ));
			}
			// if the encounter is disabled, check to see if a dm disabled it
			else if (GetLocalInt(oEncounter, "DM_DISABLED"))
			{
			   // re-enable the encounter and clear the dm flag
			   SetEncounterActive( 1, oEncounter );
			   SetLocalInt(oEncounter, "DM_DISABLED", 0);
			   sInform_All_DMs(oSender, oTarget, "Encounter " + GetName(oEncounter) + " in " + GetName( GetArea( oSender ) ) +
			      " switched on by " + GetName( oSender ));
			}
			// otherwise, the encounter is disabled and we leave it that way
			oEncounter = GetNearestObject( OBJECT_TYPE_ENCOUNTER, oSender, ++i);
		}	
	}		   
}

void CMD_togOLM( object oSender, object oTarget, string sCmd_Word_Quantifier )
{
	object oArea;
	int bSupress;

	if(sCmd_Word_Quantifier == "?")
	{
		sInform_oSenderDM(oSender,"Command: !togolm");	
		sInform_oSenderDM(oSender,"Purpose: Used to toggle OLM ecounters off/on. Broadcasts to all DMs.");
	}
	else
	{
		oArea = GetArea(oSender);
		bSupress = GetLocalInt(oArea,"bSupress");	
	
		if (bSupress == 1)
		{
			 SetLocalInt(oArea,"bSupress",1);
			 sInform_All_DMs(oSender, oTarget,"OLM Area "+GetName(oArea)+" encounters supressed"+GetName(oSender));
		}
		if (bSupress == 0) 
		{
			 DeleteLocalInt(oArea,"bSupress");
			 sInform_All_DMs(oSender, oTarget,"OLM Area "+GetName(oArea)+" encounters enabled by "+GetName(oSender));
		}		
	}		
}

void CMD_unvis( object oSender, object oTarget, string sCmd_Word_Quantifier )
{
	effect eff;

	if(sCmd_Word_Quantifier == "?")
	{
		sInform_oSenderDM(oSender,"Command: !unvis");	
		sInform_oSenderDM(oSender,"Purpose: Removes the !invis effect. Deprecated command use !unvis off instead.");
	}
	else
	{	
		eff = GetFirstEffect(oSender);	
		SetCollision(oSender, TRUE);
		DelayCommand(2.0, SetCreatureAppearanceType(oSender, GetLocalInt(oSender, "DM_INVIS")));
	
	    while (GetIsEffectValid(eff))
	    {
	    	if(GetEffectSpellId(eff) == -55)
	        {
	        	RemoveEffect(oSender, eff);
	 		}
	         eff=GetNextEffect(oSender);
		}
	}
}
	
void CMD_where( object oSender, object oTarget, string sCmd_Word_Quantifier )
{
	string sName;
	string sAreaName;
	object oArea;
	
	int iLevel;
	
	if(sCmd_Word_Quantifier == "?")
	{
		sInform_oSenderDM(oSender,"Command: !where");	
		sInform_oSenderDM(oSender,"Purpose: List the location of all players on the server.");
	}	
	else
	{
		
		sInform_oSenderDM(oSender,"WHERE IS?");		
		oTarget = GetFirstPC();
		while(GetIsObjectValid(oTarget))
		{
			sName = GetName(oTarget);
			oArea = GetArea(oTarget);
			sAreaName = GetName(oArea);
			iLevel = GetTotalLevels(oTarget, TRUE);
			sInform_oSenderDM(oSender,sName + "("+ IntToString(iLevel) + ") is in "+ sAreaName);			
			oTarget = GetNextPC();
		}
	}
}

void CMD_xp( object oSender, object oTarget, string sCmd_Word_Quantifier )
{
	int iXP;
	
	if(sCmd_Word_Quantifier == "?")
	{
		sInform_oSenderDM(oSender,"Command: !xp +/-###");	
		sInform_oSenderDM(oSender,"Purpose: Add or subtract ### xp to the current target. Use - to remove xp. Broadcasts to all DMs.");
	}	
	else
	{
		iXP = StringToInt(sCmd_Word_Quantifier);
		if(FindSubString(sCmd_Word_Quantifier, "-") != -1)
		{
			iXP = 0 - iXP;
		}		
		sInform_All_DMs(oSender, oTarget, GetName(oSender)+" awarded "+sCmd_Word_Quantifier+" xp to "+GetName(oTarget)+".");
		GiveXPToCreature(oTarget, iXP ); 	
	}
}


void ListVars( object oSender, object oTarget)  //, string sCmd_Word_Quantifier )
{
	int iNumVar = GetVariableCount(oTarget);
	while (iNumVar >= 0)
	{
		string sVarName = GetVariableName(oTarget, iNumVar);
		int iVarType = GetVariableType(oTarget, iNumVar);
			
		if (GetVariableType(oTarget, iNumVar) == VARIABLE_TYPE_INT)
		{
			sInform_oSenderDM(oSender,"int "+sVarName+" = "+IntToString( GetVariableValueInt(oTarget,iNumVar) ));
		}
		else if (GetVariableType(oTarget, iNumVar) == VARIABLE_TYPE_FLOAT)
		{
			sInform_oSenderDM(oSender,"float "+sVarName+" = "+FloatToString( GetVariableValueFloat(oTarget,iNumVar) ));
		}
		else if (GetVariableType(oTarget, iNumVar) == VARIABLE_TYPE_STRING)
		{
			sInform_oSenderDM(oSender,"string "+sVarName+" = "+GetVariableValueString(oTarget,iNumVar) );
		}
		else if (GetVariableType(oTarget, iNumVar) == VARIABLE_TYPE_DWORD)
		{
			sInform_oSenderDM(oSender,"object "+sVarName+" = "+ObjectToString( GetVariableValueObject(oTarget,iNumVar) ));
		}
		else if (GetVariableType(oTarget, iNumVar) == VARIABLE_TYPE_LOCATION)
		{
			sInform_oSenderDM(oSender,"location "+sVarName+" = "+LocationToString( GetVariableValueLocation(oTarget,iNumVar) ));
		}
		iNumVar--;
	}
}

void CMD_vars( object oSender, object oTarget, string sCmd_Word_Quantifier )
{

	if(sCmd_Word_Quantifier == "?")
	{
		sInform_oSenderDM(oSender,"Command: !vars #");	
		sInform_oSenderDM(oSender,"Purpose: By default lists variables on currently selected target.");
		sInform_oSenderDM(oSender,"Option: !vars m - <i>lists variables on module.</i>");
		sInform_oSenderDM(oSender,"Option: !vars a - <i>lists variables on your current area.</i>");
	}
	
	else if(sCmd_Word_Quantifier == "a")
	{	
		sInform_oSenderDM(oSender,"ListVars: Area: "+GetName(GetArea(oSender)));
		ListVars( oSender, GetArea(oSender) );	
	}
	else
	{
		sInform_oSenderDM(oSender,"ListVars: Target: "+GetName(oTarget));
		ListVars( oSender, oTarget );		
	}
}

void CMD_zombie( object oSender, object oTarget, string sCmd_Word_Quantifier )
{
    effect eVis;
    effect ePoly;
    int nPoly;
    int nDuration;
	
	if(sCmd_Word_Quantifier == "?")
	{
		sInform_oSenderDM(oSender,"Command: !zombie");	
		sInform_oSenderDM(oSender,"Purpose: Zombie-ifies your target for ten turns.");
	}
	else
	{
	    eVis = EffectVisualEffect( VFX_DUR_POLYMORPH );
	    nPoly = POLYMORPH_TYPE_ZOMBIE;
	    nDuration = 10;
	
	    ePoly = EffectPolymorph(nPoly);
		ePoly = EffectLinkEffects( ePoly, eVis );
	
		//Apply the VFX impact and effects
	    AssignCommand(oTarget, ClearAllActions()); // prevents an exploit
	    
		//ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
	    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, ePoly, oTarget, TurnsToSeconds(nDuration));	
	}
}




void CMD_skillroll(int iSkillUsed, object oSender, object oTarget, string sCmd_Word_Quantifier )
{
	object oRoller = oSender;
	object oRollerTarget = oTarget;
	int iSkillRank;
	int iSkillResult;
	int iStaffDM = GetIsStoryDM(oSender);
	int iStoryDM = GetIsStaffDM(oSender);
	int iRollerIsDM;
	int iDC;
	int id20 = d20();
	int iPrivate = FALSE;
	int iTargetRolls = FALSE;;
	string sSkill_Result_Message;
	string sRollerName = GetName(oSender);
	string sRollerTargetName = GetName(oTarget);
	string sSkillUsed = ReturnSkillName(iSkillUsed);
	string sDC ="";	
	string sDisplayDC ="";
	string sSuccess ="";

	if(sCmd_Word_Quantifier == "?")
	{
		sInform_oSenderDM(oSender,"Command: !<i>Skill</i>");	
		sInform_oSenderDM(oSender,"Purpose: Make a skill roll vs your currently selected target, or the general area.");
		sInform_oSenderDM(oSender,"Option: !<i>Skill</i> ## - <i>Roll vs DC##.</i>");
		sInform_oSenderDM(oSender,"Option: !<i>Skill</i> p - <i>Make a private skill check, only you see the result.</i>");
		sInform_oSenderDM(oSender,"Option: !<i>Skill</i> t - <i>If the target selected is valid they will make a sill check. Valid targets for PC's are henchmen/familiars/summons.</i>");		
	}
	else
	{	
		
		if(iStoryDM || iStaffDM){iRollerIsDM = TRUE;}
		
		iDC = StringToInt(sCmd_Word_Quantifier);
		sDC = IntToString(iDC);
		
		
		if ( !GetIsObjectValid( oRollerTarget ))	
		{
			sRollerTargetName = SKILLROLL_GENERAL_TARGET;	
		}
		
		
		if(FindSubString(sCmd_Word_Quantifier, "t", 0) != -1)
		{
			oRoller = oTarget;
			
			if(!iRollerIsDM)
			{
				if ( GetIsObjectValid( oRoller ) && GetObjectType( oRoller ) == OBJECT_TYPE_CREATURE )
				{
					if(GetMaster(oRoller) == oSender || oRoller == GetHenchman(oSender) || (GetIsPossessedFamiliar(oSender) && oRoller == GetMaster(oSender)))
					{
						oRoller = oTarget;
						sRollerName = GetName(oTarget);
						sRollerTargetName =  SKILLROLL_GENERAL_TARGET;				
					}
					else
					{
						SendChatMessage(oRoller,oSender,CHAT_MODE_SERVER, SKILLROLL_PC_INVALID_TARGET);
						oRoller = oSender;
						sRollerName = GetName(oSender);
						sRollerTargetName = SKILLROLL_GENERAL_TARGET;						
					}
				}
				else
				{
					SendChatMessage(oRoller,oSender,CHAT_MODE_SERVER, SKILLROLL_PC_INVALID_TARGET);
					oRoller = oSender;
					sRollerName = GetName(oSender);
					sRollerTargetName = SKILLROLL_GENERAL_TARGET;	
			
				}
			}
			else
			{
			
				if ( GetIsObjectValid( oRoller ))
				{
					oRoller = oTarget;
					sRollerName = GetName(oTarget);
					sRollerTargetName =  SKILLROLL_GENERAL_TARGET;				
				}
				else
				{	
					SendChatMessage(oRoller,oSender,CHAT_MODE_SERVER, SKILLROLL_DM_INVALID_TARGET);
					oRoller = oSender;
					sRollerName = GetName(oSender);
					sRollerTargetName = SKILLROLL_GENERAL_TARGET;
				}
			}
		}
		
		iSkillRank = GetSkillRank(iSkillUsed, oRoller);
		iSkillResult = iSkillRank + id20;		
		sSkill_Result_Message = sSkill_Trained(oRoller, iSkillUsed);
			
		if(FindSubString(sCmd_Word_Quantifier, "p", 0) != -1)
		{
			iPrivate = TRUE;		
		}
		
		if(iDC != 0)
		{
			sDisplayDC = " (DC "+sDC+")";
			if(iSkillResult >= iDC)
			{
				sSuccess = SKILLROLL_SUCCESS;
			}
			else
			{
				sSuccess = SKILLROLL_FAILURE;		
			}
		}	
		
		if(sSkill_Result_Message == SKILLROLL_UNTRAINED )
		{
			sSkill_Result_Message = CLR_DM + sSkillUsed + SKILLROLL_BLURB  + sRollerTargetName + sDisplayDC + SKILLROLL_UNTRAINED +CLR_END ;
			SendChatMessage(oRoller,oSender,CHAT_MODE_SERVER,sSkill_Result_Message);
		}
		else
		{
			sSkill_Result_Message = sSkillUsed + SKILLROLL_VALID_TARGET + sRollerTargetName + sDisplayDC + CLR_NEWLINE + CLR_DM + SKILLROLL_BLURB +" D20 ("+ IntToString(id20)+ ") + Skill Mod (" + IntToString(iSkillRank) +") = "+ IntToString(iSkillResult)+CLR_END+ sSuccess;
		
			sInform_All_DMs(oRoller, oTarget, sSkill_Result_Message);
			if(iPrivate)
			{
				SendChatMessage(oRoller,oSender,CHAT_MODE_SERVER,sSkill_Result_Message);			
			}
			else
			{
				SendChatMessage(oRoller,oSender,CHAT_MODE_TALK,sSkill_Result_Message);			
			}
		}
	}
}	

void CMD_setskill( object oSender, object oTarget, string sCmd_Word_Quantifier )
{

	string sSkillList;
	
	sSkillList = "appraise; ska; bluff; skb; concentration; skcon; craftalchemy; skcal; craftarmor; skcar; crafttrap; skct; craftweapon; skcw; diplomacy; skdip; disabletrap; skdt; discipline; skdis; ";
	sSkillList = sSkillList + "heal; skhe; hide; skhi; intimidate; ski; listen; skli; lore; sklo; movesilently; skms; openlock; skol; parry; skpa; perform; skpe; ride; skr; search; skser; sensemotive; sksm; settrap; skst; ";
	sSkillList = sSkillList + "sleightofhand; sksoh; speaklanguage; sksl; spellcraft; sksc; spot; sksp; survival; sksur; taunt; skta; tumble; sktu; usemagicdevice; skumd ";
	
	if(sCmd_Word_Quantifier == "?")
	{
		sInform_oSenderDM(oSender,"Command: !setskill");	
		sInform_oSenderDM(oSender,"Purpose: Modify the skill rank of the targeted NPC. Not for use on Player Characters.");
		sInform_oSenderDM(oSender,"Useage: !setskill <i>Skill</i> XX");
		sInform_oSenderDM(oSender,"Valid skills: "+ sSkillList);
	}
	else
	{
		if(GetIsPC(oTarget))
		{
			SendChatErrorMessage( oSender, "Invalid target, you can not use this command on Player Characters");
		}
		else
		{
			int iSkillSelected, iNewRank, iBaseSkill;
			int iStringBreak = FindSubString (sCmd_Word_Quantifier, " ");		
			string sSkillSelected, sNewRank, sOutPut;
	
			effect eSkillIncrease;
			
			sSkillSelected = GetStringLeft(sCmd_Word_Quantifier, iStringBreak);
			sNewRank = GetSubString(sCmd_Word_Quantifier,iStringBreak, GetStringLength(sCmd_Word_Quantifier) - iStringBreak);	
			iSkillSelected = iReturnSkill(sSkillSelected, oSender);
			iNewRank = StringToInt(sNewRank);
			iBaseSkill = GetSkillRank(iSkillSelected, oTarget);
			iNewRank = iNewRank - iBaseSkill;
	
			sOutPut = GetName(oTarget) + " skill " + ReturnSkillName(iSkillSelected) + " set to skill rank "+ sNewRank;
			
			eSkillIncrease = EffectSkillIncrease(iSkillSelected , iNewRank);
	
			ApplyEffectToObject(DURATION_TYPE_PERMANENT,eSkillIncrease, oTarget);
			
			sInform_oSenderDM(oSender, sOutPut);
		}
	}		
}


void CMD_scry( object oSender, object oTarget, string sCmd_Word_Quantifier )
{
 	
	if(sCmd_Word_Quantifier == "?")
	{
		sInform_oSenderDM(oSender,"Command: !scry");	
		sInform_oSenderDM(oSender,"Purpose: Opens the full Scry GUI.");
	}
	else
	{
		DisplayGuiScreen(oSender, "KEMO_SCRY_PANEL", FALSE, "scry_panel.xml");
	}
}




void CMD_feats( object oSender, object oTarget, string sCmd_Word_Quantifier )	
{
	string sFeatString = GetName(oTarget) + " FEATS"+CLR_NEWLINE;
 	int iFeatInt;
	int iCounter = 0;

	if(sCmd_Word_Quantifier == "?")
	{
		sInform_oSenderDM(oSender,"Command: !feats");	
		sInform_oSenderDM(oSender,"Purpose: Lists all feats a character possesses.");
	}
	else
	{
	
		if(GetObjectType(oTarget) == OBJECT_TYPE_CREATURE) 
		{
			iFeatInt = GetNum2DARows("feat");
			
			for(iCounter;iCounter<iFeatInt;iCounter++)
			{
				if(GetHasFeat(iCounter, oTarget, FALSE))
				{
					sFeatString = sFeatString + Get2DAString("feat", "LABEL", iCounter) + " " + IntToString(iCounter) + " " + Get2DAString("feat", "FeatCategory", iCounter)  + CLR_NEWLINE;
				}
			}
		}	
	}
	sInform_oSenderDM(oSender,sFeatString);	
}


void CMD_version(object oSender, string sCmd_Word_Quantifier )
{
	if(sCmd_Word_Quantifier == "?")
	{
		sInform_oSenderDM(oSender,"Command: !version");	
		sInform_oSenderDM(oSender,"Purpose: Lists version of chat system, this is for debugging purposes.");
		sInform_oSenderDM(oSender,"After updates to this chat system you should update const string LANG_VERSION in ginc_chat_const.");		
	} 	
	else
	{
		 sInform_oSenderDM(oSender, "Current Version is : "+LANG_VERSION );
	
	}
}

void CMD_Dakhen(object oTarget )
{
	effect eFirst = GetFirstEffect(oTarget);

	FeatRemove(oTarget,3061);
	persist_advance_single( oTarget, "dakhen_curse", 1, 2, 0, "You are cured." );
   
	while (GetIsEffectValid(eFirst))
       {
	   if (GetEffectSpellId(eFirst) == 1878)
	      {
		  RemoveEffect(oTarget, eFirst);
		  return;
		  }
	   eFirst = GetNextEffect(oTarget);	  
	   }
   	
}





// ************************** FUNCTIONS for sp_togglelanguages ****************************************
//These functions control the toggling of languages via custom language feats
// sp_setlanguage
// gui_setlanguage_mode

//Purpose: Sets oSender to speak in  their selected langauge, update the language spell effect to match this.
void SetLanguageDetails(object oSender, int iLanguageNowSpokenSID, int iLanguageToSpeakSID, int iLanguageFeatInUse );

// ************************** FUNCTIONS for sp_togglelanguages ****************************************



void SetLanguageDetails(object oSender, int iLanguageNowSpokenSID, int iLanguageToSpeakSID, int iLanguageFeatInUse )
{
	string sResult;
	int iLanguage2DARow = 0;
	int iLanguageSpellEffectRow;
	int iLanguageToSpeak;
	int iLanguageVerbal;
	
	string sLanguageToSpeakSID = IntToString(iLanguageToSpeakSID);
	
	sResult = Get2DAString(LANG_DAS_2DA, LANG_COL_SID, iLanguage2DARow);
	
			while (sResult!="")
			{
				if(sResult == sLanguageToSpeakSID)
				{break;}
				else{
				iLanguage2DARow++;
				sResult = Get2DAString(LANG_DAS_2DA, LANG_COL_SID, iLanguage2DARow);
				}
			}
	
	iLanguageSpellEffectRow	= StringToInt(Get2DAString(LANG_DAS_2DA, LANG_COL_SFX, iLanguage2DARow));	
	iLanguageToSpeak = StringToInt(Get2DAString(LANG_DAS_2DA, LANG_COL_NAME, iLanguage2DARow));	
	iLanguageVerbal = StringToInt(Get2DAString(LANG_DAS_2DA, LANG_COL_VERBAL, iLanguage2DARow));	
	
	SetLocalString(oSender,LANG_SPOKEN, GetStringByStrRef(iLanguageToSpeak) );
	SetLocalInt(oSender, LANG_SPOKEN_2DA_ROW, iLanguage2DARow);
	SetLocalInt(oSender,LANG_SPOKEN_FT, iLanguageFeatInUse);
	SetLocalInt(oSender,LANG_SPOKEN_SID, iLanguageToSpeakSID);
	SetLocalInt(oSender,LANG_SPOKEN_SFX,iLanguageSpellEffectRow);
	SetLocalInt(oSender,LANG_SPOKEN_VERBAL,iLanguageVerbal);
	
	UpdateLanguageEffect(oSender, iLanguageNowSpokenSID, iLanguageToSpeakSID, iLanguageSpellEffectRow);		
	
}





//void main() {}